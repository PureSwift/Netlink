//
//  SocketProtocol.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/6/18.
//

import Foundation
import SystemPackage
import CNetlink

/// Netlink Socket Protocol
@frozen
public struct NetlinkSocketProtocol: RawRepresentable, Equatable, Hashable {
    
    public let rawValue: Int32
    
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
}

extension NetlinkSocketProtocol: SocketProtocol {
    
    @_alwaysEmitIntoClient
    public static var family: SocketAddressFamily { .netlink }
    
    @_alwaysEmitIntoClient
    public var type: SocketType {
        return .raw
    }
}

public extension NetlinkSocketProtocol {
    
    /// Netlink Generic Protocol
    static var generic: NetlinkSocketProtocol { NetlinkSocketProtocol(rawValue: 16) }
    
    /// Netlink Routing Protocol
    static var route: NetlinkSocketProtocol { NetlinkSocketProtocol(rawValue: NETLINK_ROUTE) }
}
