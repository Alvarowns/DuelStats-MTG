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
    
    @State private var sheet: Bool = false
    @State private var startGame: Bool = false
    @State private var showInfo: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                        
                    InkeeperList()
                    
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
                .disabled(showInfo ? true: false)
                .blur(radius: showInfo ? 3 : 0)
                .navigationDestination(isPresented: $startGame) {
                    MatchView(players: viewModel.playersSelected)
                }
                
                InfoPopUp(showInfo: $showInfo, title: "You can delete any player swiping left", subtitle: "Be careful, this action will remove the player permanently!", message: "You can do the same with each deck")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .foregroundStyle(.link)
                }
            }
            .navigationTitle("The Inkeeper")
            .sheet(isPresented: $sheet) {
                AddPlayerSheet(sheet: $sheet)
            }
        }
    }
}
