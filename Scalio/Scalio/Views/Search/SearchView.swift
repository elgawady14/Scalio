//
//  SearchView.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var settings: SearchSettings
    @State var presentResualtsView = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                SearchBar(text: $settings.keywordToSearch)
                Button("Submit") { settings.viewModel.submitAction() }
                .font(.body)
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.blue.opacity(settings.keywordToSearch.isEmpty ? 0.5 : 1.0))
                .disabled(settings.keywordToSearch.isEmpty)
                .cornerRadius(12)
            }
            .frame(height: geometry.size.height)
        }
        .onTapGesture { dismissKeyboard() }
        .onAppear {
            settings.viewModel.isResultsPresented.bind { value in
                settings.isResultsPresented = settings.viewModel.isResultsPresented.value
            }
        }
        .fullScreenCover(isPresented: $settings.isResultsPresented) {
            ResultsView().environmentObject(settings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()

    }
}
