//
//  NetworkRouterError.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation

enum NetworkRouterError: Error, CustomStringConvertible {
    case noInternetConnection
    case server(reason: String)
    
    var description: String {
        switch self {
        case .noInternetConnection:
            return "Нет соединения с интернетом"
        case .server(let reason):
            print(reason)
            return "Неизвестная ошибка"
        }
    }
}
