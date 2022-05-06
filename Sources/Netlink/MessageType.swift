//
//  MessageType.swift
//  WLAN
//
//  Created by Alsey Coleman Miller on 7/6/18.
//
//

import Foundation
@_implementationOnly import CNetlink

/**
 Netlink Message Type
 
 Netlink differs between requests, notifications, and replies. Requests are messages which have the NLM_F_REQUEST flag set and are meant to request an action from the receiver. A request is typically sent from a userspace process to the kernel. While not strictly enforced, requests should carry a sequence number incremented for each request sent.
 
 Depending on the nature of the request, the receiver may reply to the request with another netlink message. The sequence number of a reply must match the sequence number of the request it relates to.
 
 Notifications are of informal nature and no reply is expected, therefore the sequence number is typically set to 0.
 
 - SeeAlso: [Netlink Library](https://www.infradead.org/%7Etgr/libnl/doc/core.html#core_addressing)
 */
public struct NetlinkMessageType: RawRepresentable, Equatable, Hashable {
    
    public let rawValue: UInt16
    
    public init(rawValue: UInt16 = 0) {
        
        self.rawValue = rawValue
    }
}

// MARK: - Types

public extension NetlinkMessageType {
    
    /// No operation, message must be discarded
    static var none: NetlinkMessageType { NetlinkMessageType(rawValue: UInt16(NLMSG_NOOP)) }
    
    /// The message signals an error and the payload
    /// contains a nlmsgerr structure.  This can be looked
    /// at as a NACK and typically it is from FEC to CPC.
    static var error: NetlinkMessageType { NetlinkMessageType(rawValue: UInt16(NLMSG_ERROR)) }
    
    /// Message terminates a multipart message.
    static var done: NetlinkMessageType { NetlinkMessageType(rawValue: UInt16(NLMSG_DONE)) }
    
    /// Overrun notification (Error). 
    static var overrun: NetlinkMessageType { NetlinkMessageType(rawValue: UInt16(NLMSG_OVERRUN)) }
}
