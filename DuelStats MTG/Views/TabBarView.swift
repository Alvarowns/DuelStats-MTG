//
//  TabBarView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var viewModel: MainVM
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        }
    
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
                
                PrepareMatch()
                    .tabItem {
                        VStack {
                            Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled.fill")
                            Text("Play")
                        }
                    }
                
                
                PlayersView()
                    .tabItem {
                        VStack {
                            Image(systemName: "person.3.fill")
                            Text("Players")
                        }
                    }
            }
            .tint(.orange)
        } else {
            MatchView()
        }
    }
}
