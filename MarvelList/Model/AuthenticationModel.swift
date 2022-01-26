//
//  AuthenticationModel.swift
//  MarvelList
//
//  Created by Luis Barrios on 27/1/22.
//

import Foundation


struct AuthenticationModel{
    
    var apikey:String = "c426594a1689cb226a137dd9805bd8a2"
    var privatekey = "f02611c37164c0dd49d2c416b4369db6909da6d5"
    var ts = "\(Int64(Date().timeIntervalSince1970))"
    var hash:String{
        get{
            ts.appending(privatekey).appending(apikey).hashed(.md5) ?? ""
        }
    }
    var queryItems:[URLQueryItem]{
        get{
            [URLQueryItem(name: "apikey",value: apikey),
             URLQueryItem(name: "hash",value: hash),
             URLQueryItem(name: "ts",value: ts)]
        }
    }
    
    
}
