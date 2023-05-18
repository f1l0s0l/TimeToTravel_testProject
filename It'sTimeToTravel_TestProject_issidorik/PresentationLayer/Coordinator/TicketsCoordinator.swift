//
//  TicketsCoordinator.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import UIKit

protocol ITicketsCoordinator {
    func pushTickelDetailsViewController(ticket: Ticket)
}

final class TicketsCoordinator {
    
    // MARK: - Private properties
    
    private let rootViewController: RootViewController
    
    private var navigationVontroller: UINavigationController?
    
    // MARK: - Init
    
    init(rootViewController: RootViewController) {
        self.rootViewController = rootViewController
    }
    
}



    // MARK: - ICoordinator

extension TicketsCoordinator: ICoordinator {
    func start() {
        let networkRouter = NetworkRouter()
        let mapper = Mapper()
        let mainNetworkService = MainNetworkService(networkRouter: networkRouter, mapper: mapper)
        let createTicketsService = CreateTicketsService(mainNetworkService: mainNetworkService)
        
        let viewModel = TicketsViewModel(coordinator: self, createTicketsService: createTicketsService)
        let viewController = TicketsViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationVontroller = navigationController
        
        self.rootViewController.makeShow(to: navigationController)
    }
}



    // MARK: - ITicketsCoordinator

extension TicketsCoordinator: ITicketsCoordinator {
    
    func pushTickelDetailsViewController(ticket: Ticket) {
        let viewModel = TicketDetailsViewModel(ticket: ticket)
        let ticketDetailsViewController = TicketDetailsViewController(viewModel: viewModel)
        self.navigationVontroller?.pushViewController(ticketDetailsViewController, animated: true)
    }
    
}
