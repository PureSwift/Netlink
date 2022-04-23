//
//  NL80211GetInterfaceCommand.swift
//  
//
//  Created by Alsey Coleman Miller on 4/23/22.
//

import Foundation
import Netlink
import NetlinkGeneric

public struct NL80211Interface: Equatable, Hashable, Codable, Identifiable {
    
    public static var command: NetlinkGenericCommand { NetlinkGenericCommand.NL80211.getInterface }
    
    public static var version: NetlinkGenericVersion { 0 }
    
    public let id: UInt32 // NL80211_ATTR_IFINDEX
    
    public let name: String // NL80211_ATTR_IFNAME
    
    public let macAddress: Data // NL80211_ATTR_MAC
    
    public let phy: UInt32 // NL80211_ATTR_WIPHY
    
    public let type: UInt32 // NL80211_ATTR_IFTYPE
    
    public let device: UInt64 // NL80211_ATTR_WDEV
    
    public let frequency: UInt32 // NL80211_ATTR_WIPHY_FREQ
    
    internal enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case id
        case name
        case macAddress
        case phy
        case type
        case device
        case frequency
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.NL80211.interfaceIndex:
                self = .id
            case NetlinkAttributeType.NL80211.interfaceName:
                self = .name
            case NetlinkAttributeType.NL80211.macAddress:
                self = .macAddress
            case NetlinkAttributeType.NL80211.wiphy:
                self = .phy
            case NetlinkAttributeType.NL80211.interfaceType:
                self = .type
            case NetlinkAttributeType.NL80211.wirelessDevice:
                self = .device
            case NetlinkAttributeType.NL80211.wihpyFrequency:
                self = .frequency
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .id:
                return NetlinkAttributeType.NL80211.interfaceIndex
            case .name:
                return NetlinkAttributeType.NL80211.interfaceName
            case .macAddress:
                return NetlinkAttributeType.NL80211.macAddress
            case .phy:
                return NetlinkAttributeType.NL80211.wiphy
            case .type:
                return NetlinkAttributeType.NL80211.interfaceType
            case .device:
                return NetlinkAttributeType.NL80211.wirelessDevice
            case .frequency:
                return NetlinkAttributeType.NL80211.wihpyFrequency
            }
        }
    }
}
