//
//  Linux.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/29/18.
//

import Foundation
import SystemPackage

#if !os(Linux)
#warning("This code only runs on Linux")

internal func stub(function: StaticString = #function) -> Never {
    fatalError("This code only runs on Linux")
}

internal extension SocketAddressFamily {
    
    @usableFromInline
    static var netlink: SocketAddressFamily { stub() }
}

/* level and options for setsockopt() */
internal let SOL_NETLINK: CInt = 270
internal let AF_NETLINK: CInt = 16
internal let PF_NETLINK: CInt = AF_NETLINK
#endif
