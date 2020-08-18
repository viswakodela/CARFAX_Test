//
//  VehicleListCell.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class VehicleListCell: UICollectionViewCell {
    
    // MARK:- Properties
    static let cellId           = String(describing: self)
    
    // MARK:- Layout Objects
    let vehicleImageView        : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.CustomFonts.semiBold20
        label.text = "2014 Acura"
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.CustomFonts.regular15
        label.text = "2014 Acura"
        return label
    }()
    
    let phoneNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("438-923-8665", for: .normal)
        button.titleLabel?.font = UIFont.CustomFonts.semiBold16
        return button
    }()
    
    lazy var bottomStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel,
                                                detailsLabel,
                                                phoneNumberButton,])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fillEqually
        return sv
    }()
    
    // MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        phoneNumberButton.layer.cornerRadius = phoneNumberButton.bounds.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Helpers
    private func configureLayout() {
        addSubview(vehicleImageView)
        addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            vehicleImageView.topAnchor.constraint(equalTo: topAnchor),
            vehicleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vehicleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vehicleImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            bottomStackView.topAnchor.constraint(equalTo: vehicleImageView.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
    }
    
}
