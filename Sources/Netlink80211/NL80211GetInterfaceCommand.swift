//
//  NL80211GetInterfaceCommand.swift
//  
//
//  Created by Alsey Coleman Miller on 4/23/22.
//

import Foundation
import Netlink
import NetlinkGeneric

public struct NL80211GetInterfaceCommand: Equatable, Hashable, Codable {
    
    public static var command: NetlinkGenericCommand { NetlinkGenericCommand.NL80211.getInterface }
    
    public static var version: NetlinkGenericVersion { 0 }
    
    public let interface: UInt32 // NL80211_ATTR_IFINDEX
    
    public init(interface: UInt32) {
        self.interface = interface
    }
    
    internal enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case interface
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.NL80211.interfaceIndex:
                self = .interface
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .interface:
                return NetlinkAttributeType.NL80211.interfaceIndex
            }
        }
    }
}
