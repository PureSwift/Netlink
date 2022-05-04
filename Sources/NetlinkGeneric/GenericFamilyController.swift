//
//  GenericController.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/28/18.
//

import Foundation
import Netlink
@_implementationOnly import CNetlink

/// Netlink Generic Family Controller
public struct NetlinkGenericFamilyController: Equatable, Hashable, Codable, Identifiable {
    
    public let id: NetlinkGenericFamilyIdentifier
    
    public var name: NetlinkGenericFamilyName
    
    public var version: UInt32
    
    public var headerSize: UInt32
    
    public var maxAttributes: UInt32
    
    public var operations: [Operation]
    
    public var multicastGroups: [MulticastGroup]
}

public extension NetlinkGenericFamilyController {
    
    struct Operation: Equatable, Hashable, Codable, Identifiable {
        
        public let id: UInt32
        
        public var flags: UInt32
    }
}

public extension NetlinkGenericFamilyController {
    
    struct MulticastGroup: Equatable, Hashable, Codable, Identifiable {
        
        public let id: NetlinkGenericMulticastGroupIdentifier
        
        public let name: NetlinkGenericMulticastGroupName
    }
}

// MARK: - Request

public extension NetlinkSocket {
    
    /// Query the family name.
    func resolve(name: NetlinkGenericFamilyName, sequence: UInt32 = 0) async throws -> NetlinkGenericFamilyController {
        
        guard netlinkProtocol == .generic
            else { throw NetlinkSocketError.invalidProtocol }
        
        let command = NetlinkGetGenericFamilyIdentifierCommand(name: name)
        let encoder = NetlinkAttributeEncoder()
        let commandData = try encoder.encode(command)
        
        let message = NetlinkGenericMessage(
            type: NetlinkMessageType(rawValue: UInt16(GENL_ID_CTRL)),
            flags: .request,
            sequence: sequence,
            process: 0, // kernel
            command: .getFamily,
            version: 1,
            payload: commandData
        )
        
        // send message to kernel
        try await send(message.data)
        let recievedData = try await recieve()
        
        let decoder = NetlinkAttributeDecoder()
        
        // parse response
        guard let messages = try? NetlinkGenericMessage.from(data: recievedData),
            let response = messages.first,
            let controller = try? decoder.decode(NetlinkGenericFamilyController.self, from: response)
            else { throw NetlinkSocketError.invalidData(recievedData) }
        
        return controller
    }
}

// MARK: - Codable

extension NetlinkGenericFamilyController {
    
    enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case id
        case name
        case version
        case headerSize
        case maxAttributes
        case operations
        case multicastGroups
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.Generic.Controller.familyIdentifier:
                self = .id
            case NetlinkAttributeType.Generic.Controller.familyName:
                self = .name
            case NetlinkAttributeType.Generic.Controller.version:
                self = .version
            case NetlinkAttributeType.Generic.Controller.headerSize:
                self = .headerSize
            case NetlinkAttributeType.Generic.Controller.maxAttributes:
                self = .maxAttributes
            case NetlinkAttributeType.Generic.Controller.operations:
                self = .operations
            case NetlinkAttributeType.Generic.Controller.multicastGroups:
                self = .multicastGroups
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .id:
                return NetlinkAttributeType.Generic.Controller.familyIdentifier
            case .name:
                return NetlinkAttributeType.Generic.Controller.familyName
            case .version:
                return NetlinkAttributeType.Generic.Controller.version
            case .headerSize:
                return NetlinkAttributeType.Generic.Controller.headerSize
            case .maxAttributes:
                return NetlinkAttributeType.Generic.Controller.maxAttributes
            case .operations:
                return NetlinkAttributeType.Generic.Controller.operations
            case .multicastGroups:
                return NetlinkAttributeType.Generic.Controller.multicastGroups
            }
        }
    }
}

extension NetlinkGenericFamilyController.Operation {
    
    enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case id
        case flags
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.Generic.Controller.Operation.identifier:
                self = .id
            case NetlinkAttributeType.Generic.Controller.Operation.flags:
                self = .flags
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .id:
                return NetlinkAttributeType.Generic.Controller.Operation.identifier
            case .flags:
                return NetlinkAttributeType.Generic.Controller.Operation.flags
            }
        }
    }
}

extension NetlinkGenericFamilyController.MulticastGroup {
    
    enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case id
        case name
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.Generic.Controller.MulticastGroup.identifier:
                self = .id
            case NetlinkAttributeType.Generic.Controller.MulticastGroup.name:
                self = .name
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .id:
                return NetlinkAttributeType.Generic.Controller.MulticastGroup.identifier
            case .name:
                return NetlinkAttributeType.Generic.Controller.MulticastGroup.name
            }
        }
    }
}
