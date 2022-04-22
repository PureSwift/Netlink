//
//  Linux.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/29/18.
//

import Foundation
import SystemPackage

/* level and options for setsockopt() */
internal let SOL_NETLINK: CInt = 270

#if !os(Linux)

#warning("This module will only run on Linux")

public let AF_NETLINK: CInt = 16
public let PF_NETLINK: CInt = AF_NETLINK
public extension SocketAddressFamily {
    static var netlink: SocketAddressFamily { SocketAddressFamily(rawValue: AF_NETLINK) }
}

#endif
