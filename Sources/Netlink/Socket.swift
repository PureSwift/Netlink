//
//  Socket.swift
//  Netlink
//
//  Created by Alsey Coleman Miller on 7/6/18.
//

import Foundation
import SystemPackage
import CNetlink

/// Netlink Socket
public final class NetlinkSocket {
    
    // MARK: - Properties
    
    /// Netlink protocol
    public let netlinkProtocol: NetlinkSocketProtocol
    
    /// Underlying file descriptor.
    internal let fileDescriptor: FileDescriptor
    
    // MARK: - Initialization
    
    deinit {
        do {
            try fileDescriptor.close()
        } catch {
            assertionFailure("Unable to close Netlink socket. \(error)")
        }
    }
    
    public init(
        _ netlinkProtocol: NetlinkSocketProtocol,
        group: Int32 = 0
    ) throws {
        
        // open socket
        let fileDescriptor = try FileDescriptor.netlink(
            netlinkProtocol,
            group: group
        )
        
        // initialize socket
        self.fileDescriptor = fileDescriptor
        self.netlinkProtocol = netlinkProtocol
    }
    
    // MARK: - Methods
    
    public func addMembership(to group: CInt) throws {
        try fileDescriptor.setSocketOption(NetlinkSocketOption.AddMembership(group: group))
    }
    
    public func removeMembership(from group: CInt) throws {
        try fileDescriptor.setSocketOption(NetlinkSocketOption.RemoveMembership(group: group))
    }
    
    public func send(_ data: Data) throws {
        
        var address = sockaddr_nl(nl_family: __kernel_sa_family_t(AF_NETLINK),
                                  nl_pad: 0,
                                  nl_pid: 0,
                                  nl_groups: 0)
        
        // sendto()
        
        let sentBytes = withUnsafePointer(to: &address, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1, { (socketPointer) in
                data.withUnsafeBytes { (dataPointer: UnsafePointer<UInt8>) in
                    sendto(fileDescriptor.rawValue, UnsafeRawPointer(dataPointer), data.count, 0, socketPointer, socklen_t(MemoryLayout<sockaddr_nl>.size))
                }
            })
        })
        
        //guard sentBytes >= 0
        //    else { throw POSIXError.fromErrno! }
        
        guard sentBytes == data.count
            else { throw NetlinkSocketError.invalidSentBytes(sentBytes) }
    }
    
    public func recieve <T: NetlinkMessageProtocol> (_ message: T.Type) throws -> [T] {
        
        let data = try recieve()
        
        if let errorMessages = try? NetlinkErrorMessage.from(data: data),
            let error = errorMessages.first(where: { $0.error != nil }) {
            
            throw error
            
        } else if let messages = try? T.from(data: data) {
            
            return messages
            
        } else {
            
            throw NetlinkSocketError.invalidData(data)
        }
    }
    
    public func recieve() throws -> Data {
        
        let chunkSize = Int(getpagesize())
        
        var readData = Data()
        var chunk = Data()
        repeat {
            chunk = try recieveChunk(size: chunkSize)
            readData.append(chunk)
        } while chunk.count == chunkSize // keep reading
        
        return readData
    }
    
    internal func recieveChunk(size: Int, flags: CInt = 0) throws -> Data {
        
        var data = Data(count: size)
        
        // recv()
        let recievedBytes = data.withUnsafeMutableBytes { (dataPointer: UnsafeMutablePointer<UInt8>) in
            recv(fileDescriptor.rawValue, UnsafeMutableRawPointer(dataPointer), size, flags)
        }
        
        //guard recievedBytes >= 0
        //    else { throw POSIXError.fromErrno! }
        
        return Data(data.prefix(recievedBytes))
    }
}

// MARK: - Supporting Types

public enum NetlinkSocketError: Error {
    
    case invalidProtocol
    case invalidSentBytes(Int)
    case invalidData(Data)
}
