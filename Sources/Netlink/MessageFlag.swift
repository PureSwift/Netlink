//
//  MessageFlag.swift
//  WLAN
//
//  Created by Alsey Coleman Miller on 7/6/18.
//
//

import Foundation
@_implementationOnly import CNetlink

/// Netlink Message Flag
public struct NetlinkMessageFlag: RawRepresentable, OptionSet, Equatable, Hashable, Codable {
    
    public let rawValue: UInt16
    
    public init(rawValue: UInt16 = 0) {
        self.rawValue = rawValue
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension NetlinkMessageFlag: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt16) {
        self.init(rawValue: value)
    }
}

// MARK: - Constants

// The standard flag bits used in Netlink
public extension NetlinkMessageFlag {
    
    /// Must be set on all request messages (typically from user space to kernel space).
    static var request: NetlinkMessageFlag { NetlinkMessageFlag(rawValue: UInt16(NLM_F_REQUEST)) }
    
    /// Indicates the message is part of a multipart message terminated by `.done`.
    static var mulitpart: NetlinkMessageFlag {  NetlinkMessageFlag(rawValue: UInt16(NLM_F_MULTI)) }
    
    /// Request for an acknowledgment on success.
    /// Typical direction of request is from user
    static var acknowledgment: NetlinkMessageFlag {  NetlinkMessageFlag(rawValue: UInt16(NLM_F_ACK)) }
    
    /// Echo this request.
    /// Typical direction of request is from user space (CPC) to kernel space (FEC).
    static var echo: NetlinkMessageFlag { NetlinkMessageFlag(rawValue: UInt16(NLM_F_ECHO)) }
    
    /// Replace existing matching config object with this request.
    static var replace: NetlinkMessageFlag { NetlinkMessageFlag(rawValue: UInt16(NLM_F_REPLACE)) }
    
    /// Don't replace the config object if it already exists.
    static var exclude: NetlinkMessageFlag { NetlinkMessageFlag(rawValue: UInt16(NLM_F_EXCL)) }
    
    /// Create config object if it doesn't already exist.
    static var create: NetlinkMessageFlag { NetlinkMessageFlag(rawValue: UInt16(NLM_F_CREATE)) }
    
    /// Add to the end of the object list.
    static var append: NetlinkMessageFlag { NetlinkMessageFlag(rawValue: UInt16(NLM_F_APPEND)) }
    
    /// Return the complete table instead of a single entry.
    static var root: NetlinkMessageFlag { NetlinkMessageFlag(rawValue: UInt16(NLM_F_ROOT)) }
    
    /// Return all entries matching criteria passed in message content.
    static var match: NetlinkMessageFlag { NetlinkMessageFlag(rawValue: UInt16(NLM_F_MATCH)) }
    
    /// Return an atomic snapshot of the table being referenced.
    /// This may require special privileges because it has the potential
    /// to interrupt service in the FE for a longer time.
    static var atomic: NetlinkMessageFlag { NetlinkMessageFlag(rawValue: UInt16(NLM_F_ATOMIC)) }
    
    /// This is `NLM_F_ROOT` or'ed with `NLM_F_MATCH`.
    static var dump: NetlinkMessageFlag { [root, atomic] }
}
