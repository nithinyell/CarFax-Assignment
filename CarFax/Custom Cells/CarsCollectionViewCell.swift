//
//  CarsCollectionViewCell.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import UIKit

class CarsCollectionViewCell: UICollectionViewCell {
    
    var car: Car? {
        didSet {
            
            makeUIElements()
            configureCell()
        }
    }
    
    lazy var vehicleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var vechicleTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var vechicleSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dailDealer: UIButton = {
        let dail = UIButton()
        dail.translatesAutoresizingMaskIntoConstraints = false
        dail.setTitleColor(.blue, for: .normal)
        dail.titleLabel?.font = Constants.FONT
        return dail
    }()
    
    
    @objc func onPressCall() {
        
        if let phoneNumber = car?.dealer?.phone {
            Utilities().callDealer(phoneNumber)
        }
    }
    
    private func makeUIElements() {
        
        self.addSubview(vehicleImage)
        self.addSubview(vechicleTitle)
        self.addSubview(vechicleSubTitle)
        self.addSubview(dailDealer)
        
        dailDealer.addTarget(self, action: #selector(onPressCall), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            vehicleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            vehicleImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            vehicleImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16),
            vehicleImage.heightAnchor.constraint(equalToConstant: 250),
            
            vechicleTitle.topAnchor.constraint(equalTo: vehicleImage.bottomAnchor, constant: 8),
            vechicleTitle.leadingAnchor.constraint(equalTo: vehicleImage.leadingAnchor),
            vechicleTitle.widthAnchor.constraint(equalTo: vehicleImage.widthAnchor),
            
            vechicleSubTitle.topAnchor.constraint(equalTo: vechicleTitle.bottomAnchor, constant: 8),
            vechicleSubTitle.leadingAnchor.constraint(equalTo: vehicleImage.leadingAnchor),
            vechicleSubTitle.widthAnchor.constraint(equalTo: vehicleImage.widthAnchor),
            
            dailDealer.topAnchor.constraint(equalTo: vechicleSubTitle.bottomAnchor, constant: 8),
            dailDealer.leadingAnchor.constraint(equalTo: vehicleImage.leadingAnchor),
            dailDealer.widthAnchor.constraint(equalTo: vehicleImage.widthAnchor)
        ])
    }
    
    private func configureCell() {
        
        guard let car = self.car else { return }
        
        let imageUrl = car.images?.photo?.large?.asURL()
        imageUrl?.fetchImageFromURL(onSuccess: { (image) in
            
            DispatchQueue.main.async { [weak self] in
                self?.vehicleImage.image = image
            }
        })
        
        DispatchQueue.main.async { [weak self] in
            self?.dailDealer.setTitle(car.dealer?.phone?.phoneNumberFormatter(), for: .normal)
            self?.vechicleTitle.attributedText = Utilities().getvehicleTitle(car)
            self?.vechicleSubTitle.attributedText = Utilities().getVehicleSubTitle(car)
        }
    }
}
