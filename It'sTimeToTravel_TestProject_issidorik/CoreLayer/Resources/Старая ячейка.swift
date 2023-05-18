//
//  TicketCell.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

//import UIKit
//
//class TicketCell: UICollectionViewCell {
//    
//    // MARK: - Private Properties
//    
//    private var viewModel: FlightTicket?
//    
//    private lazy var startEndCityLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "LED - MOS"
//        label.textColor = .systemGray2
//        return label
//    }()
//    
//    private lazy var startEndTimeLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "19:10 - 20:30"
//        return label
//    }()
//    
//    private lazy var priceLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "3 590 ₽"
//        label.textColor = .purple
//        return label
//    }()
//    
//    private lazy var travelTimeLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "В пути"
//        label.textColor = .systemGray2
//        return label
//    }()
//    
//    private lazy var travelTimeValueLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "1 ч 20 мин"
//        return label
//    }()
//    
//    private lazy var likeButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
////        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
//        button.addTarget(self, action: #selector(self.didTapLikeButton), for: .touchUpInside)
//        button.tintColor = .systemGray2
//        return button
//    }()
//    
//    
//    // MARK: - Init
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.setupView()
//        self.setupConstraint()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    // MARK: - Public methods
//
//    func setViewModel(viewModel: FlightTicket) {
//        self.viewModel = viewModel
//        
//        let startDate = DateManager.getDateStringWithFormatter(from: viewModel.startDate, dateFormat: "HH:mm")
//        let endDate = DateManager.getDateStringWithFormatter(from: viewModel.endDate, dateFormat: "HH:mm")
//        // в методе .getDateStringWithFormatter(...
//        // есть параметр timeZoneInSecondFromGMT: Int
//        // туда по идее надо подставлять значение часового пояса города отправления
//        // и значение часового пояса города прибытия
//        // На сколько я знаю, дата и время указывается в часовом поясе аэропорта прибытия/отправления
//        // У параметра timeZoneInSecondFromGMT: Int есть дефолтное значение "= 0" так как из бэка нам не приходят эти данные
//        // по этому оставил их в референсных значениях
//        
//        
////        let tradelTimeDate = DateManager.getDateStringWithFormatter(from: viewModel.endDate - viewModel.startDate, dateFormat: <#T##String#>)
//        let travelTime = DateManager.getDifferenceFromDateToDate(from: viewModel.startDate, to: viewModel.endDate)
//        
////        self.startEndCityLabel.text = "\(viewModel.startLocationCode) - \(viewModel.endLocationCode)"
//        self.startEndCityLabel.text = "\(viewModel.startCity) - \(viewModel.endCity)"
//
//        
//        self.startEndTimeLabel.text = "\(startDate) - \(endDate)"
//        self.priceLabel.text = "\(viewModel.price) ₽"
//        self.travelTimeValueLabel.text = "\(travelTime.day)"
//        
//        let imageName = viewModel.isLikes ? "hand.thumbsup" : "hand.thumbsup.fill"
//        self.likeButton.setImage(UIImage(systemName: imageName), for: .normal)
//    }
//    
//    
//    // MARK: - Private methods
//    
//    private func setupView() {
//        self.backgroundColor = .white
//        self.layer.cornerRadius = self.frame.height / 6
//        self.contentView.addSubview(self.startEndCityLabel)
//        self.contentView.addSubview(self.startEndTimeLabel)
//        self.contentView.addSubview(self.priceLabel)
//        self.contentView.addSubview(self.travelTimeLabel)
//        self.contentView.addSubview(self.travelTimeValueLabel)
//        self.contentView.addSubview(self.likeButton)
//    }
//    
//    private func setupConstraint() {
//        NSLayoutConstraint.activate([
//            self.startEndCityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
//            self.startEndCityLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
//            
//            self.startEndTimeLabel.topAnchor.constraint(equalTo: self.startEndCityLabel.bottomAnchor, constant: 5),
//            self.startEndTimeLabel.leftAnchor.constraint(equalTo: self.startEndCityLabel.leftAnchor),
//            
//            self.priceLabel.topAnchor.constraint(equalTo: self.startEndTimeLabel.bottomAnchor, constant: 20),
//            self.priceLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
//            self.priceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
//            
//            self.travelTimeLabel.topAnchor.constraint(equalTo: self.startEndCityLabel.topAnchor),
//            self.travelTimeLabel.leftAnchor.constraint(equalTo: self.travelTimeValueLabel.leftAnchor),
//            
//            self.travelTimeValueLabel.topAnchor.constraint(equalTo: self.travelTimeLabel.bottomAnchor, constant: 5),
////            self.travelTimeValueLabel.leftAnchor.constraint(equalTo: self.travelTimeLabel.leftAnchor),
//            self.travelTimeValueLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15),
//            
//            self.likeButton.centerXAnchor.constraint(equalTo: self.travelTimeLabel.centerXAnchor),
//            self.likeButton.centerYAnchor.constraint(equalTo: self.priceLabel.centerYAnchor),
//        ])
//        
////        self.startEndTimeLabel.preferredMaxLayoutWidth = 100
////        self.travelTimeValueLabel.preferredMaxLayoutWidth = 100
//    }
//    
//    @objc
//    private func didTapLikeButton() {
//        UIView.animateKeyframes(
//            withDuration: 0.3,
//            delay: 0.0,
//            options: []) {
//                UIView.addKeyframe(
//                    withRelativeStartTime: 0.0,
//                    relativeDuration: 0.3) {
//                        self.likeButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                        self.likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
//                    }
//                UIView.addKeyframe(
//                    withRelativeStartTime: 0.3,
//                    relativeDuration: 0.7) {
//                        self.likeButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                        self.likeButton.tintColor = .red
//                    }
//            } completion: { _ in
//                ()
//            }
//    }
//    
//}
