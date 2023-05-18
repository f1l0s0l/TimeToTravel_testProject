//
//  NetworkRouter.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation

typealias NetworkRouterCompletion = (Result<Data, NetworkRouterError>) -> Void


protocol INetworkRouter {
    func request(_ urlRequest: URLRequest, completion: @escaping NetworkRouterCompletion)
}

final class NetworkRouter {
    
}



    // MARK: - INetworkRouter

extension NetworkRouter: INetworkRouter {
    
    func request(_ urlRequest: URLRequest, completion: @escaping NetworkRouterCompletion) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async { completion(.failure(.noInternetConnection)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(.server(reason: "data == nil"))) }
                return
            }
            DispatchQueue.main.async { completion(.success(data)) }
            
        }.resume()
    }
    
}
