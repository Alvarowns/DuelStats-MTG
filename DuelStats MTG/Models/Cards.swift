//
//  Cards.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 13/9/24.
//

import Foundation

struct Cards: Codable, Hashable {
    let cards: [Card]
}

struct Card: Codable, Hashable, Identifiable {
    let name: String
    let manaCost: String?
    let cmc: Double?
    let colors: [String]?
    let colorIdentity: [String]?
    let type: String?
    let supertypes: [String]?
    let types: [String]?
    let subtypes: [String]?
    let rarity: String?
    let set: String?
    let setName: String?
    let text: String?
    let artist: String?
    let number: String?
    let power: String?
    let toughness: String?
    let layout: String?
    let multiverseid: String?
    let imageUrl: String?
    let loyalty: String?
    let rulings: [Ruling]?
    let variations: [String]?
    let foreignNames: [ForeignNames]?
    let printings: [String]?
    let originalText: String?
    let originalType: String?
    let legalities: [Legality]?
    let id: String?
}

struct ForeignNames: Codable, Hashable {
    let name: String?
    let text: String?
    let type: String?
    let flavor: String?
    let imageUrl: String?
    let language: String?
    let identifiers: CardIdentifier?
    let multiverseid: Int?
}

struct CardIdentifier: Codable, Hashable {
    let scryfallId: String?
    let multiverseId: Int?
}

struct Legality: Codable, Hashable {
    let format: String?
    let legality: String?
}

struct Ruling: Codable, Hashable {
    let date: String?
    let text: String?
}
