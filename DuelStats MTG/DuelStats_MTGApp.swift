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
    
    //Aquí cambiamos el modo de la dependencia para test o producción.
    private let appMode: DependecyMode = .development
    
    let modelContainer: ModelContainer
    
    init() {
        // Injectamos la dependencia aquí con el appMode correspondiente que se inicia al iniciar la app.
        Dependencies.shared.provideDependecies(mode: appMode)
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
            do {
                modelContainer = try ModelContainer(for: ContainerModel.self)
            } catch {
                fatalError("Could not initialize ModelContainer with error: \(error)")
            }
        }
    
    var body: some Scene {
        WindowGroup {
            AppStateView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(MainVM())
        .modelContainer(modelContainer)
    }
}
