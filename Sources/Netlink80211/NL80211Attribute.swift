//
//  NL80211Attribute.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/7/18.
//

import Foundation
import Netlink
import CNetlink

public extension NetlinkAttributeType {
    
    /// 802.11 netlink interface
    enum NL80211 {
        
        public static var wiphy: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_WIPHY) }
        
        public static var wihpyName: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_WIPHY_NAME) }
        
        public static var wihpyFrequency: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_WIPHY_FREQ) }
        
        public static var interfaceIndex: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_IFINDEX) }
        
        public static var interfaceName: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_IFNAME) }
        
        public static var interfaceType: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_IFTYPE) }
        
        public static var macAddress: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_MAC) }
        
        public static var bss: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_BSS) }
        
        public static var scanFrequencies: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_SCAN_FREQUENCIES) }
        
        public static var scanSSIDs: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_SCAN_SSIDS) }
        
        public static var generation: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_GENERATION) }
        
        public static var wirelessDevice: NetlinkAttributeType { NetlinkAttributeType(NL80211_ATTR_WDEV) }
        
        /// Netlink attributes for BSS
        public enum BSS {
            
            public static var bssid: NetlinkAttributeType { NetlinkAttributeType(NL80211_BSS_BSSID) }
            
            public static var informationElements: NetlinkAttributeType { NetlinkAttributeType(NL80211_BSS_INFORMATION_ELEMENTS) }
        }
    }
}

fileprivate extension NetlinkAttributeType {
    
    init(_ nl80211Attribute: nl80211_attrs) {
        self.init(rawValue: UInt16(nl80211Attribute.rawValue))
    }
}

fileprivate extension NetlinkAttributeType {
    
    init(_ nl80211Attribute: nl80211_bss) {
        self.init(rawValue: UInt16(nl80211Attribute.rawValue))
    }
}
