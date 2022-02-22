//
//  SearchBar.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 19/02/2022.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var settings: SearchSettings
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person").foregroundColor(.secondary)
                TextField("Search users ...", text: $text)
                    .submitLabel(.search)
                    .onSubmit {
                        settings.viewModel.submitAction()
                    }
                if text != "" {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.medium)
                        .foregroundColor(Color(.systemGray3))
                        .padding(3)
                        .onTapGesture {
                            withAnimation {
                                self.text = ""
                            }
                        }
                }
            }
            .frame(height: 45)
            .padding(10)
            .background(backgroundcolor)
            .cornerRadius(12)
            .padding(.vertical, 12)
        }
        .padding([.leading, .trailing], 15)
    }
    
    var backgroundcolor: Color {
        return colorScheme == .light  ? Color(.systemGray6) : Color(.systemGray5)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
