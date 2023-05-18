//
//  TicketDetailsViewModel.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 18.05.2023.
//

import Foundation

protocol ITicketDetailsViewModel: AnyObject {
    var stateChanged: ((TicketDetailsViewModel.State) -> Void)? { get set }
    var ticket: Ticket { get }
    func didChangeStateIsLike()
}

final class TicketDetailsViewModel {
    
    // MARK: - Enum
    
    enum State {
        case didChangeStateIsLike(before: Bool)
    }
    
    
    // MARK: - Public properties
    
    var ticket: Ticket
    
    var stateChanged: ((State) -> Void)?
    
    
    // MARK: - Private properties
    
    private var state: State = .didChangeStateIsLike(before: true) {
        didSet {
            self.stateChanged?(state)
        }
    }
    
    
    // MARK: - Init
    
    init(ticket: Ticket) {
        self.ticket = ticket
    }
    
}



    // MARK: - ITicketDetailsViewModel

extension TicketDetailsViewModel: ITicketDetailsViewModel {
    func didChangeStateIsLike() {
        self.state = .didChangeStateIsLike(before: self.ticket.isLikes)
        self.ticket.isLikes.toggle()
    }
}
