//
//  NL80211GetScanResultsCommand.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/28/18.
//

import Foundation
import Netlink
import NetlinkGeneric

public struct NL80211GetScanResultsCommand {
    
    public static let command = NetlinkGenericCommand.NL80211.getScan
    
    public static let version: NetlinkGenericVersion = 0
    
    public var interface: UInt32
    
    public init(interface: UInt32) {
        self.interface = interface
    }
}

extension NL80211GetScanResultsCommand: Codable {
    
    internal enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case interfaceIndex
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.NL80211.interfaceIndex:
                self = .interfaceIndex
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .interfaceIndex:
                return NetlinkAttributeType.NL80211.interfaceIndex
            }
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let interfaceIndex = try container.decode(UInt32.self, forKey: .interfaceIndex)
        self.init(interface: interfaceIndex)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interface, forKey: .interfaceIndex)
    }
}
