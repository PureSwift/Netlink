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

#if os(Linux)
internal let SOCK_RAW = CInt(Glibc.SOCK_RAW.rawValue)
#elseif canImport(Darwin)
internal let AF_NETLINK: CInt = 16
internal let PF_NETLINK: CInt = AF_NETLINK
#endif
