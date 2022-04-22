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
    
    typealias NetlinkMessageHeader = nlmsghdr
}

internal extension CInterop.NetlinkSocketAddress {
    
    init(
        processID: ProcessID = .current,
        group: CInt = 0
    ) {
        self.init(
            nl_family: CInterop.SocketAddressFamily(AF_NETLINK),
            nl_pad: UInt16(),
            nl_pid: __u32(processID.rawValue),
            nl_groups: __u32(bitPattern: group)
        )
    }
    
    static var zero: CInterop.NetlinkSocketAddress {
        .init(
            nl_family: CInterop.SocketAddressFamily(AF_NETLINK),
            nl_pad: 0,
            nl_pid: 0,
            nl_groups: 0
        )
    }
}

extension CInterop.NetlinkSocketAddress: CSocketAddress {
    
    @usableFromInline
    static var family: SocketAddressFamily { .netlink }
}

internal extension CInterop.NetlinkMessageHeader {
    
    init(_ header: NetlinkMessageHeader) {
        
        self.init(
            nlmsg_len: __u32(header.length),
            nlmsg_type: __u16(header.type.rawValue),
            nlmsg_flags: __u16(header.flags.rawValue),
            nlmsg_seq: __u32(header.sequence),
            nlmsg_pid: __u32(header.process)
        )
    }
}
