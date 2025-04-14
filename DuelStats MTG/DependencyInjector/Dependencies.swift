//
//  Dependencies.swift
//  DuelStats MTG
//
//  Created by Alvaro Santos Orellana on 14/4/25.
//

import Foundation

enum DependecyMode {
    case production
    case development
    case testing
}

struct Dependencies: Sendable {
    @MainActor static var shared: Dependencies = .init()
    
    func provideDependecies(mode: DependecyMode) {
        appDependency(mode: mode)
    }
}

extension Dependencies {
    private func appDependency(mode: DependecyMode) {
        switch mode {
        case .production:
            @Provider var networkInteractor = NetworkInteractor() as NetworkInteractorProtocol
        case .development:
            @Provider var networkInteractor = NetworkInteractor() as NetworkInteractorProtocol
        case .testing:
            @Provider var networkInteractor = NetworkInteractorMock() as NetworkInteractorProtocol
        }
    }
}
