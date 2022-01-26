//
//  Enviroment.swift
//  MarvelList
//
//  Created by Luis Barrios on 23/1/22.
//

import Foundation



struct URLHost: RawRepresentable {
    var rawValue: String
}


extension URLHost {
    static var staging: Self {
        URLHost(rawValue: "gateway.marvel.com")
    }

    static var production: Self {
        URLHost(rawValue: "gateway.marvel.com")
    }

    static var `default`: Self {
        #if DEBUG
        return staging
        #else
        return production
        #endif
    }
}
