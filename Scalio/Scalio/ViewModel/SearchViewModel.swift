//
//  SearchViewModel.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 22/02/2022.
//

import Foundation
import SwiftUI

class SearchViewModel: NSObject {
    var keywordToSearch: CustomBinding<String> = CustomBinding("a")
    var isResultsPresented: CustomBinding<Bool> = CustomBinding(false)
    var isLoading: CustomBinding<Bool> = CustomBinding(false)
    var visibleItems: CustomBinding<[Item]> = CustomBinding([])
    var allItems: [Item] = []
    var totalCount = 0
    var paginationIndex = 0 {
        didSet {
            visibleItems.value = Array(allItems.prefix(through: paginationIndex))
        }
    }
    var showMessage: CustomBinding<Bool> = CustomBinding(false)
    var message = ""
    var page = 1
    var perPage = 9
    var isLoadingFirstAPICall = false

    func submitAction() {
        guard !keywordToSearch.value.isEmpty else { return }
        isResultsPresented.value = true
    }
    
    func fetchMoreUsers<Item: Identifiable>(_ item: Item) {
        
        /// Make sure to not exceed the API results count.
        guard allItems.count <= totalCount else { return }
        if visibleItems.value.isLastItem(item) {
            isLoading.value = true
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.page += 1
                self.searchAPI()
            }
        }
    }
    
    func searchAPI() {
        SearchServices.searchAPI(keyword: self.keywordToSearch.value, page: self.page, perPage: self.perPage) { response in
            self.allItems = response.items.sorted { item1, item2 in
                return item1.login < item2.login
            }
            self.totalCount = response.totalCount
            self.visibleItems.value.append(contentsOf: self.allItems)
            self.isLoading.value.toggle()
            self.isLoadingFirstAPICall = false
        } failure: { error in
            self.message = error?.desc ?? "API Error."
            self.showMessage.value = true
            self.isLoading.value.toggle()
            self.isLoadingFirstAPICall = false

        }
    }
}

