//
//  ErrorMessage.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/8/18.
//

import Foundation
import SystemPackage

/// Netlink generic message payload.
public struct NetlinkErrorMessage: Error, NetlinkMessageProtocol {
    
    internal static let length = NetlinkMessageHeader.length + MemoryLayout<Int32>.size + NetlinkMessageHeader.length
    
    // MARK: - Properties
    
    /**
     Length: 32 bits
     
     The length of the message in bytes, including the header.
     */
    public var length: UInt32 {
        return UInt32(NetlinkErrorMessage.length + payload.count)
    }
    
    /**
     Type: 16 bits
     
     This field describes the message content.
     It can be one of the standard message types:
     * NLMSG_NOOP  Message is ignored.
     * NLMSG_ERROR The message signals an error and the payload
     contains a nlmsgerr structure.  This can be looked
     at as a NACK and typically it is from FEC to CPC.
     * NLMSG_DONE  Message terminates a multipart message.
     */
    
    public var type: NetlinkMessageType { return .error }
    
    /**
     Flags: 16 bits
     */
    public var flags: NetlinkMessageFlag
    
    /**
     Sequence Number: 32 bits
     
     The sequence number of the message.
     */
    public var sequence: UInt32
    
    /**
     Process ID (PID): 32 bits
     
     The PID of the process sending the message. The PID is used by the
     kernel to multiplex to the correct sockets. A PID of zero is used
     when sending messages to user space from the kernel.
     */
    public var process: ProcessID
    
    /// Message payload.
    public var error: Errno? {
        guard errorCode != 0 else { return nil }
        return Errno(rawValue: errorCode)
    }
    
    internal var errorCode: Int32
    
    /// Original request
    public var request: NetlinkMessageHeader
    
    /// Original payload
    public var payload: Data
    
    // MARK: - Initialization
    
    public init(flags: NetlinkMessageFlag = 0,
                sequence: UInt32 = 0,
                process: ProcessID = .current,
                error: Errno? = nil,
                request: NetlinkMessageHeader,
                payload: Data = Data()) {
        
        self.flags = flags
        self.sequence = sequence
        self.process = process
        self.errorCode = error?.rawValue ?? 0
        self.request = request
        self.payload = payload
    }
}

public extension NetlinkErrorMessage {
    
    init?(data: Data) {
        
        guard data.count >= NetlinkErrorMessage.length
            else { return nil }
        
        let length = Int(UInt32(bytes: (data[0], data[1], data[2], data[3])))
        
        guard length >= NetlinkErrorMessage.length
            else { return nil }
        
        // netlink header
        let type = NetlinkMessageType(rawValue: UInt16(bytes: (data[4], data[5])))
        
        guard type == .error
            else { return nil }
        
        self.flags = NetlinkMessageFlag(rawValue: UInt16(bytes: (data[6], data[7])))
        self.sequence = UInt32(bytes: (data[8], data[9], data[10], data[11]))
        self.process = ProcessID(rawValue: .init(bytes: (data[12], data[13], data[14], data[15])))
        
        // error code
        self.errorCode = Int32(bytes: (data[16], data[17], data[18], data[19]))
        
        // request header
        guard let header = NetlinkMessageHeader(data: Data(data[20 ..< NetlinkErrorMessage.length]))
            else { return nil }
        
        self.request = header
        
        // payload
        if data.count > NetlinkErrorMessage.length {
            self.payload = Data(data[NetlinkErrorMessage.length ..< length])
        } else {
            self.payload = Data()
        }
    }
    
    var data: Data {
        
        return Data([
            length.bytes.0,
            length.bytes.1,
            length.bytes.2,
            length.bytes.3,
            type.rawValue.bytes.0,
            type.rawValue.bytes.1,
            flags.rawValue.bytes.0,
            flags.rawValue.bytes.1,
            sequence.bytes.0,
            sequence.bytes.1,
            sequence.bytes.2,
            sequence.bytes.3,
            process.rawValue.bytes.0,
            process.rawValue.bytes.1,
            process.rawValue.bytes.2,
            process.rawValue.bytes.3,
            errorCode.bytes.0,
            errorCode.bytes.1,
            errorCode.bytes.2,
            errorCode.bytes.3
            ]) + request.data + payload
    }
}

