//
//  MatchView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI
import SwiftData

struct MatchView: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    
    @State private var someoneWon: Bool = false
    @State private var winner: Player = Player(name: "", decks: [], favorite: false, matches: [])
    @State private var winnerDeck: Deck = Deck(name: "", format: "")
    @State private var goBackAlert: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if viewModel.playersSelected.count == 2 {
                    PlayerView(player: Array(viewModel.playersSelected.keys)[0])
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .scaleEffect(x: 1, y: -1, anchor: .center)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.circlepath")
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "dice")
                        }
                        
                        Spacer()
                    }
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    PlayerView(player: Array(viewModel.playersSelected.keys)[1])
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if viewModel.gameStarted {
                        goBackAlert.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .font(.title3)
                        .foregroundStyle(.salmon)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .alert("\(winner.name) has won?", isPresented: $someoneWon) {
            Button("Yes") {
                recordWinner(players: viewModel.playersSelected, winner: winner, withDeck: winnerDeck)
            }
            Button("No", role: .destructive) {
                
            }
        }
        .alert("Are you sure you want to end this game?", isPresented: $goBackAlert, actions: {
            Button("Yes") {
                viewModel.gameStarted = false
            }
            
            Button("No", role: .cancel) {}
        })
        .onAppear {
            viewModel.gameStarted = true
        }
    }
    
    func recordWinner(players: [Player: Deck], winner: Player, withDeck deck: Deck) {
        var playersID: [UUID] = []
        var decksID: [UUID] = []
        
        for player in players {
            playersID.append(player.key.id)
            decksID.append(player.value.id)
        }
        
        let match = SingleMatch(playersID: playersID, decksID: decksID, winnerID: winner.id, winnerDeckID: deck.id, date: .now)
        
        modelContext.insert(match)
    }
}
