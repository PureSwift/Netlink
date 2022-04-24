//
//  NL8021Wiphy.swift
//  
//
//  Created by Alsey Coleman Miller on 4/23/22.
//

import Foundation
import Netlink
import NetlinkGeneric

public struct NL80211Wiphy: Equatable, Hashable, Codable, Identifiable {
    
    public static var command: NetlinkGenericCommand { NetlinkGenericCommand.NL80211.getWiphy }
    
    public static var version: NetlinkGenericVersion { 0 }
    
    public let id: UInt32 // NL80211_ATTR_WIPHY
    
    public let name: String // NL80211_ATTR_WIPHY_NAME
    
    internal enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case id
        case name
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.NL80211.wiphy:
                self = .id
            case NetlinkAttributeType.NL80211.wihpyName:
                self = .name
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .id:
                return NetlinkAttributeType.NL80211.wiphy
            case .name:
                return NetlinkAttributeType.NL80211.wihpyName
            }
        }
    }
}
