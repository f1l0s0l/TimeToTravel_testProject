//
//  CreateFlightTicketsService.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation

typealias CreateTicketsServiceCompletion = (Result<[Ticket], MainNetworkServiceError>) -> Void

protocol ICreateTicketsService {
    func tryCreateTickets(completion: @escaping CreateTicketsServiceCompletion)
}

final class CreateTicketsService {
    
    // MARK: Private properties
    
    private let mainNetworkService: IMainNetworkService
    
    private let concurrentQueue = DispatchQueue(label: "CreateFlightTicketsServiceQueue", qos: .utility)
    
    
    // MARK: - Init
    
    init(mainNetworkService: IMainNetworkService) {
        self.mainNetworkService = mainNetworkService
    }
    
    
    // MARK: - Private methods
    
    private func createTicketsFromFlightsCadable(flights: [Flight]) -> [Ticket] {
        flights.compactMap {
            guard let startDate = DateManager.createDateFromString(form: $0.startDate, dateStringFormatter: "yyyy-MM-dd HH:mm:ss ZZZZ zzz"),
                  let endDate = DateManager.createDateFromString(form: $0.endDate, dateStringFormatter: "yyyy-MM-dd HH:mm:ss ZZZZ zzz")
            else {
                return nil
            }
            let ticket = Ticket(
                startDate: startDate,
                endDate: endDate,
                startLocationCode: $0.startLocationCode,
                endLocationCode: $0.endLocationCode,
                startCity: $0.startCity,
                endCity: $0.endCity,
                price: $0.price,
                searchToken: $0.searchToken
            )
            return ticket
        }
    }
}



    // MARK: - ICreateFlightTicketsService

extension CreateTicketsService: ICreateTicketsService {
    
    func tryCreateTickets(completion: @escaping CreateTicketsServiceCompletion) {
        self.mainNetworkService.getTicketsAPI { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let flights):
                self.concurrentQueue.async {
                    let tickets = self.createTicketsFromFlightsCadable(flights: flights)
                    DispatchQueue.main.async { completion(.success(tickets)) }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
