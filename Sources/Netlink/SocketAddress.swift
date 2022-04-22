//
//  SocketAddress.swift
//  
//
//  Created by Alsey Coleman Miller on 4/22/22.
//

import Foundation
import SystemPackage

@frozen
public struct NetlinkSocketAddress: Equatable, Hashable, SocketAddress {
        
    public typealias ProtocolID = NetlinkSocketProtocol
    
    public var processID: ProcessID
    
    public var group: CInt
    
    public init(
        processID: ProcessID = .current,
        group: CInt = 0
    ) {
        self.processID = processID
        self.group = group
    }
    
    public func withUnsafePointer<Result>(
      _ body: (UnsafePointer<CInterop.SocketAddress>, UInt32) throws -> Result
    ) rethrows -> Result {
        let address = CInterop.NetlinkSocketAddress(
            processID: processID,
            group: group
        )
        return try address.withUnsafePointer(body)
    }
    
    public static func withUnsafePointer(
        _ body: (UnsafeMutablePointer<CInterop.SocketAddress>, UInt32) throws -> ()
    ) rethrows -> Self {
        var value = CInterop.NetlinkSocketAddress()
        try value.withUnsafeMutablePointer(body)
        return Self.init(
            processID: .init(rawValue: numericCast(value.nl_pid)),
            group: .init(bitPattern: value.nl_groups)
        )
    }
}
