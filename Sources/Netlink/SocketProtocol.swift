//
//  SocketProtocol.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/6/18.
//

#if os(Linux)
import Glibc
#elseif os(macOS) || os(iOS)
import Darwin.C
#endif

import Foundation
import CNetlink

/// Netlink Socket Protocol
public struct NetlinkSocketProtocol: RawRepresentable {
    
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
}

public extension NetlinkSocketProtocol {
    
    /// Netlink Generic Protocol
    static var generic: NetlinkSocketProtocol { NetlinkSocketProtocol(rawValue: 16) }
    
    /// Netlink Routing Protocol
    static var route: NetlinkSocketProtocol { NetlinkSocketProtocol(rawValue: NETLINK_ROUTE) }
}
