//
//  NL80211ScanResult.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/29/18.
//


import Foundation
import Netlink
import NetlinkGeneric

public struct NL80211ScanResult {
    
    public static var command: NetlinkGenericCommand { NetlinkGenericCommand.NL80211.newScanResults }
    
    public static var version: NetlinkGenericVersion { 0 }
    
    public let generation: UInt32
    
    public let interface: UInt32
    
    public let wirelessDevice: UInt64
    
    public let bss: BSS
}

public extension NL80211ScanResult {
    
    struct BSS {
        
        public let bssid: BSSID
        
        public let informationElements: Data
    }
}

// MARK: - Codable

extension NL80211ScanResult: Codable {
    
    internal enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case bss
        case generation
        case interfaceIndex
        case wirelessDevice
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.NL80211.bss:
                self = .bss
            case NetlinkAttributeType.NL80211.generation:
                self = .generation
            case NetlinkAttributeType.NL80211.interfaceIndex:
                self = .interfaceIndex
            case NetlinkAttributeType.NL80211.wirelessDevice:
                self = .wirelessDevice
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .bss:
                return NetlinkAttributeType.NL80211.bss
            case .generation:
                return NetlinkAttributeType.NL80211.generation
            case .interfaceIndex:
                return NetlinkAttributeType.NL80211.interfaceIndex
            case .wirelessDevice:
                return NetlinkAttributeType.NL80211.wirelessDevice
            }
        }
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.interface = try container.decode(UInt32.self, forKey: .interfaceIndex)
        self.generation = try container.decode(UInt32.self, forKey: .generation)
        self.wirelessDevice = try container.decode(UInt64.self, forKey: .wirelessDevice)
        self.bss = try container.decode(BSS.self, forKey: .bss)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(bss, forKey: .bss)
        try container.encode(interface, forKey: .interfaceIndex)
        try container.encode(generation, forKey: .generation)
        try container.encode(wirelessDevice, forKey: .wirelessDevice)
    }
}

extension NL80211ScanResult.BSS: Codable {
    
    internal enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case bssid
        case informationElements
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.NL80211.BSS.bssid:
                self = .bssid
            case NetlinkAttributeType.NL80211.BSS.informationElements:
                self = .informationElements
            default:
                return nil
            }
        }
        
        var attribute: NetlinkAttributeType {
            
            switch self {
            case .bssid:
                return NetlinkAttributeType.NL80211.BSS.bssid
            case .informationElements:
                return NetlinkAttributeType.NL80211.BSS.informationElements
            }
        }
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.bssid = try container.decode(NL80211ScanResult.BSSID.self, forKey: .bssid)
        self.informationElements = try container.decode(Data.self, forKey: .informationElements)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(bssid, forKey: .bssid)
        try container.encode(informationElements, forKey: .informationElements)
    }
}

extension NL80211ScanResult {
    
    /// WLAN BSSID.
    ///
    /// Represents a unique 48-bit identifier that follows MAC address conventions.
    public struct BSSID {
        
        // MARK: - ByteValueType
        
        /// Raw BSSID 6 byte (48 bit) value.
        public typealias ByteValue = (UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)
        
        // MARK: - Properties
        
        public var bytes: ByteValue
        
        // MARK: - Initialization
        
        public init(bytes: ByteValue = (0, 0, 0, 0, 0, 0)) {
            
            self.bytes = bytes
        }
    }
}

extension NL80211ScanResult.BSSID: CustomStringConvertible {
    
    public var description: String {
        
        return String(format: "%x:%x:%x:%x:%x:%x", bytes.0, bytes.1, bytes.2, bytes.3, bytes.4, bytes.5).uppercased()
    }
}

extension NL80211ScanResult.BSSID: Codable {
    
    public enum DecodingError: Error {
        
        case invalidData(Data)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        guard let bigEndianValue = NL80211ScanResult.BSSID(data: data)
            else { throw DecodingError.invalidData(data) }
        self = bigEndianValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        // store as big endian representation
        try container.encode(data)
    }
}

public extension NL80211ScanResult.BSSID {
    
    internal static var length: Int { return 6 }
    
    init?(data: Data) {
        
        guard data.count == type(of: self).length
            else { return nil }
        
        self.bytes = (data[0], data[1], data[2], data[3], data[4], data[5])
    }
    
    var data: Data {
        return Data([bytes.0, bytes.1, bytes.2, bytes.3, bytes.4, bytes.5])
    }
}
