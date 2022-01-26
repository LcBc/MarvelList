//
//  MockEnviroment.swift
//  MarvelListTests
//
//  Created by Luis Barrios on 23/1/22.
//

import Foundation
@testable import MarvelList
import XCTest

extension EndpointKinds {
    enum Stub: EndpointKind {
        static func prepare(_ request: inout URLRequest,
                            with data: Void) {
            // No-op
        }
    }
}


