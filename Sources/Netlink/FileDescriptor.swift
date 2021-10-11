//
//  FileDescriptor.swift
//  
//
//  Created by Alsey Coleman Miller on 10/10/21.
//

import SystemPackage
import CNetlink

public extension FileDescriptor {
    
    /// Open a Netlink socket with the specified port ID and group.
    @_alwaysEmitIntoClient
    static func netlink(
        _ netlinkProtocol: NetlinkSocketProtocol,
        portID: UInt32 = numericCast(ProcessID.current.rawValue),
        group: Int32 = 0
    ) throws -> FileDescriptor {
        
        let fileDescriptor = try FileDescriptor.socket(netlinkProtocol)
        let address = NetlinkSocketAddress(
            portID: portID,
            groups: UInt32(bitPattern: group)
        )
        do {
            try fileDescriptor.bind(address)
        }
        catch {
            try? fileDescriptor.close()
            throw error
        }
        return fileDescriptor
    }
}
