//
//  TicketCell.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import UIKit

class TicketCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private var viewModel: ITicketCellViewModel?
    
    private lazy var startEndCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Санкт - Петербург – Москва"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var thereLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Туда"
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var startCityCodeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "LED"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var startTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "18/05 10:25"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var backLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Обратно"
        label.textColor = .systemGray2
        label.textAlignment = .right
        return label
    }()
    
    private lazy var endCityCodeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "MSK"
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    private lazy var endTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "20/05 10:25"
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "3 590 ₽"
        label.textColor = .purple
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.didTapLikeButton), for: .touchUpInside)
        button.tintColor = .systemGray2
        return button
    }()
    
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.viewModel?.stateChanged = nil
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        var targetSize = targetSize
        targetSize.height = CGFloat.greatestFiniteMagnitude
        
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size
    }
    
    
    // MARK: - Public methods

    func setViewModel(viewModel: ITicketCellViewModel) {
        self.viewModel = viewModel
        
        let startDate = DateManager.getDateStringWithFormatter(from: viewModel.ticket.startDate, dateFormat: "d MMM HH:mm")
        let endDate = DateManager.getDateStringWithFormatter(from: viewModel.ticket.endDate, dateFormat: "d MMM HH:mm")
        // в методе .getDateStringWithFormatter(...
        // есть параметр timeZoneInSecondFromGMT: Int
        // туда по идее надо подставлять значение часового пояса города отправления
        // и значение часового пояса города прибытия
        // На сколько я знаю, дата и время указывается в часовом поясе аэропорта прибытия/отправления
        // У параметра timeZoneInSecondFromGMT: Int есть дефолтное значение "= 0" так как из бэка нам не приходят эти данные
        // по этому оставил их в референсных значениях
        
        let differentDay = DateManager.getDifferenceFromDateToDate(from: viewModel.ticket.startDate, to: viewModel.ticket.endDate)
        
        self.startEndCityLabel.text = "\(viewModel.ticket.startCity) - \(viewModel.ticket.endCity)"
        
        self.startCityCodeValueLabel.text = viewModel.ticket.startLocationCode
        self.startTimeValueLabel.text = startDate
        
        self.endCityCodeValueLabel.text = viewModel.ticket.endLocationCode
        self.endTimeValueLabel.text = endDate
        
        self.priceLabel.text = "\(viewModel.ticket.price) ₽ за \(differentDay) дней"
        
        let imageName = viewModel.ticket.isLikes ? "hand.thumbsup.fill" : "hand.thumbsup"
        let tintColor: UIColor = viewModel.ticket.isLikes ? .red : .systemGray2
        
        self.likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        self.likeButton.tintColor = tintColor
        self.bindViewModel()
    }
    
    
    // MARK: - Private methods
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        viewModel.stateChanged = { [weak self] state in
            switch state {
            case .didChangeStateIsLike(let before):
                self?.likeButtonAnimate(before)
            }
            
        }
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = self.frame.height / 6
        self.contentView.addSubview(self.startEndCityLabel)
        self.contentView.addSubview(self.thereLabel)
        self.contentView.addSubview(self.startCityCodeValueLabel)
        self.contentView.addSubview(self.startTimeValueLabel)
        self.contentView.addSubview(self.backLabel)
        self.contentView.addSubview(self.endCityCodeValueLabel)
        self.contentView.addSubview(self.endTimeValueLabel)
        self.contentView.addSubview(self.priceLabel)
        self.contentView.addSubview(self.likeButton)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.startEndCityLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            self.startEndCityLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            self.startEndCityLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            
            self.thereLabel.topAnchor.constraint(equalTo: self.startEndCityLabel.bottomAnchor, constant: 10),
            self.thereLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.thereLabel.rightAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -20),
            
            self.startCityCodeValueLabel.topAnchor.constraint(equalTo: self.thereLabel.bottomAnchor, constant: 5),
            self.startCityCodeValueLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.startCityCodeValueLabel.rightAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -20),
            
            self.startTimeValueLabel.topAnchor.constraint(equalTo: self.startCityCodeValueLabel.bottomAnchor, constant: 5),
            self.startTimeValueLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
            self.startTimeValueLabel.rightAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -20),
            
            self.backLabel.topAnchor.constraint(equalTo: self.startEndCityLabel.bottomAnchor, constant: 10),
            self.backLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            self.backLabel.leftAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 20),
            
            self.endCityCodeValueLabel.topAnchor.constraint(equalTo: self.backLabel.bottomAnchor, constant: 5),
            self.endCityCodeValueLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            self.endCityCodeValueLabel.leftAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 20),

            self.endTimeValueLabel.topAnchor.constraint(equalTo: self.endCityCodeValueLabel.bottomAnchor, constant: 5),
            self.endTimeValueLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20),
            self.endTimeValueLabel.leftAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 20),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.startTimeValueLabel.bottomAnchor, constant: 20),
            self.priceLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20),
//            self.priceLabel.rightAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -20),
            //НАДО ВЕРНУТЬ!!! а то цена может уезжать
            // пока кол-во дней неадекватное, все двигается (
            self.priceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
            
            self.likeButton.topAnchor.constraint(equalTo: self.endTimeValueLabel.bottomAnchor, constant: 20),
            self.likeButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40),
        ])
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
    
    @objc
    private func didTapLikeButton() {
        self.viewModel?.didChangeStateIsLike()
    }
    
}
