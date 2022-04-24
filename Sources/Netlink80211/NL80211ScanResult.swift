//
//  NL80211ScanResult.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/29/18.
//


import Foundation
import Netlink
import NetlinkGeneric

public struct NL80211ScanResult: Equatable, Hashable, Codable {
    
    public static var command: NetlinkGenericCommand { NetlinkGenericCommand.NL80211.newScanResults }
    
    public static var version: NetlinkGenericVersion { 0 }
    
    public let generation: UInt32?
    
    public let interface: UInt32
    
    public let wirelessDevice: UInt64
    
    public let bss: BSS
}

public extension NL80211ScanResult {
    
    struct BSS: Equatable, Hashable, Codable {
        
        public let bssid: BSSID
        
        public let informationElements: Data
    }
}

// MARK: - Codable

extension NL80211ScanResult {
    
    internal enum CodingKeys: String, NetlinkAttributeCodingKey {
        
        case bss
        case generation
        case interface
        case wirelessDevice
        
        init?(attribute: NetlinkAttributeType) {
            
            switch attribute {
            case NetlinkAttributeType.NL80211.bss:
                self = .bss
            case NetlinkAttributeType.NL80211.generation:
                self = .generation
            case NetlinkAttributeType.NL80211.interfaceIndex:
                self = .interface
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
            case .interface:
                return NetlinkAttributeType.NL80211.interfaceIndex
            case .wirelessDevice:
                return NetlinkAttributeType.NL80211.wirelessDevice
            }
        }
    }
}

extension NL80211ScanResult.BSS {
    
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

extension NL80211ScanResult.BSSID: Equatable {
    
    public static func == (lhs: NL80211ScanResult.BSSID, rhs: NL80211ScanResult.BSSID) -> Bool {
        return lhs.bytes.0 == rhs.bytes.0
            && lhs.bytes.1 == rhs.bytes.1
            && lhs.bytes.2 == rhs.bytes.2
            && lhs.bytes.3 == rhs.bytes.3
            && lhs.bytes.4 == rhs.bytes.4
            && lhs.bytes.5 == rhs.bytes.5
    }
}

extension NL80211ScanResult.BSSID: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        withUnsafeBytes(of: bytes) { hasher.combine(bytes: $0) }
    }
}

extension NL80211ScanResult.BSSID: CustomStringConvertible {
    
    public var description: String {
        return String(format: "%x:%x:%x:%x:%x:%x", bytes.0, bytes.1, bytes.2, bytes.3, bytes.4, bytes.5).uppercased()
    }
}

extension NL80211ScanResult.BSSID: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        guard let bigEndianValue = NL80211ScanResult.BSSID(data: data) else {
            throw DecodingError.typeMismatch(NL80211ScanResult.BSSID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid bytes for BSSID"))
        }
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
