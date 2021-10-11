//
//  SocketAddress.swift
//  
//
//  Created by Alsey Coleman Miller on 10/10/21.
//

import SystemPackage
import CNetlink

/// Netlink Socket Address
@frozen
public struct NetlinkSocketAddress: SocketAddress, Equatable, Hashable {
    
    /// Socket Address Family
    @_alwaysEmitIntoClient
    public static var family: SocketAddressFamily { return .netlink }
    
    /// Port ID
    public var portID: UInt32
    
    /// Multicast groups mask.
    public var groups: UInt32
    
    @_alwaysEmitIntoClient
    public init(portID: UInt32 = numericCast(ProcessID.current.rawValue),
                groups: UInt32 = 0) {
        
        self.portID = portID
        self.groups = groups
    }
    
    /// Unsafe pointer closure
    public func withUnsafePointer<Result>(
      _ body: (UnsafePointer<CInterop.SocketAddress>, UInt32) throws -> Result
    ) rethrows -> Result {
        let socketAddress = sockaddr_nl(
            nl_family: .init(Self.family.rawValue),
            nl_pad: 0,
            nl_pid: portID,
            nl_groups: groups
        )
        return try socketAddress.withUnsafePointer(body)
    }
}

internal extension NetlinkSocketAddress {
    
    @inline(__always)
    static var zero: NetlinkSocketAddress {
        return NetlinkSocketAddress(
            portID: 0,
            groups: 0
        )
    }
}

extension sockaddr_nl: CSocketAddress {
    
    /// Socket Address Family
    @_alwaysEmitIntoClient
    public static var family: SocketAddressFamily { return .netlink }
}
