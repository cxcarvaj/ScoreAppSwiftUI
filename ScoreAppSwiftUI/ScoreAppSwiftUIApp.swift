//
//  ScoreAppSwiftUIApp.swift
//  ScoreAppSwiftUI
//
//  Created by Carlos Xavier Carvajal Villegas on 25/3/25.
//

import SwiftUI

@main
struct ScoreAppSwiftUIApp: App {
    @StateObject var vm = ScoresVM()
    
    var body: some Scene {
        WindowGroup {
            MainTabScreen()
                .environmentObject(vm)
        }
    }
}
