//
//  MainNetworkService.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation

typealias MainNetworkServiceCompletion = (Result<[Flight], MainNetworkServiceError>) -> Void

protocol IMainNetworkService {
    func getTicketsAPI(completion: @escaping MainNetworkServiceCompletion)
}


final class MainNetworkService {
    
    // MARK: - Enum
    
    private enum Constants {
        static let baseUrlString = "https://vmeste.wildberries.ru"
        static let path = "/api/avia-service/twirp/aviaapijsonrpcv1.WebAviaService/GetCheap"
        static let parameters = ["startLocationCode": "LED"]
    }
    
    
    // MARK: - Private properties
    
    private let networkRouter: INetworkRouter
    private let mapper: IMapper
        
    
    // MARK: - Init
    
    init(networkRouter: INetworkRouter, mapper: IMapper) {
        self.networkRouter = networkRouter
        self.mapper = mapper
    }
    
    
    // MARK: - Private methods
    
    private func createUrlRequest() -> URLRequest? {
        guard let url = URL(string: Constants.baseUrlString) else {
            return nil
        }
        var request = URLRequest(url: url.appendingPathComponent(Constants.path))
        request.httpMethod = "POST"
        request.setValue("application/json, text/plain, /", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try? JSONSerialization.data(withJSONObject: Constants.parameters, options: .prettyPrinted)
        request.httpBody = data
        return request
    }
    
}



    // MARK: - IMainNetworkAPI

extension MainNetworkService: IMainNetworkService {
    
    func getTicketsAPI(completion: @escaping MainNetworkServiceCompletion) {
        guard let request = self.createUrlRequest() else {
            DispatchQueue.main.async {
                completion(.failure(.wrongURL))
            }
            return
        }
        
        self.networkRouter.request(request) { [weak self] result in
            switch result {
            case .success(let data):
                
                self?.mapper.decode(from: data, jsonType: FlightsCodable.self, completion: { result in
                    switch result {
                    case .success(let flightCodable):
                        completion(.success(flightCodable.flights))
                        
                    case .failure(let error):
                        completion(.failure(.mapperError(error: error)))
                    }
                })
                
            case .failure(let error):
                completion(.failure(.networkRouterError(error: error)))
            }
        }
        
        
    }
}
