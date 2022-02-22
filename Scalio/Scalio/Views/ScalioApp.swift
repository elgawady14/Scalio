//
//  ScalioApp.swift
//  Scalio
//
//  Created by Ahmed Abduljawad on 18/02/2022.
//

import SwiftUI

@main
struct ScalioApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView().environmentObject(SearchSettings())
//            ResultsView().environmentObject(SearchSettings())
        }
    }
}
