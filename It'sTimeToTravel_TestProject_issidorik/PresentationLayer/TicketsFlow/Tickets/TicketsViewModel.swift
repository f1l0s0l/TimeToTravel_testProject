//
//  TicketsViewModel.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import Foundation

protocol ITicketsViewModel: AnyObject {
    var stateChanged: ((TicketsViewModel.State) -> Void)? { get set }
    var ticketCellViewModels: [ITicketCellViewModel] { get }
    func reloadCell()
    func getTickets()
    func didTapCell(indexPathItem: Int)
}

final class TicketsViewModel {
    
    // MARK: - Enum
    
    enum State {
        case loading
        case loaded
        case reloadCell(indexPathItem: Int)
        case wrong(alertText: String)
    }
    
    // MARK: - Private properties
    
    private let coordinator: ITicketsCoordinator
    private let createTicketsService: ICreateTicketsService
    
    private var state: State = .loading {
        didSet {
            self.stateChanged?(state)
        }
    }
    
    private var currentIndexCell: Int?
    
    
    // MARK: - Public properties
    
    var stateChanged: ((State) -> Void)?
    var ticketCellViewModels: [ITicketCellViewModel] = []
    
    
    // MARK: - Init
    
    init(coordinator: ITicketsCoordinator, createTicketsService: ICreateTicketsService) {
        self.createTicketsService = createTicketsService
        self.coordinator = coordinator
    }
    
}



    // MARK: - ITiketsViewModel

extension TicketsViewModel: ITicketsViewModel {
    
    func getTickets() {
        self.state = .loading
        self.createTicketsService.tryCreateTickets { [weak self] result in
            switch result {
            case .success(let tickets):
                self?.ticketCellViewModels = tickets.map { TicketCellViewModel(ticket: $0) }
                self?.state = .loaded
                
            case .failure(let error):
                self?.state = .wrong(alertText: error.descriptionForUser)
                #if DEBUG
                print(error.description)
                #endif
            }
        }
    }
    
    func didTapCell(indexPathItem: Int) {
        self.coordinator.pushTickelDetailsViewController(ticket: self.ticketCellViewModels[indexPathItem].ticket)
        self.currentIndexCell = indexPathItem
    }
    
    func reloadCell() {
        guard let indexPathItem = self.currentIndexCell else {
            return
        }
        self.state = .reloadCell(indexPathItem: indexPathItem)
        self.currentIndexCell = nil
    }
}
