//
//  AppStateView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 22/9/24.
//

import SwiftUI

struct AppStateView: View {
    @EnvironmentObject private var viewModel: MainVM
    
    var body: some View {
        Group {
            switch viewModel.appState {
            case .splash:
                SplashView()
            case .startingView:
                MainView()
            case .tabBar:
                TabBarView()
            }
        }
        .animation(.easeIn, value: viewModel.appState)
    }
}
