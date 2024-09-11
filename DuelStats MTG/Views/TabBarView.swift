//
//  TabBarView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
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
                        Image(systemName: "person.3.fill")
                        Text("Inkeeper")
                    }
                }
        }
    }
}

#Preview {
    TabBarView()
}
