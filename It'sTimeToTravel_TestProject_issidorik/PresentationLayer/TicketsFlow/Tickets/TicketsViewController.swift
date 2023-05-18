//
//  TicketsViewController.swift
//  It'sTimeToTravel_TestProject_issidorik
//
//  Created by Илья Сидорик on 16.05.2023.
//

import UIKit

class TicketsViewController: UIViewController {
    
    // MARK: - Constant
    
    enum Constant {
        static let colums: CGFloat = 1
        static let sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        static let minimumLineSpacing: CGFloat = 10
        static let minimumInteritemSpacing: CGFloat = 0
        
        static func getItemWigth(widthWindow: CGFloat) -> CGFloat {
            let itemWidth =
            widthWindow -
            ((self.colums - 1) * self.minimumInteritemSpacing) -
            self.sectionInset.left -
            self.sectionInset.right
            
            return itemWidth
        }
        
    }

    // MARK: - Private properties
        
    private let viewModel: ITicketsViewModel
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constant.minimumLineSpacing
        layout.minimumInteritemSpacing = Constant.minimumInteritemSpacing
        layout.sectionInset = Constant.sectionInset
        let itemWidth = Constant.getItemWigth(widthWindow: self.view.bounds.width)
        layout.estimatedItemSize = CGSize(width: itemWidth, height: 150)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(TicketCell.self, forCellWithReuseIdentifier: "TicketCellID")
        collectionView.refreshControl = self.refreshControll
        return collectionView
    }()
    
    private lazy var refreshControll: UIRefreshControl = {
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(self.didChangedValueRefreshControll), for: .valueChanged)
        return refreshControll
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        view.alpha = 0.6
        view.isHidden = true
        return view
    }()
    
    
    // MARK: - Lifecycles
    
    init(viewModel: ITicketsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraint()
        self.bindViewModel()
        self.viewModel.getTickets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.reloadCell()
    }
    
    
    // MARK: - Private methods
    
    private func bindViewModel() {
        self.viewModel.stateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.startStopLoading(isStart: true)
                
            case .loaded:
                self.startStopLoading(isStart: false)
                self.collectionView.reloadData()
                
            case .reloadCell(let indexPathItem):
                self.collectionView.reloadItems(at: [IndexPath(item: indexPathItem, section: 0)])
                
            case .wrong(let alertText):
                self.startStopLoading(isStart: false)
                AlertNotification.shared.presentDefaultWrongAlert(
                    for: self,
                    title: "Ошибка!",
                    message: alertText
                )
            }
            
        }
    }
    
    private func setupView() {
        self.title = "Пора в путеществие"
        self.view.backgroundColor = .systemGray5
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.loadingView)
        self.view.addSubview(self.activityIndicator)
    }
    
    private func startStopLoading(isStart: Bool) {
        if isStart {
            self.refreshControll.beginRefreshing()
            self.loadingView.isHidden = false
        } else {
            self.refreshControll.endRefreshing()
            self.loadingView.isHidden = true
        }
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    @objc
    private func didChangedValueRefreshControll() {
        self.viewModel.getTickets()
    }


}



    // MARK: - UICollectionViewDataSource

extension TicketsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.ticketCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "TicketCellID", for: indexPath) as? TicketCell else {
            return UICollectionViewCell()
        }
        cell.setViewModel(viewModel: self.viewModel.ticketCellViewModels[indexPath.item])
        return cell
    }
    
}



    // MARK: - UICollectionViewDelegateFlowLayout

extension TicketsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didTapCell(indexPathItem: indexPath.item)
    }
    
}


