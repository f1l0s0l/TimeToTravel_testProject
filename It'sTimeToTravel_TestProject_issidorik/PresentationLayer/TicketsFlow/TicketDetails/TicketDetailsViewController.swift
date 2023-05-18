//
//  TicketDetailsViewController.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import UIKit

final class TicketDetailsViewController: UIViewController {
    
    // MARK: - Provate properties
    
    private let viewModel: ITicketDetailsViewModel
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGray6
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var thereView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var thereLabel: UILabel = {
        let label = UILabel()
        label.text = "Туда"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var thereTakeoffImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "airplane.departure")
        imageView.tintColor = .purple
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var thereStartCityValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
//        label.text = "Санкт - Петербург (LED)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var thereStartTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18/05 10:25"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var thereTimeFlightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "В пути"
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var thereTimeFlightValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "01 ч 35 мин(доработать бэк)"
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var thereLandingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "airplane.arrival")
        imageView.tintColor = .purple
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var thereEndCityValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.text = "Москва (SVO)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var thereEndTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18/05 12:15(доработать бэк)"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        label.text = "Обратно"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backTakeoffImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "airplane.departure")
        imageView.tintColor = .purple
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backStartCityValueLabel: UILabel = {
        let label = UILabel()
//        label.text = "Москва (SVO)"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backStartTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18/05 10:25"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var backTimeFlightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "В пути"
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var backTimeFlightValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "01 ч 35 мин(доработать бэк)"
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var backLandingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "airplane.arrival")
        imageView.tintColor = .purple
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backEndCityValueLabel: UILabel = {
        let label = UILabel()
        label.text = "Санкт - Петербург (LED)"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backEndTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18/05 12:15(доработать бэк)"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var timeInTravelView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var timeInTravelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Количество дней в отпуске(доработать бэк)"
        return label
    }()
    
    private lazy var timeInTravelValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "28"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var priceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Цена"
        return label
    }()
    
    private lazy var priceValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "3 576 ₽"
        label.textColor = .purple
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.didTapLikeButton), for: .touchUpInside)
        return button
    }()
    
   
    
    
    // MARK: - Lifecycles
    
    init(viewModel: ITicketDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupAddSubwiews()
        self.setupConstraint()
        self.bindViewModel()
    }
    
    
    // MARK: - Private methods
    
    private func bindViewModel() {
        self.viewModel.stateChanged = { [weak self] state in
            switch state {
            case .didChangeStateIsLike(let before):
                self?.likeButtonAnimate(before)
            }
        }
    }
    
    private func setupView() {
        let ticket = self.viewModel.ticket
        self.view.backgroundColor = .systemGray5
        self.title = "\(self.viewModel.ticket.startLocationCode) - \(self.viewModel.ticket.endLocationCode)"
        
        let imageName = ticket.isLikes ? "hand.thumbsup.fill" : "hand.thumbsup"
        let tintColor: UIColor = ticket.isLikes ? .red : .systemGray2
        
        self.likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        self.likeButton.tintColor = tintColor
        
        let dateStart = DateManager.getDateStringWithFormatter(from: ticket.startDate, dateFormat: "d MMM HH:mm")
        let dateEnd = DateManager.getDateStringWithFormatter(from: ticket.endDate, dateFormat: "d MMM HH:mm")
        let diffTime = DateManager.getDifferenceFromDateToDate(from: ticket.startDate, to: ticket.endDate)
        
        self.thereStartCityValueLabel.text = "\(ticket.startCity) (\(ticket.startLocationCode))"
        self.thereStartTimeValueLabel.text = dateStart
        self.thereEndCityValueLabel.text = "\(ticket.endCity) (\(ticket.endLocationCode))"
        
        self.backStartCityValueLabel.text = "\(ticket.endCity) (\(ticket.endLocationCode))"
        self.backStartTimeValueLabel.text = dateEnd
        self.backEndCityValueLabel.text = "\(ticket.startCity) (\(ticket.startLocationCode))"
        
        self.timeInTravelValueLabel.text = diffTime
        
        self.priceValueLabel.text = "\(ticket.price) ₽" //Лучше переделаю под локализацию
    }
    
    private func likeButtonAnimate(_ bool: Bool) {
        let imageName = bool ? "hand.thumbsup" : "hand.thumbsup.fill"
        let tintColor: UIColor = bool ? .systemGray2 : .red
        
        UIView.animateKeyframes(
            withDuration: 0.3,
            delay: 0.0,
            options: []) {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.3) {
                        self.likeButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        self.likeButton.setImage(UIImage(systemName: imageName), for: .normal)
                    }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.3,
                    relativeDuration: 0.7) {
                        self.likeButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.likeButton.tintColor = tintColor
                    }
            } completion: { _ in
            }
    }
    
    private func setupAddSubwiews() {
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.thereView)
        self.thereView.addSubview(self.thereLabel)
        self.thereView.addSubview(self.thereTakeoffImageView)
        self.thereView.addSubview(self.thereStartCityValueLabel)
        self.thereView.addSubview(self.thereStartTimeValueLabel)
        self.thereView.addSubview(self.thereTimeFlightLabel)
        self.thereView.addSubview(self.thereTimeFlightValueLabel)
        self.thereView.addSubview(self.thereLandingImageView)
        self.thereView.addSubview(self.thereEndCityValueLabel)
        self.thereView.addSubview(self.thereEndTimeValueLabel)
        
        self.scrollView.addSubview(self.backView)
        self.backView.addSubview(self.backLabel)
        self.backView.addSubview(self.backTakeoffImageView)
        self.backView.addSubview(self.backStartCityValueLabel)
        self.backView.addSubview(self.backStartTimeValueLabel)
        self.backView.addSubview(self.backTimeFlightLabel)
        self.backView.addSubview(self.backTimeFlightValueLabel)
        self.backView.addSubview(self.backLandingImageView)
        self.backView.addSubview(self.backEndCityValueLabel)
        self.backView.addSubview(self.backEndTimeValueLabel)
        
        self.scrollView.addSubview(self.timeInTravelView)
        self.timeInTravelView.addSubview(self.timeInTravelLabel)
        self.timeInTravelView.addSubview(self.timeInTravelValueLabel)

        self.scrollView.addSubview(self.priceView)
        self.priceView.addSubview(self.priceLabel)
        self.priceView.addSubview(self.priceValueLabel)
        self.priceView.addSubview(self.likeButton)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            
            self.thereView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 30),
            self.thereView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.thereView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
            
            self.thereLabel.topAnchor.constraint(equalTo: self.thereView.topAnchor, constant: 10),
            self.thereLabel.leftAnchor.constraint(equalTo: self.thereView.leftAnchor, constant: 20),
            
            self.thereTakeoffImageView.topAnchor.constraint(equalTo: self.thereLabel.bottomAnchor, constant: 25),
            self.thereTakeoffImageView.leftAnchor.constraint(equalTo: self.thereView.leftAnchor, constant: 20),

            self.thereStartCityValueLabel.topAnchor.constraint(equalTo: self.thereTakeoffImageView.topAnchor),
            self.thereStartCityValueLabel.leftAnchor.constraint(equalTo: self.thereTakeoffImageView.rightAnchor, constant: 10),
            
            self.thereStartTimeValueLabel.topAnchor.constraint(equalTo: self.thereStartCityValueLabel.bottomAnchor, constant: 25),
            self.thereStartTimeValueLabel.leftAnchor.constraint(equalTo: self.thereStartCityValueLabel.leftAnchor),
            
            self.thereTimeFlightLabel.topAnchor.constraint(equalTo: self.thereStartTimeValueLabel.bottomAnchor, constant: 30),
            self.thereTimeFlightLabel.leftAnchor.constraint(equalTo: self.thereView.leftAnchor, constant: 30),
            
            self.thereTimeFlightValueLabel.topAnchor.constraint(equalTo: self.thereTimeFlightLabel.topAnchor),
            self.thereTimeFlightValueLabel.leftAnchor.constraint(equalTo: self.thereTimeFlightLabel.rightAnchor, constant: 10),
            
            self.thereLandingImageView.topAnchor.constraint(equalTo: self.thereTimeFlightValueLabel.bottomAnchor, constant: 30),
            self.thereLandingImageView.leftAnchor.constraint(equalTo: self.thereView.leftAnchor, constant: 20),

            self.thereEndCityValueLabel.topAnchor.constraint(equalTo: self.thereLandingImageView.topAnchor),
            self.thereEndCityValueLabel.leftAnchor.constraint(equalTo: self.thereLandingImageView.rightAnchor, constant: 10),
            
            self.thereEndTimeValueLabel.topAnchor.constraint(equalTo: self.thereEndCityValueLabel.bottomAnchor, constant: 25),
            self.thereEndTimeValueLabel.leftAnchor.constraint(equalTo: self.thereEndCityValueLabel.leftAnchor),
            self.thereEndTimeValueLabel.bottomAnchor.constraint(equalTo: self.thereView.bottomAnchor, constant: -20),
            
            
            self.backView.topAnchor.constraint(equalTo: self.thereView.bottomAnchor, constant: 30),
            self.backView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.backView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
            
            self.backLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 10),
            self.backLabel.leftAnchor.constraint(equalTo: self.backView.leftAnchor, constant: 20),
            
            self.backTakeoffImageView.topAnchor.constraint(equalTo: self.backLabel.bottomAnchor, constant: 25),
            self.backTakeoffImageView.leftAnchor.constraint(equalTo: self.backView.leftAnchor, constant: 20),

            self.backStartCityValueLabel.topAnchor.constraint(equalTo: self.backTakeoffImageView.topAnchor),
            self.backStartCityValueLabel.leftAnchor.constraint(equalTo: self.backTakeoffImageView.rightAnchor, constant: 10),
            
            self.backStartTimeValueLabel.topAnchor.constraint(equalTo: self.backStartCityValueLabel.bottomAnchor, constant: 25),
            self.backStartTimeValueLabel.leftAnchor.constraint(equalTo: self.backStartCityValueLabel.leftAnchor),
            
            self.backTimeFlightLabel.topAnchor.constraint(equalTo: self.backStartTimeValueLabel.bottomAnchor, constant: 30),
            self.backTimeFlightLabel.leftAnchor.constraint(equalTo: self.backView.leftAnchor, constant: 30),
            
            self.backTimeFlightValueLabel.topAnchor.constraint(equalTo: self.backTimeFlightLabel.topAnchor),
            self.backTimeFlightValueLabel.leftAnchor.constraint(equalTo: self.backTimeFlightLabel.rightAnchor, constant: 10),
            
            self.backLandingImageView.topAnchor.constraint(equalTo: self.backTimeFlightValueLabel.bottomAnchor, constant: 30),
            self.backLandingImageView.leftAnchor.constraint(equalTo: self.backView.leftAnchor, constant: 20),

            self.backEndCityValueLabel.topAnchor.constraint(equalTo: self.backLandingImageView.topAnchor),
            self.backEndCityValueLabel.leftAnchor.constraint(equalTo: self.backLandingImageView.rightAnchor, constant: 10),
            
            self.backEndTimeValueLabel.topAnchor.constraint(equalTo: self.backEndCityValueLabel.bottomAnchor, constant: 25),
            self.backEndTimeValueLabel.leftAnchor.constraint(equalTo: self.backEndCityValueLabel.leftAnchor),
            self.backEndTimeValueLabel.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -20),
            
            
            self.timeInTravelView.topAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: 30),
            self.timeInTravelView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.timeInTravelView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
            
            self.timeInTravelLabel.topAnchor.constraint(equalTo: self.timeInTravelView.topAnchor, constant: 10),
            self.timeInTravelLabel.leftAnchor.constraint(equalTo: self.timeInTravelView.leftAnchor, constant: 10),
            
            self.timeInTravelValueLabel.topAnchor.constraint(equalTo: self.timeInTravelLabel.bottomAnchor, constant: 10),
            self.timeInTravelValueLabel.leftAnchor.constraint(equalTo: self.timeInTravelView.leftAnchor, constant: 10),
            self.timeInTravelValueLabel.bottomAnchor.constraint(equalTo: self.timeInTravelView.bottomAnchor, constant: -10),
            
            
            self.priceView.topAnchor.constraint(equalTo: self.timeInTravelView.bottomAnchor, constant: 30),
            self.priceView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            self.priceView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
            self.priceView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -30),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.priceView.topAnchor, constant: 10),
            self.priceLabel.leftAnchor.constraint(equalTo: self.priceView.leftAnchor, constant: 10),

            self.priceValueLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 10),
            self.priceValueLabel.leftAnchor.constraint(equalTo: self.priceView.leftAnchor, constant: 10),
            self.priceValueLabel.bottomAnchor.constraint(equalTo: self.priceView.bottomAnchor, constant: -10),

            self.likeButton.centerYAnchor.constraint(equalTo: self.priceView.centerYAnchor),
            self.likeButton.rightAnchor.constraint(equalTo: self.priceView.rightAnchor, constant: -20),
        ])
        
    }
    
    @objc
    private func didTapLikeButton() {
        self.viewModel.didChangeStateIsLike()
    }
    
}
