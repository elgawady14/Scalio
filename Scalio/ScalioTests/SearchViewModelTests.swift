//
//  SearchViewModelTests.swift
//  ScalioTests
//
//  Created by Ahmed Abduljawad on 23/02/2022.
//

import XCTest
@testable import Scalio

class SearchViewModelTests: XCTestCase {
    
    var sub = SearchViewModel()
    
    override func setUp() {
        // `.mock` for testing
        provider.setConnection(.mock)
    }

    func testSearchViewModelVariables() {
        XCTAssertTrue(sub.keywordToSearch.value.isEmpty)
        XCTAssertTrue(sub.isResultsPresented.value == false)
        XCTAssertTrue(sub.isLoading.value == false)
        XCTAssertTrue(sub.visibleItems.value.isEmpty)
        XCTAssertTrue(sub.allItems.isEmpty)
        XCTAssertTrue(sub.totalCount == .zero)
        XCTAssertTrue(sub.showMessage.value == false)
        XCTAssertTrue(sub.message.isEmpty)
        XCTAssertTrue(sub.page == 1)
        XCTAssertTrue(sub.perPage == 9)
        XCTAssertTrue(sub.showMessage.value == false)
        XCTAssertTrue(sub.isLoadingFirstAPICall == false)
    }
    
    func testSubmitAction()  {
        // Given
        sub.keywordToSearch.value = "Ahmad"
        // When
        sub.submitAction()
        // Then
        XCTAssertTrue(sub.isResultsPresented.value == true)
    }
    
    func testFetchMoreUsers() {
        // Given
        sub.keywordToSearch.value = "Ahmad"
        let item = Item(login: "Ahmad", avatarURL: "", type: "")
        sub.visibleItems.value.append(item)
        sub.page = 1
        let expectation = expectation(description: "testFetchMoreUsers")
        // When
        sub.fetchMoreUsers(item)
        
        // Then
        XCTAssertTrue(sub.isLoading.value == true)
        sub.run = {
            XCTAssertTrue(self.sub.visibleItems.value.isLastItem(item))
            XCTAssertTrue(self.sub.page == 2)
            XCTAssertTrue(!self.sub.allItems.isEmpty)
            XCTAssertTrue(self.sub.totalCount > 0)
            XCTAssertTrue(self.sub.visibleItems.value.count > 1)
            XCTAssertTrue(self.sub.isLoading.value == false)
            XCTAssertTrue(self.sub.isLoadingFirstAPICall == false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: TestConstants.timeoutInterval)
        
    }
    
    func testSearchAPI() {
        // Given
        let completeFetchMoreUsersExpectation = expectation(description: #function)
        
        sub.keywordToSearch.value = "Ahmad"
        sub.page = 1
        // When
        sub.searchAPI()
        // Then
        sub.run = {
            XCTAssertTrue(self.sub.isLoading.value == true)
            XCTAssertTrue(!self.sub.allItems.isEmpty)
            XCTAssertTrue(self.sub.totalCount > 0)
            XCTAssertTrue(!self.sub.visibleItems.value.isEmpty)
            XCTAssertTrue(self.sub.isLoading.value == false)
            XCTAssertTrue(self.sub.isLoadingFirstAPICall == false)
        }
        wait(for: [completeFetchMoreUsersExpectation], timeout: TestConstants.timeoutInterval)
    }
    
    func testClearCache() {
        // Given
        let item = Item(login: "Ahmad", avatarURL: "", type: "")
        sub.allItems.append(item)
        sub.visibleItems.value.append(item)
        sub.isLoading.value = true
        sub.totalCount = 1
        sub.isResultsPresented.value = true
        sub.page = 0
        // When
        sub.clearCache()
        // Then
        XCTAssertTrue(sub.allItems.isEmpty)
        XCTAssertTrue(sub.visibleItems.value.isEmpty)
        XCTAssertTrue(sub.isLoading.value == false)
        XCTAssertTrue(sub.totalCount == 0)
        XCTAssertTrue(sub.isResultsPresented.value == false)
        XCTAssertTrue(sub.page == 1)
    }

    func testRandomAccessCollection() {
        let item = Item(login: "Ahmad", avatarURL: "", type: "")
        let items = [item]
        XCTAssertTrue(items.isLastItem(item))
    }
}

