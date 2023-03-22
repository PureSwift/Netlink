//
//  SocketAddress.swift
//  
//
//  Created by Alsey Coleman Miller on 4/22/22.
//

import Foundation
import SystemPackage
import Socket

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
    
    internal init(_ cValue: CInterop.NetlinkSocketAddress) {
        self.init(
            processID: ProcessID(rawValue: numericCast(cValue.nl_pid)),
            group:  .init(bitPattern: cValue.nl_groups)
        )
    }
    
    public func withUnsafePointer<Result>(
      _ body: (UnsafePointer<CInterop.SocketAddress>, UInt32) throws -> Result
    ) rethrows -> Result {
        
        let socketAddress = CInterop.NetlinkSocketAddress(
            processID: processID,
            group: group
        )
        return try socketAddress.withUnsafePointer(body)
    }
    
    public static func withUnsafePointer(
        _ pointer: UnsafeMutablePointer<CInterop.SocketAddress>
    ) -> Self {
        return pointer.withMemoryRebound(to: CInterop.NetlinkSocketAddress.self, capacity: 1) { pointer in
            return Self.init(pointer.pointee)
        }
    }
    
    public static func withUnsafePointer(
        _ body: (UnsafeMutablePointer<CInterop.SocketAddress>, UInt32) throws -> ()
    ) rethrows -> Self {
        var socketAddress = CInterop.NetlinkSocketAddress()
        try socketAddress.withUnsafeMutablePointer(body)
        return Self.init(socketAddress)
    }
}
