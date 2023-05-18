//
//  MapperError.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation

enum MapperError: Error, CustomStringConvertible {
    case parse(reason: String)
    
    
    var description: String {
        switch self {
        case .parse(let reason):
            return reason
        }
    }
    
}
