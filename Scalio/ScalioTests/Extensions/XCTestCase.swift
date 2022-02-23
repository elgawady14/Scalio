//
//  XCTestCase.swift
//  ScalioTests
//
//  Created by Ahmed Abduljawad on 23/02/2022.
//

import XCTest
@testable import Scalio

extension XCTestCase {
    
    var provider: ScalioProvider {
        return ScalioProvider.shared
    }
    
    func check(_ target: ScalioAPI) {
        checkParams(for: target)
    }
    
    /// Parameters
    
    func checkParams(for target: ScalioAPI) {
        switch target {
        case let .search(keyword, page, perPage):
            XCTAssertTrue(!keyword.isEmpty)
            XCTAssertTrue(page > 0)
            XCTAssertTrue(perPage > 0)
        }
    }
    
    func checkRequestHeaders(for target: ScalioAPI) { }
}
