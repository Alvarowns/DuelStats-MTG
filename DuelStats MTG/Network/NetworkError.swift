//
//  NetworkError.swift
//  Beyond Earth
//
//  Created by Alvaro Santos Orellana on 6/9/24.
//

import Foundation

public enum NetworkError: Error {
    case general(Error)
    case status(Int)
    case noContent
    case unknown
    case noHTTP
    case json(Error)
    
    public var description: String {
        switch self {
        case .general(let error):
            "Error general: \(error.localizedDescription)."
        case .status(let int):
            "Error de estado: \(int)."
        case .noContent:
            "Error, el contenido no se corresponde con lo esperado."
        case .unknown:
            "Error desconocido."
        case .noHTTP:
            "No HTTP"
        case .json(let error):
            "Error en el JSON \(error)"
        }
    }
}
