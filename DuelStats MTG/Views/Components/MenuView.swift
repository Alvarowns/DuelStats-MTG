//
//  MenuView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 16/9/24.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var viewModel: MainVM
    
    @State private var changeStartingLife: Bool = false
    @State private var endGame: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                Button {
                    viewModel.restartLifes.toggle()
                } label: {
                    Image(systemName: "arrow.circlepath")
                }
                
                Spacer()
                
                Button {
                    changeStartingLife.toggle()
                } label: {
                    Image(systemName: "heart")
                }
                
                Spacer()
                
                Button {
                    endGame.toggle()
                } label: {
                    Image(systemName: "xmark.circle")
                }
                
                Spacer()
            }
            .opacity(changeStartingLife ? 0.0 : 1.0)
            
            HStack {
                Spacer()
                
                Button {
                    changeStartingLife.toggle()
                    viewModel.startingLife = 20
                } label: {
                    Text("20")
                        .font(.title)
                }
                
                Spacer()
                
                Button {
                    changeStartingLife.toggle()
                    viewModel.startingLife = 30
                } label: {
                    Text("30")
                        .font(.title)
                }
                
                Spacer()
                
                Button {
                    changeStartingLife.toggle()
                    viewModel.startingLife = 40
                } label: {
                    Text("40")
                        .font(.title)
                }
                
                Spacer()
            }
            .opacity(changeStartingLife ? 1.0 : 0.0)
        }
        .font(.largeTitle)
        .bold()
        .foregroundStyle(.white)
        .shadowPop()
        .frame(maxWidth: .infinity, alignment: .center)
        .background {
            Rectangle()
                .foregroundStyle(.black)
        }
        .alert("Are you sure you want to end this game?", isPresented: $endGame) {
            Button("Yes") {
                viewModel.gameStarted = false
                viewModel.playersSelected = [:]
            }
            Button("No", role: .cancel) {}
        } message: {
            Text("You didn't select a winner and it will not appear in Matches")
        }

    }
}
