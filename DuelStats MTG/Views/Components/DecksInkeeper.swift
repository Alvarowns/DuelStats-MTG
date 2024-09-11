////
////  DecksInkeeper.swift
////  DuelStats MTG
////
////  Created by Alvaro Santos Orellana on 11/9/24.
////
//
//import SwiftUI
//import SwiftData
//
//struct DecksInkeeper: View {
//    @EnvironmentObject private var viewModel: MainVM
//    
//    var player: Player
//    
//    var body: some View {
//        if viewModel.playersSelected.keys.contains(player) {
//            Divider()
//            Section {
//                ForEach(player.decks.sorted(by: { $0.format > $1.format }), id: \.self) { deck in
//                    HStack(alignment: .top) {
//                        HStack {
//                            Text(deck.name)
//                            Spacer()
//                            Text("Format: \(deck.format.capitalized)")
//                            Spacer()
//                            Button {
//                                viewModel.changeDeck(player, withDeck: deck)
//                            } label: {
//                                if !viewModel.playersSelected[player]?.id == deck.id {
//                                    Image(systemName: "circlebadge")
//                                        .foregroundStyle(.secondary)
//                                        .imageScale(.medium)
//                                } else {
//                                    Image(systemName: "circlebadge.fill")
//                                        .foregroundStyle(.salmon)
//                                        .imageScale(.medium)
//                                }
//                            }
//                        }
//                        .padding(.horizontal, 10)
//                        .font(.footnote)
//                        
//                        Button {
//                            
//                        } label: {
//                            HStack {
//                                Text("New deck")
//                                Image(systemName: "plus")
//                            }
//                        }
//                    }
//                }
//            } header: {
//                Text("Decks")
//                    .font(.caption)
//                    .foregroundStyle(.secondary)
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .contentShape(Rectangle())
//            .onTapGesture {}
//        }
//    }
//}
