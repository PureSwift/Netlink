//
//  Linux.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/29/18.
//

import SystemPackage

#if !os(Linux)
#warning("This code only runs on Linux")

internal func stub(function: StaticString = #function) -> Never {
    fatalError("This code only runs on Linux")
}

internal extension SocketAddressFamily {
    
    @usableFromInline
    static var netlink: SocketAddressFamily { SocketAddressFamily(rawValue: AF_NETLINK) }
}

internal extension SocketOptionLevel {
    
    @usableFromInline
    static var netlink: SocketOptionLevel { SocketOptionLevel(rawValue: SOL_NETLINK) }
}

internal let SOL_NETLINK: CInt = 270
internal let AF_NETLINK: CInt = 16
#endif
