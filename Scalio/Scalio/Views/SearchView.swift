//
//  SearchView.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @State var presentResualtsView = false
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 50) {
                SearchBar(text: $text)
                
                Button("Submit") { submitAction() }
                .font(.body)
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.blue.opacity(text.isEmpty ? 0.5 : 1.0))
                .disabled(text.isEmpty)
                .cornerRadius(12)
            }
            .frame(height: geometry.size.height)
        }
        .onTapGesture { dismissKeyboard() }
    }
    
    func submitAction() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()

    }
    }
