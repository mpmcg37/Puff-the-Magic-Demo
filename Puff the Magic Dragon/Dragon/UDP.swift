//
//  UDP.swift
//  Dragon
//
//  Created by Mitch on 6/5/15.
//  Copyright (c) 2015 Mitch. All rights reserved.
//
//  Extensions help from
//  http://programmar.io/article/1424731989
//

import Foundation

class UDP {
    
    private var port: Int
    private let fd = socket(AF_INET, SOCK_DGRAM, 0) // DGRAM makes it UDP
    private var addr: sockaddr_in
    
    //Create UDP socked with desired port, the IP will be static so I use Stuff.settings
    init(_ port: Int){
        self.port = port
        addr = sockaddr_in(Stuff.IP, port)
    }
    
    //Send a string over the established udp stocket
    func sendString(textToSend: String){
        println("sending \(textToSend)")
        textToSend.withCString { cstr -> Void in
            withUnsafePointer(&addr) { ptr -> Void in
                let addrptr = UnsafePointer<sockaddr>(ptr)
                sendto(fd, cstr, Int(strlen(cstr)), 0,
                    addrptr, socklen_t(addr.sin_len))
            }
        }
    }
}

//Extensions to make initialization easier
extension in_addr: StringLiteralConvertible {
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    public init(extendedGraphemeClusterLiteral v: ExtendedGraphemeClusterType) {
        self.init(v)
    }
    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }
}

extension in_addr {
    public init(_ string: String?) {
        if string == nil || string!.isEmpty {
            s_addr = 0
        }
        else {
            var buf = in_addr()
            string!.withCString { inet_pton(AF_INET, $0, &buf) }
            s_addr  = buf.s_addr
        }
    }
}

extension sockaddr_in {
    init(_ address: in_addr, _ port: Int) {
        func htons(value: CUnsignedShort) -> CUnsignedShort {
            return (value << 8) + (value >> 8);
        }
        sin_len    = __uint8_t(sizeof(sockaddr_in))
        sin_family = sa_family_t(AF_INET)
        sin_port   = htons(CUnsignedShort(port))
        sin_addr   = address
        sin_zero   = ( 0, 0, 0, 0, 0, 0, 0, 0 )
    }
    
    init(_ address: String, _ port: Int){
        let addr = in_addr(address)
        self.init(addr, port)
    }
}