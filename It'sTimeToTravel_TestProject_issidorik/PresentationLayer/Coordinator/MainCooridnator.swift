//
//  MainCooridnator.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import UIKit

final class MainCoordinator {
    
    // MARK: - Private properties
    
    private let rootViewController: RootViewController
    
    private var childCoordinators: [ICoordinator] = []
    
    
    // MARK: - Init
    
    init(rootViewController: RootViewController) {
        self.rootViewController = rootViewController
    }
    
    
    // MARK: - Private methods
    
    private func addChildCoordinator(_ coordinator: ICoordinator) {
        guard !self.childCoordinators.contains(where: {$0 === coordinator}) else {
            return
        }
        self.childCoordinators.append(coordinator)
    }

    private func removeChildCoordinator(_ coordinator: ICoordinator) {
        self.childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
}



    // MARK: - ICoordinator

extension MainCoordinator: ICoordinator {
    func start() {
        let ticketsCoordinator = TicketsCoordinator(rootViewController: self.rootViewController)
        ticketsCoordinator.start()
        self.addChildCoordinator(ticketsCoordinator)
    }
}
