//
//  SocketProtocol.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/6/18.
//

import SystemPackage
import CNetlink

/// Netlink Socket Protocol
public enum NetlinkSocketProtocol: Int32, Codable {
    
    /// Generic Netlink Protocol
    case generic
    
    /* Receives routing and link updates and may be used to
     modify the routing tables (both IPv4 and IPv6), IP
     addresses, link parameters, neighbor setups, queueing
     disciplines, traffic classes, and packet classifiers. */
    case route
    /*
    /// Messages from 1-wire subsystem.
    case wire1
    */
    /// Reserved for user-mode socket protocols.
    case user
    
    /* Transport IPv4 packets from netfilter to user space.  Used
     by ip_queue kernel module.  After a long period of being
     declared obsolete (in favor of the more advanced
     nfnetlink_queue feature), NETLINK_FIREWALL was removed in
     Linux 3.5. */
    case firewall
    
    /// Query information about sockets of various protocol families from the kernel.
    case socketDiagnosis
    
    /// Netfilter/iptables ULOG.
    case netfilterLog
    
    /// IPsec
    case xfrm
    
    /// SELinux event notifications.
    case selinux
    
    /// Open-iSCSI.
    case iscsi
    
    /// Auditing.
    case audit
    
    /// Access to FIB lookup from user space.
    case fibLookup
    
    /// Kernel connector.
    case connector
    
    /// Netfilter subsystem.
    case netfilter
    
    /// SCSI Transports.
    case scsiTransports
    
    /// Infiniband RDMA.
    case rdma
    
    /// Transport IPv6 packets from netfilter to user space.
    case ipv6Forward
    
    /// DECnet routing messages.
    case decnetRoute
    
    /// Kernel messages to user space.
    case uevent
    
    /// Netlink interface to request information about ciphers
    /// registered with the kernel crypto API as well as allow
    /// configuration of the kernel crypto API.
    case crypto
}

extension NetlinkSocketProtocol: SocketProtocol {
    
    @_alwaysEmitIntoClient
    public static var family: SocketAddressFamily { return .netlink }
    
    @_alwaysEmitIntoClient
    public var type: SocketType {
        /* Netlink is a datagram-oriented service.  Both SOCK_RAW and
         SOCK_DGRAM are valid values for socket_type.  However, the
         netlink protocol does not distinguish between datagram and raw
         sockets.*/
        return .raw
    }
    
    @_alwaysEmitIntoClient
    public var rawValue: Int32 {
        switch self {
        case .generic:          return NETLINK_GENERIC
        case .route:            return NETLINK_ROUTE
        //case .wire1:          return NETLINK_ONEWIRE
        case .user:             return NETLINK_USERSOCK
        case .firewall:         return NETLINK_FIREWALL
        case .socketDiagnosis:  return NETLINK_SOCK_DIAG
        case .netfilterLog:     return NETLINK_NFLOG
        case .xfrm:             return NETLINK_XFRM
        case .selinux:          return NETLINK_SELINUX
        case .iscsi:            return NETLINK_ISCSI
        case .audit:            return NETLINK_AUDIT
        case .fibLookup:        return NETLINK_FIB_LOOKUP
        case .connector:        return NETLINK_CONNECTOR
        case .netfilter:        return NETLINK_NETFILTER
        case .scsiTransports:   return NETLINK_SCSITRANSPORT
        case .rdma:             return NETLINK_RDMA
        case .ipv6Forward:      return NETLINK_IP6_FW
        case .decnetRoute:      return NETLINK_DNRTMSG
        case .uevent:           return NETLINK_KOBJECT_UEVENT
        case .crypto:           return NETLINK_CRYPTO
        }
    }
}
