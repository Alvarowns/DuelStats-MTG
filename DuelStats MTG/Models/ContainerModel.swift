//
//  ContainerModel.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 10/9/24.
//

import Foundation
import SwiftData

@Model
class ContainerModel: Hashable {
    var players: [Player]
    var matches: [SingleMatch]
    var decks: [Deck]
    
    init(players: [Player], matches: [SingleMatch], decks: [Deck]) {
        self.players = players
        self.matches = matches
        self.decks = decks
    }
}
