//
//  ResultsView.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 20/02/2022.
//

import SwiftUI

struct ResultsView: View {
    
    @EnvironmentObject var settings: SearchSettings
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {

                HStack {
                    Text("GitHub Users")
                        .font(.system(.headline))
                    Spacer()
                    Button {
                        settings.viewModel.clearCache()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                            .frame(height: 25)
                    }
                }
                .padding(.top, 20)
                .padding(.trailing, 30)
                .padding(.leading, 25)

                if settings.viewModel.isLoadingFirstAPICall == true { ProgressView() }
                
                //ScrollView {
                    VStack {
                        List(settings.visibleItems) { item in
                            VStack {
                                UserCell(item: item)
                                    .frame(height: 120)
                                
                                if settings.viewModel.isLoading.value && settings.viewModel.visibleItems.value.isLastItem(item) {
                                    Divider()
                                    ProgressView()
                                }
                            }.onAppear {
                                settings.viewModel.fetchMoreUsers(item)
                            }
                        }
                    }
                //}
            }
            .frame(height: geometry.size.height)
            .background(Color.clear)
            
            .alert(isPresented: $settings.showMessage, content: {
                Alert(title: Text("⚠️"), message: Text(settings.viewModel.message), dismissButton: .default(Text("OK"), action: {
                    settings.showMessage.toggle()
                    settings.viewModel.message = ""
                }))
            })
            .onAppear {
                settings.viewModel.visibleItems.bind { value in
                    settings.visibleItems = settings.viewModel.visibleItems.value
                }
                settings.viewModel.isLoading.bind { value in
                    settings.isLoading = settings.viewModel.isLoading.value
                }
                settings.viewModel.showMessage.bind { value in
                    settings.showMessage = settings.viewModel.showMessage.value
                }
                settings.viewModel.isLoadingFirstAPICall = true
                settings.viewModel.searchAPI()
            }
        }
    }
    
   
}

struct ReasultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
