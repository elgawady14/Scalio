//
//  ScalioAPITests.swift
//  ScalioTests
//
//  Created by Ahmed Abduljawad on 23/02/2022.
//

import XCTest
@testable import Scalio

class ScalioAPITests: XCTestCase {
    
    override func setUpWithError() throws {
        // `.mock` for testing
        provider.setConnection(.mock)
    }
    
    func testSearchSettingsVariables() {
        // Given
        let settings = SearchSettings()
        XCTAssertTrue(settings.keywordToSearch.isEmpty)
        XCTAssertTrue(settings.isResultsPresented == false)
        XCTAssertTrue(settings.isLoading == false)
        XCTAssertTrue(settings.visibleItems.isEmpty)
        XCTAssertTrue(settings.showMessage == false)
        XCTAssertNotNil(settings.viewModel)
    }
    
    func testScalioAPI() {
        // Given
        let target = ScalioAPI.search(keyword: TestConstants.keyword, page: TestConstants.page, perPage: TestConstants.perPage)
        // When
        let baseUrl = target.baseURL?.url?.absoluteString ?? ""
        // Then
        XCTAssertTrue(!baseUrl.isEmpty)
        XCTAssertTrue(baseUrl == "\(NetworkConstants.MOCK_APP_API_URL)\(target.path)\(target.testCaseIdentifier)")
        XCTAssertTrue(target.path == "search/users?q=\(TestConstants.keyword)&page=\(TestConstants.page)&perPage=\(TestConstants.perPage)")
        XCTAssertTrue(target.method == ScalioHTTPMethod.get)
        XCTAssertTrue(target.headers!.isEmpty)
        XCTAssertTrue(target.parameters == nil)
        XCTAssertTrue(target.percentEncoding == TestConstants.keyword)
        XCTAssertTrue(target.testCaseIdentifier == "/0")
        XCTAssertTrue(ScalioAPI.search(keyword: TestConstants.keyword, page: TestConstants.page, perPage: TestConstants.perPage) != ScalioAPI.search(keyword: TestConstants.keyword, page: TestConstants.page, perPage: TestConstants.perPage + 1))
        XCTAssertTrue(ScalioAPI.search(keyword: TestConstants.keyword, page: TestConstants.page, perPage: TestConstants.perPage) == ScalioAPI.search(keyword: TestConstants.keyword, page: TestConstants.page, perPage: TestConstants.perPage))
    }
    
    func testX() {
        let error = ScalioError(status: .Error, desc: "Modeling Error")
        XCTAssertNotNil(error)
        XCTAssertTrue(error.status.rawValue == 1)
    }
}

