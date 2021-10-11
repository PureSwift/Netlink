//
//  SocketOption.swift
//  
//
//  Created by Alsey Coleman Miller on 10/10/21.
//

import SystemPackage
import CNetlink

/// Netlink Socket Option
public enum NetlinkSocketOption: Int32, SocketOptionID {
    
    /// Add membership
    case addMembership
    
    /// Remove membership
    case removeMembership
    
    @_alwaysEmitIntoClient
    public static var optionLevel: SocketOptionLevel { .netlink }
    
    @_alwaysEmitIntoClient
    public var rawValue: Int32 {
        switch self {
        case .addMembership:    return NETLINK_ADD_MEMBERSHIP
        case .removeMembership: return NETLINK_DROP_MEMBERSHIP
        }
    }
    
}

public extension NetlinkSocketOption {
    
    struct AddMembership: Equatable, Hashable, SocketOption {
        
        public var group: Int32
        
        public init(group: Int32) {
            self.group = group
        }
                
        public static var id: NetlinkSocketOption { .addMembership }
        
        public func withUnsafeBytes<Result>(_ pointer: ((UnsafeRawBufferPointer) throws -> (Result))) rethrows -> Result {
            return try Swift.withUnsafeBytes(of: group) { bufferPointer in
                try pointer(bufferPointer)
            }
        }
        
        public static func withUnsafeBytes(
            _ body: (UnsafeMutableRawBufferPointer) throws -> ()
        ) rethrows -> Self {
            var value: CInt = 0
            try Swift.withUnsafeMutableBytes(of: &value, body)
            return Self.init(group: value)
        }
    }
    
    struct RemoveMembership: Equatable, Hashable, SocketOption {
        
        public var group: Int32
        
        public init(group: Int32) {
            self.group = group
        }
                
        public static var id: NetlinkSocketOption { .removeMembership }
        
        public func withUnsafeBytes<Result>(_ pointer: ((UnsafeRawBufferPointer) throws -> (Result))) rethrows -> Result {
            return try Swift.withUnsafeBytes(of: group) { bufferPointer in
                try pointer(bufferPointer)
            }
        }
        
        public static func withUnsafeBytes(
            _ body: (UnsafeMutableRawBufferPointer) throws -> ()
        ) rethrows -> Self {
            var value: CInt = 0
            try Swift.withUnsafeMutableBytes(of: &value, body)
            return Self.init(group: value)
        }
    }
}
