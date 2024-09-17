//
//  EditDeckPopUp.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 17/9/24.
//

import SwiftUI

struct EditDeckPopUp: View {
    @Binding var newDeckName: String
    @Binding var newFormat: Format
    @Binding var editDeck: Bool
    @Binding var deckToEdit: Deck
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                TextField("Editing deck \(deckToEdit.name)", text: $newDeckName)
                    .onChange(of: newDeckName) {
                                    if newDeckName.count > 20 {
                                        newDeckName = String(newDeckName.prefix(20))
                                    }
                                }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                    
                
                HStack {
                    Text("Format:")
                    Spacer()
                    Picker("Format", selection: $newFormat) {
                        ForEach(Format.allCases, id: \.rawValue) { format in
                            Text(format.rawValue.capitalized).tag(format)
                        }
                    }
                    .pickerStyle(.menu)
                    .fontWeight(.semibold)
                }
            }
            
            HStack {
                Button {
                    editDeck = false
                } label: {
                    Text("Cancel")
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
                .tint(.red)
                .buttonStyle(.borderedProminent)
                
                Button {
                    changeDeckName(deckToEdit, withName: newDeckName, inFormat: newFormat.rawValue)
                    editDeck = false
                } label: {
                    Text("Change")
                        .bold()
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                }
                .tint(.orange)
                .buttonStyle(.borderedProminent)
            }
        }
        .multilineTextAlignment(.center)
        .foregroundStyle(.white)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.black)
                .shadow(color: .white, radius: 2)
        }
        .padding()
    }
    
    func changeDeckName(_ deck: Deck, withName name: String, inFormat format: String) {
        let newName: String = name
        let newFormat: String = format
        
        deck.name = newName
        deck.format = newFormat
        
        print(deck.name)
    }
}
