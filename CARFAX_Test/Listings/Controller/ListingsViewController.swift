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
    lazy var collectionView         : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.register(VehicleListCell.self, forCellWithReuseIdentifier: VehicleListCell.cellId)
        return cv
    }()
    
    // MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        layoutView()
        fetchListings()
    }
    
    // MARK:- Helpers
    private func configureViews() {
        view.addSubview(collectionView)
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                     leading: 0,
                                                     bottom: 2,
                                                     trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitem: item,
                                                     count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { (cv, indexPath, viewModel) -> UICollectionViewCell? in
            guard let cell = cv.dequeueReusableCell(withReuseIdentifier: VehicleListCell.cellId, for: indexPath) as? VehicleListCell
                else { return nil }
            cell.backgroundColor = .systemBlue
            return cell
        }
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        //eboxSpinner.remove()
        var snapshot = Snapshot()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(vehicleListing)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

// MARK:- Networking Code
private extension ListingsViewController {
    func fetchListings() {
        APIManager
            .shared
            .fetchVehicleListings { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let list):
                    self.vehicleListing = list
                    DispatchQueue.main.async {
                        self.applySnapshot()
                    }
                }
        }
    }
}

