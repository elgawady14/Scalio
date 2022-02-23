//
//  SearchSettings.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 20/02/2022.
//

import Foundation

class SearchSettings: ObservableObject {
    @Published var keywordToSearch = "" {
        didSet {
            viewModel.keywordToSearch.value = keywordToSearch
        }
    }
    @Published var isResultsPresented = false
    @Published var visibleItems = [Item]()
    @Published var isLoading = false
    @Published var showMessage = false
    @Published var viewModel = SearchViewModel()
}
