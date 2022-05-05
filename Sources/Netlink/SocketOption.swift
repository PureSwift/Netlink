//
//  SocketOption.swift
//  
//
//  Created by Alsey Coleman Miller on 4/22/22.
//

import Foundation
import SystemPackage
import Socket
@_implementationOnly import CNetlink

/// Netlink Socket Option
public struct NetlinkSocketOption: RawRepresentable, Equatable, Hashable, SocketOptionID {
    
    @_alwaysEmitIntoClient
    public static var optionLevel: SocketOptionLevel { .netlink }
    
    public let rawValue: CInt
    
    @_alwaysEmitIntoClient
    public init(rawValue: CInt) {
        self.rawValue = rawValue
    }
    
    @_alwaysEmitIntoClient
    internal init(_ raw: CInt) {
        self.init(rawValue: raw)
    }
}

public extension NetlinkSocketOption {
    
    @_alwaysEmitIntoClient
    static var addMembership: NetlinkSocketOption { NetlinkSocketOption(NETLINK_ADD_MEMBERSHIP) }
    
    @_alwaysEmitIntoClient
    static var dropMembership: NetlinkSocketOption { NetlinkSocketOption(NETLINK_DROP_MEMBERSHIP) }
}

public extension NetlinkSocketOption {
    
    struct AddMembership: SocketOption {
        
        @_alwaysEmitIntoClient
        public static var id: NetlinkSocketOption { .addMembership }
        
        public var group: CInt
        
        public init(group: CInt) {
            self.group = group
        }
        
        public func withUnsafeBytes<Result>(_ pointer: ((UnsafeRawBufferPointer) throws -> (Result))) rethrows -> Result {
            return try Swift.withUnsafeBytes(of: group) { bufferPointer in
                try pointer(bufferPointer)
            }
        }
        
        public static func withUnsafeBytes(_ body: (UnsafeMutableRawBufferPointer) throws -> ()) rethrows -> Self {
            var value: CInt = 0
            try Swift.withUnsafeMutableBytes(of: &value, body)
            return self.init(group: value)
        }
    }
    
    struct DropMembership: SocketOption {
        
        @_alwaysEmitIntoClient
        public static var id: NetlinkSocketOption { .dropMembership }
        
        public var group: CInt
        
        public init(group: CInt) {
            self.group = group
        }
        
        public func withUnsafeBytes<Result>(_ pointer: ((UnsafeRawBufferPointer) throws -> (Result))) rethrows -> Result {
            return try Swift.withUnsafeBytes(of: group) { bufferPointer in
                try pointer(bufferPointer)
            }
        }
        
        public static func withUnsafeBytes(_ body: (UnsafeMutableRawBufferPointer) throws -> ()) rethrows -> Self {
            var value: CInt = 0
            try Swift.withUnsafeMutableBytes(of: &value, body)
            return self.init(group: value)
        }
    }
}
