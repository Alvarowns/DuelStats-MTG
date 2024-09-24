//
//  AddPlayerSheet.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI

struct AddPlayerSheet: View {
    @EnvironmentObject private var viewModel: MainVM
    @Environment(\.modelContext) var modelContext
    
    @State var name: String = ""
    @State var deckName: String = ""
    @State var format: Format = .casual
    @Binding var sheet: Bool
    
    var body: some View {
        VStack {
            Group {
                Text("You can add more decks and edit them later!")
                    .padding(.bottom)
                
                TextField("Player Name", text: $name)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                TextField("Deck name", text: $deckName)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                    .onChange(of: deckName) {
                                    if deckName.count > 20 {
                                        deckName = String(deckName.prefix(20))
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
                addPlayer()
                name = ""
                deckName = ""
                format = .casual
                hideKeyboard()
            } label: {
                Text("Add Player")
                    .foregroundStyle(.black)
            }
            .foregroundStyle(.black)
            .buttonStyle(.borderedProminent)
            .font(.headline)
            .disabled(!viewModel.isInputValid(name: name, deck: deckName, format: format))
            
        }
        .padding()
        .presentationDetents([.fraction(1/4)])
        .tint(.orange)
    }
    
    func addPlayer() {
        let player: Player = Player(name: name, decks: [Deck(name: deckName, format: format.rawValue, hasBeenDeleted: false)], favorite: false, matches: [])
        modelContext.insert(player)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
