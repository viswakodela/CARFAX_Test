//
//  LoadingViewController.swift
//  CARFAX_Test
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    // MARK:- Init
    private let isVertical                      : Bool
    
    let loadingSpinner: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: .medium)
        av.translatesAutoresizingMaskIntoConstraints = false
        av.hidesWhenStopped = true
        av.startAnimating()
        av.color = UIColor(light: UIColor.CustomColors.grayColor, dark: UIColor(white: 1, alpha: 0.7))
        return av
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.CustomFonts.loadingSpinnerFont10
        label.text = "LOADING"
        label.textAlignment = .center
        label.textColor = UIColor(light: .black, dark: .white)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [loadingSpinner, loadingLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        if isVertical {
            sv.axis = .vertical
            sv.spacing = 2
        } else {
            sv.spacing = 4
            sv.axis = .horizontal
        }
        return sv
    }()
    
    // MARK:- Init
    init(isVerticalAligned: Bool) {
        self.isVertical = isVerticalAligned
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    // MARK:- Helpers
    private func configureLayout() {
        view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
}
