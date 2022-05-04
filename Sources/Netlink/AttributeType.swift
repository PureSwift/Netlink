//
//  NetlinkAttribute.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/7/18.
//

@_implementationOnly import CNetlink

/// Netlink Attribute Type
public struct NetlinkAttributeType: RawRepresentable, Equatable, Hashable, OptionSet {
    
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
}

// MARK: - Static Types

public extension NetlinkAttributeType {
    
    static var nested: NetlinkAttributeType { NetlinkAttributeType(rawValue: UInt16(NLA_F_NESTED)) }
    
    static var networkByteOrder: NetlinkAttributeType { NetlinkAttributeType(rawValue: UInt16(NLA_F_NET_BYTEORDER)) }
    
    enum Generic {
        
        public enum Controller {
            
            public static let familyIdentifier = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_FAMILY_ID))
            
            public static let familyName = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_FAMILY_NAME))
            
            public static let version = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_VERSION))
            
            public static let headerSize = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_HDRSIZE))
            
            public static let maxAttributes = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_MAXATTR))
            
            public static let operations = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_OPS))
            
            public static let multicastGroups = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_MCAST_GROUPS))
            
            public enum Operation {
                
                public static let identifier = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_OP_ID))
                
                public static let flags = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_OP_FLAGS))
            }
            
            public enum MulticastGroup {
                
                public static let identifier = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_MCAST_GRP_ID))
                
                public static let name = NetlinkAttributeType(rawValue: UInt16(CTRL_ATTR_MCAST_GRP_NAME))
            }
        }
    }
}
