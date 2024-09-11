//
//  SetpUpGame.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI
import SwiftData

struct SetpUpGame: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    @Query var players: [Player]
    
    @State private var search: String = ""
    @State private var sheet: Bool = false
    @State private var startGame: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                    Button {
                        sheet.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Text("New player")
                            Image(systemName: "plus")
                        }
                    }
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                    
                InkeeperList(search: $search)
                
                VStack(spacing: 0) {
                    Text("Select at least 2 players to start a game")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button {
                        startGame.toggle()
                    } label: {
                        Text("Start Game")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(10)
                            .bold()
                            .font(.title2)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .disabled(viewModel.playersSelected.count < 2)
                }
            }
            .navigationDestination(isPresented: $startGame) {
                MatchView(players: viewModel.playersSelected)
            }
            .navigationTitle("The Inkeeper")
            .searchable(text: $search, prompt: "Search for a player")
            .sheet(isPresented: $sheet) {
                AddPlayerSheet(sheet: $sheet)
            }
        }
        .tint(.salmon)
    }
}
