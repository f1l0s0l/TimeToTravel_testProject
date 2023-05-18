//
//  TicketCellViewModel.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 18.05.2023.
//

import Foundation

protocol ITicketCellViewModel: AnyObject {
    var ticket: Ticket { get }
    var stateChanged: ((TicketCellViewModel.State) -> Void)? { get set }
    func didChangeStateIsLike()
}

final class TicketCellViewModel {
    
    // MARK: - Enum
    
    enum State {
        case didChangeStateIsLike(before: Bool)
    }
    
    
    // MARK: - Public properties
    
    var ticket: Ticket
    
    var stateChanged: ((TicketCellViewModel.State) -> Void)?
    
    
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



    // MARK: - ITicketCellViewModel

extension TicketCellViewModel: ITicketCellViewModel {
    func didChangeStateIsLike() {
        self.state = .didChangeStateIsLike(before: self.ticket.isLikes)
        self.ticket.isLikes.toggle()
    }
}
