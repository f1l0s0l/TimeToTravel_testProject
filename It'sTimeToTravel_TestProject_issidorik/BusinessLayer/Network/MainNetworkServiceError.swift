//
//  MainNetworkServiceError.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation

enum MainNetworkServiceError: Error, CustomStringConvertible {
    case networkRouterError(error: NetworkRouterError)
    case mapperError(error: MapperError)
    case wrongURL
    
    var description: String {
        switch self {
        case .networkRouterError(let error):
            return error.description
        case .mapperError(let error):
            return error.description
        case .wrongURL:
            return "URL == nil"
        }
    }
    
    var descriptionForUser: String {
        switch self {
        case .networkRouterError(let error):
            switch error {
            case .noInternetConnection:
                return error.description
            default :
                return "Ошибка соединения с сервером"
            }
            
        default:
            return "Ошибка соединения с сервером"
        }
    }
}
