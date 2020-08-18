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
    let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let vehicleImageView        : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.CustomFonts.semiBold16
        label.text = "2014 Acura"
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.CustomFonts.regular15
        label.text = "2014 Acura"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let phoneNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("(###) ###-####", for: .normal)
        button.titleLabel?.font = UIFont.CustomFonts.semiBold15
        return button
    }()
    
    lazy var bottomStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel,
                                                detailsLabel,
                                                phoneNumberButton,])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 2
        sv.setCustomSpacing(10, after: detailsLabel)
        sv.distribution = .fillProportionally
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
        backgroundColor = .systemBackground
        addSubview(imageContainerView)
        imageContainerView.addSubview(vehicleImageView)
        addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            imageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            imageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            vehicleImageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            vehicleImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            vehicleImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
            vehicleImageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            
            bottomStackView.topAnchor.constraint(equalTo: vehicleImageView.bottomAnchor, constant: 4),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
    }
    
    func configureCell(with viewModel: VehicleListViewModel?) {
        if let vehicleDetails = viewModel {
            titleLabel.text = "\(vehicleDetails.vehicleYear) • \(vehicleDetails.vehicleMake) \(vehicleDetails.vehicleModel)"
            detailsLabel.attributedText = createAttributedString(for: vehicleDetails)
            vehicleImageView.loadImage(urlString: vehicleDetails.vehicleHDImage)
            let dealerPhone = vehicleDetails.carDealerContact.applyPatternOnNumbers(pattern: "(###) ###-####", replacementCharacter: "#")
            phoneNumberButton.setTitle(dealerPhone, for: .normal)
        }
    }
    
    private func createAttributedString(for viewModel: VehicleListViewModel) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: viewModel.vehiclePrice,
                                                         attributes: [NSAttributedString.Key.font : UIFont.CustomFonts.semiBold15])
        let milageString = NSAttributedString(string: " | \(viewModel.vehicleMileage) Mi | ",
                                              attributes: [NSAttributedString.Key.font : UIFont.CustomFonts.regular15])
        let addressString = NSAttributedString(string: viewModel.carDealerAddress,
                                               attributes: [NSAttributedString.Key.font : UIFont.CustomFonts.regular15,
                                                            NSAttributedString.Key.foregroundColor : UIColor.systemBlue,])
        attributedString.append(milageString)
        attributedString.append(addressString)
        return attributedString
    }
}
