//
//  CInterop.swift
//  
//
//  Created by Alsey Coleman Miller on 4/22/22.
//

import SystemPackage
import CNetlink
#if canImport(Glibc)
import Glibc
#endif

public extension CInterop {
    
    typealias NetlinkSocketAddress = sockaddr_nl
}

internal extension CInterop.NetlinkSocketAddress {
    
    init(
        processID: ProcessID = .current,
        group: CInt = 0
    ) {
        self.init(nl_family: __kernel_sa_family_t(AF_NETLINK),
                  nl_pad: UInt16(),
                  nl_pid: __u32(processID.rawValue),
                  nl_groups: __u32(bitPattern: group))
    }
}

extension CInterop.NetlinkSocketAddress: CSocketAddress {
    
    @usableFromInline
    static var family: SocketAddressFamily { .netlink }
}
