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
        print("*********")
    }
    
    private func configureCell() {
        
        if let url = car?.images?.photo?.large?.asURL(), let data = try? Data(contentsOf: url) {
            
            image.image = UIImage(data: data)
        }
        
        title.text = "\(car?.year ?? 0)" + " " + "\(car?.make ?? "")" + " " + "\(car?.model ?? "")" + " " + "\(car?.trim == "Unspecified" ? "" : car?.trim ?? "")"
        
    }
}
