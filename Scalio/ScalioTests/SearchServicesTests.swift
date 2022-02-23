//
//  SearchServicesTests.swift
//  ScalioTests
//
//  Created by Ahmed Abduljawad on 23/02/2022.
//

import XCTest
@testable import Scalio

class SearchServicesTests: XCTestCase {

    override func setUpWithError() throws {
        // `.mock` for testing
        provider.setConnection(.mock)
    }

    override func tearDownWithError() throws {
    }

    func testSearchApi() {
        // Given
        let target = ScalioAPI.search(keyword: TestConstants.keyword, page: TestConstants.page, perPage: TestConstants.perPage)
        check(target)
        let expect = expectation(description: (target.path + target.testCaseIdentifier))
        // When
        SearchServices.searchAPI(keyword: TestConstants.keyword, page: TestConstants.page, perPage: TestConstants.perPage) { response in
            // Then
            expect.fulfill()
        } failure: { error in
            // Then
            XCTFail(error?.desc ?? TestConstants.OFFLINE_TIMEOUT_ERROR)
        }
        wait(for: [expect], timeout: target.timeoutInterval)
    }
    
    func testSearchApiWithInCorrectResponse() {
        // Given
        let target = ScalioAPI.search(keyword: TestConstants.keyword, page: TestConstants.page, perPage: TestConstants.perPage)
        check(target)
        let expect = expectation(description: (target.path + "/2"))
        // When
        SearchServices.searchAPI(keyword: TestConstants.keyword, page: TestConstants.page, perPage: TestConstants.perPage) { response in
            // Then
            XCTFail("Not expected")
        } failure: { _ in
            // Then
            expect.fulfill()
        }
        wait(for: [expect], timeout: target.timeoutInterval)
    }
    
   

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
