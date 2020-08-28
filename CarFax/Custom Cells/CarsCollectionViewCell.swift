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
            
            configureCell()
        }
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var callDealer: UIButton!
    
    @IBAction func onPressCall(_ sender: Any) {
        
        if let phoneNumber = car?.dealer?.phone, let phoneNumberAsUrl = "tel://\(phoneNumber)".asURL() {
            UIApplication.shared.open(phoneNumberAsUrl)
        }
    }
    
    private func configureCell() {
        
        guard let car = self.car else { return }
        
        let imageUrl = car.images?.photo?.large?.asURL()
            imageUrl?.fetchImageFromURL(onSuccess: { (vehicleImage) in
                
                DispatchQueue.main.async { [weak self] in
                    self?.image.image = vehicleImage
                }
            })
        
        DispatchQueue.main.async { [weak self] in
            self?.callDealer.setTitle(car.dealer?.phone?.phoneNumberFormatter(), for: .normal)
            self?.title.attributedText = Utilities().getvehicleTitle(car)
            self?.subtitle.attributedText = Utilities().getVehicleSubTitle(car)
        }
    }
}
