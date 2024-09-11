//
//  DuelStats_MTGApp.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI
import SwiftData

@main
struct DuelStats_MTGApp: App {
    @StateObject private var mainVM = MainVM()
    @StateObject private var matchVM = MatchVM()
    
    let modelContainer: ModelContainer
    
    init() {
            do {
                modelContainer = try ModelContainer(for: ContainerModel.self)
            } catch {
                fatalError("Could not initialize ModelContainer with error: \(error)")
            }
        }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(MainVM())
        .environmentObject(MatchVM())
        .modelContainer(modelContainer)
    }
}
