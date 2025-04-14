//
//  NetworkVM.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 14/4/25.
//

import Foundation

@Observable
class NetworkVM {
    var cards: Cards = Cards(cards: [])
    let networkRepository: NetworkInteractor
    
    init(networkRepository: NetworkInteractor) {
        self.networkRepository = networkRepository
        
        Task {
            await getCardsByName(name: "Avacyn")
        }
    }
    
    func getCardsByName(name: String) async {
        do {
            let cards = try await networkRepository.getCardsByName(name: name, page: 1, pageSize: 100)
            self.cards = cards
        } catch {
            print("No se han podido descargar las cartas con error: \(error)")
        }
    }
}
