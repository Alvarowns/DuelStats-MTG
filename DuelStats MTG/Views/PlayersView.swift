//
//  SetpUpGame.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI
import SwiftData

struct PlayersView: View {
    @EnvironmentObject private var viewModel: MainVM
    
    @State private var sheet: Bool = false
    @State private var startGame: Bool = false
    @State private var showInfo: Bool = false
    @State private var settings: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Button {
                        sheet.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "person.fill.badge.plus")
                                .font(.title)
                                .shadowPop()
                        }
                        .padding(.horizontal)
                    }
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                    
                    InkeeperList()
                }
                .background {
                    Image(uiImage: viewModel.backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                .disabled(showInfo ? true: false)
                .blur(radius: showInfo ? 3 : 0)
                .navigationDestination(isPresented: $startGame) {
                    MatchView()
                }
                
                InfoPopUp(showInfo: $showInfo, title: "You can delete any player swiping left\n\nPlayers marked as favorites will appear first", subtitle: "Be careful, deleting a player is permanent action!", message: "")
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("The Inkeeper")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                        .shadowPop()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button {
                            showInfo.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                                .bold()
                        }
                        .shadowPop()
                        
                        Button {
                            settings.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                                .bold()
                        }
                        .shadowPop()
                    }
                }
            }
            .fullScreenCover(isPresented: $settings) {
                Settings()
            }
            .sheet(isPresented: $sheet) {
                AddPlayerSheet(sheet: $sheet)
            }
        }
    }
}
