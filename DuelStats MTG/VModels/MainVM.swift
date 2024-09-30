//
//  MainVM.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import SwiftUI
import SwiftData

@Observable
class MainVM: ObservableObject {
    var appState: AppState = .splash
    
    var startingLife: Int = 20
    var restartLifes: Bool = false
    var currentLife: [Player: Int] = [:]
    var changeLife: Bool = false
    var changePlayersNumbers: Bool = false
    var backgroundImage: UIImage = .fondoVertical1
    
    var gameStarted: Bool = false
    
    var playersSelected: [Player: Deck] = [:]
    
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
        return !name.isEmpty
    }
    
    func isDeckSelected(player: Player, deck: Deck) -> Bool {
        return playersSelected.contains { $0.value.id == deck.id }
    }
}
