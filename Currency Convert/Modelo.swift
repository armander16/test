//
//  Modelo.swift
//  Currency Convert
//
//  Created by Armando Maldonado Romo on 19/05/23.
//

import Foundation

struct Convert: Codable {
    let success: Bool?
    let timestamp: Int?
    let base, date: String?
    let rates: Rates?
}

struct Rates: Codable {
    let usd, eur, gbp, cad: Double?
    let mxn: Double?

    enum CodingKeys: String, CodingKey, Hashable {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
        case cad = "CAD"
        case mxn = "MXN"
    }
}


struct Moneda: Codable {
    let date: String?
    let info: Info?
    let query: Query?
    let result: Double?
    let success: Bool?
}

struct Info: Codable {
    let rate: Double?
    let timestamp: Int?
}

struct Query: Codable {
    let amount: Int?
    let from, to: String?
}
