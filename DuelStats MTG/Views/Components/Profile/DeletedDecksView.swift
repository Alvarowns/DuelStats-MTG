//
//  DeletedDecksView.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 17/9/24.
//

import SwiftUI
import SwiftData

struct DeletedDecksView: View {
    @EnvironmentObject private var viewModel: MainVM
    @Query var background: [BackgroundPersistent]
    
    var player: Player
    
    var body: some View {
        VStack {
            List {
                ForEach(player.decks.filter({ $0.hasBeenDeleted == true }), id: \.self) { deck in
                    HStack {
                        Text(deck.name)
                        
                        Spacer()
                        
                        Button {
                            deck.hasBeenDeleted = false
                        } label: {
                            Image(systemName: "arrowshape.turn.up.left.fill")
                        }
                        .tint(.orange)
                        .shadowPop()
                    }
                }
                .listRowBackground(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.black.opacity(0.6))
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 3)
                            .foregroundStyle(.black)
                    }
                )
            }
            .listStyle(.plain)
        }
        .padding()
        .navigationTitle("Decks deleted")
        .navigationBarTitleDisplayMode(.inline)
        .background {
            if let background = background.first?.image {
                Image("\(background)")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
                    .ignoresSafeArea()
            } else {
                Image(uiImage: viewModel.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
                    .ignoresSafeArea()
            }
        }
    }
}
