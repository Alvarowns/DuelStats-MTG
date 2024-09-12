//
//  TabBarView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var viewModel: MainVM
    
    var body: some View {
        if !viewModel.gameStarted {
            TabView {
                MatchesPlayedView()
                    .tabItem {
                        VStack {
                            Image(systemName: "list.bullet.rectangle.portrait.fill")
                            Text("Matches")
                        }
                    }
                
                SetpUpGame()
                    .tabItem {
                        VStack {
                            Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled.fill")
                            Text("Start Game")
                        }
                    }
            }
            .tint(.salmon)
        } else {
            MatchView(players: viewModel.playersSelected)
        }
    }
}
