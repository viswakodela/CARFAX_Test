//
//  ListingsViewController.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController {
    
    // MARK:- Properties
    private var vehicleListing      = [VehicleListViewModel]()
    private lazy var dataSource     = makeDataSource()
    private enum Section: CaseIterable {
        case main
    }
    
    private typealias DataSource    = UICollectionViewDiffableDataSource<Section, VehicleListViewModel>
    private typealias Snapshot      = NSDiffableDataSourceSnapshot<Section, VehicleListViewModel>
    
    // MARK:- Layout Objects
    private lazy var collectionView         : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground//UIColor.CustomColors.vehicleListBGColor
        cv.showsVerticalScrollIndicator = false
        cv.register(VehicleListCell.self, forCellWithReuseIdentifier: VehicleListCell.cellId)
        return cv
    }()
    private let loadingView         = LoadingViewController(isVerticalAligned: true)
    
    private lazy var gestureRecognizer = { [weak self] () -> UITapGestureRecognizer in
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self?.handleOpenMap))
        return tapGesture
    }
    
    // MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        layoutView()
        fetchListings()
    }
    
    // MARK:- Helpers
    private func configureViews() {
        addLogoToNavigationBarItem(image: UIImage(named: "carfax"))
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                     leading: 0,
                                                     bottom: 10,
                                                     trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { [weak self] (cv, indexPath, viewModel) -> UICollectionViewCell? in
            guard let self = self else { return nil }
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: VehicleListCell.cellId, for: indexPath) as? VehicleListCell
                else { return nil }
            let vehicleListModel = self.dataSource.itemIdentifier(for: indexPath)
            cell.configureCell(with: vehicleListModel)
            cell.phoneNumberButton.tag = indexPath.item
            cell.detailsLabel.tag = indexPath.item
            cell.phoneNumberButton.addTarget(self, action: #selector(self.handleTapToPhone), for: .touchUpInside)
            cell.detailsLabel.addGestureRecognizer(self.gestureRecognizer())
            return cell
        }
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(vehicleListing)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

// MARK:- Networking Code
private extension ListingsViewController {
    func fetchListings() {
        add(loadingView)
        APIManager
            .shared
            .fetchVehicleListings { [weak self] (result) in
                guard let `self` = self else { return }
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let list):
                    self.vehicleListing = list
                    DispatchQueue.main.async {
                        self.loadingView.remove()
                        self.applySnapshot()
                    }
                }
        }
    }
}

// MARK:- Action Methods
private extension ListingsViewController {
    @objc
    func handleTapToPhone(button: UIButton) {
        let dealerNumber = vehicleListing[button.tag].carDealerContact
        dealerNumber.callIfCallable(to: dealerNumber, viewController: self)
    }
    
    @objc func handleOpenMap(gesture: UITapGestureRecognizer) {
        if let label = gesture.view as? UILabel {
            let dealerLocationLatitude = vehicleListing[label.tag].dealerLocationCoordinates.0
            let dealerLocationLongitude = vehicleListing[label.tag].dealerLocationCoordinates.1
            
            // User can able to open Google Maps if he/she has the app installed.
            if let url = URL(string: "comgooglemaps://?center=\(dealerLocationLatitude),\(dealerLocationLongitude)&zoom=14&views=traffic") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    NSLog("Can't use Apple Maps");
                }
            }
        }
    }
}
