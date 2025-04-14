//
//  Interactor.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 13/4/25.
//

import Foundation

protocol NetworkInteractorProtocol {
    func getCardsByName(name: String, page: Int, pageSize: Int) async throws -> Cards
    func getCardsByType() async throws
    func getCardsByCMC() async throws
    func getCardsByFormat() async throws
}

class NetworkInteractor: NetworkInteractorProtocol {
    func getCardsByName(name: String, page: Int, pageSize: Int) async throws -> Cards {
        @Inject var networkRepository: Network
        
        //TODO: Revisar porque da error usando el Inject.
//        do {
//            let cards = try await networkRepository.getJSON(request: .get(url: URL.getCardsByName(name: name, page: page, pageSize: pageSize)), type: Cards.self)
//            return cards
//        } catch {
//            throw error
//        }
        return Cards(cards: [])
    }
    
    func getCardsByType() async throws {
        
    }
    
    func getCardsByCMC() async throws {
        
    }
    
    func getCardsByFormat() async throws {
        
    }
    
    
}

class NetworkInteractorMock: NetworkInteractorProtocol {
    func getCardsByName(name: String, page: Int, pageSize: Int) async throws -> Cards {
        return Cards(cards: [])
    }
    
    func getCardsByType() async throws {
        
    }
    
    func getCardsByCMC() async throws {
        
    }
    
    func getCardsByFormat() async throws {
        
    }
    
    
}
