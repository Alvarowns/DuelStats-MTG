//
//  AddDeckSheet.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 11/9/24.
//

import SwiftUI

struct AddDeckSheet: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    
    @State private var deckName: String = ""
    @State private var format: Format = .casual
    
    @Binding var sheet: Bool
    
    var player: Player
    
    var body: some View {
        VStack {
            Group {
                TextField("Deck name", text: $deckName)
                    .textInputAutocapitalization(.words)
                    .onChange(of: deckName) {
                                    if deckName.count > 12 {
                                        deckName = String(deckName.prefix(12))
                                    }
                                }
            }
            .autocorrectionDisabled()
            .lineLimit(1)
            
            HStack {
                Text("Format:")
                Spacer()
                Picker("Format", selection: $format) {
                    ForEach(Format.allCases, id: \.rawValue) { format in
                        Text(format.rawValue.capitalized).tag(format)
                    }
                }
                .pickerStyle(.menu)
                .fontWeight(.semibold)
            }
            
            Button {
                sheet.toggle()
                addDeck()
                deckName = ""
                format = .casual
            } label: {
                Text("Add Deck")
            }
            .buttonStyle(.borderedProminent)
            .font(.headline)
            .disabled(!isInputValid(deck: deckName, format: format))
            
        }
        .padding()
        .presentationDetents([.fraction(1/4)])
        .tint(.salmon)
    }
    
    func addDeck() {
        let deck: Deck = Deck(name: deckName, format: format.rawValue)
        player.decks.append(deck)
        modelContext.insert(player)
    }
    
    func isInputValid( deck: String, format: Format) -> Bool {
        return !deck.isEmpty && !format.rawValue.isEmpty
    }
}
