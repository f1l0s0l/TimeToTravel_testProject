//
//  FlightsCodable.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation


struct FlightsCodable: Decodable {
    let flights: [Flight]
}


struct Flight: Codable {
    let startDate: String
    let endDate: String
    let startLocationCode: String
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let serviceClass: String
    let price: Int
    let searchToken: String
}
