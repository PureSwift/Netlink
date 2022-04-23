//
//  NetlinkGetGenericFamilyIdentifierCommand.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/28/18.
//

import Foundation
import Netlink

public struct NetlinkGetGenericFamilyIdentifierCommand: Equatable, Hashable, Codable {
    
    public static var command: NetlinkGenericCommand { .getFamily }
    
    public static var version: NetlinkGenericVersion { 1 }
    
    public var name: NetlinkGenericFamilyName
    
    public init(name: NetlinkGenericFamilyName) {
        self.name = name
    }
}

internal extension NetlinkGetGenericFamilyIdentifierCommand {
    
    enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case name
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.Generic.Controller.familyName:
                self = .name
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .name:
                return NetlinkAttributeType.Generic.Controller.familyName
            }
        }
    }
}
