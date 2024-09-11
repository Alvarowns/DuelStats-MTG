//
//  MainVM.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI

@Observable
class MainVM: ObservableObject {
    var startingLife: Int = 20
    var currentLife: [Player: Int] = [:]
    var changeLife: Bool = false
    var changePlayersNumbers: Bool = false
    
    var playersSelected: [Player: Deck] = [:]
    
    let colors: [Color] = [.swampColor1, .salmon, .isle, .forest, .orchid, .swamp, .bubblegum]
    
    init() {
        
    }
    
    func selectPlayer(_ player: Player, withDeck deck: Deck) {
        if !playersSelected.contains(where: { $0.key.id == player.id }) {
            playersSelected.updateValue(deck, forKey: player)
        } else {
            print("Error seleccionando jugador")
        }
    }
    
    func unselectPlayer(_ player: Player) {
        if let index = playersSelected.firstIndex(where: { $0.key.id == player.id }) {
            playersSelected.remove(at: index)
        } else {
            print("Error deseleccionando jugador")
        }
    }
    
    func changeDeck(_ player: Player, withDeck deck: Deck) {
        if playersSelected.contains(where: { $0.key.id == player.id && $0.value.id != deck.id}) {
            playersSelected.updateValue(deck, forKey: player)
        }
    }
    
    func isInputValid(name: String, deck: String, format: Format) -> Bool {
        return !name.isEmpty && !deck.isEmpty && !format.rawValue.isEmpty
    }
    
    func isDeckSelected(player: Player, deck: Deck) -> Bool {
        return playersSelected.contains { $0.value.id == deck.id }
    }
}
