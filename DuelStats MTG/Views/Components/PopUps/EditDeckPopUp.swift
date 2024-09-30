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
                Text("Editing \(deckToEdit.name)")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Text("Change Name:")
                    Spacer()
                    TextField("New name for \(deckToEdit.name)", text: $newDeckName)
                        .bold()
                        .onChange(of: newDeckName) {
                                        if newDeckName.count > 20 {
                                            newDeckName = String(newDeckName.prefix(20))
                                        }
                                    }
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.words)
                        .textFieldStyle(.roundedBorder)
                }
                    
                
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
                    hideKeyboard()
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
                    hideKeyboard()
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
                .foregroundStyle(.lead)
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
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
