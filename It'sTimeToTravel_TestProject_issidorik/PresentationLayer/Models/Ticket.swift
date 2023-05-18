//
//  Ticket.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation

final class Ticket {
    
    // MARK: - Public properties
    
    let startDate: Date
    let endDate: Date
    let startLocationCode: String
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let price: Int
    let searchToken: String
    var isLikes: Bool = false
    
    
    // MARK: - Init
    
    init(startDate: Date, endDate: Date, startLocationCode: String, endLocationCode: String, startCity: String, endCity: String, price: Int, searchToken: String) {
        self.startDate = startDate
        self.endDate = endDate
        self.startLocationCode = startLocationCode
        self.endLocationCode = endLocationCode
        self.startCity = startCity
        self.endCity = endCity
        self.price = price
        self.searchToken = searchToken
    }
    
}
