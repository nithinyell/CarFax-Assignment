//
//  Utilities.swift
//  CarFax
//
//  Created by Nithin on 28/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import Foundation
import UIKit

struct Utilities {

    func getvehicleTitle(_ car: Car) -> NSAttributedString {
                
        let titleLable = NSMutableAttributedString(string: "")
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : Constants.FONT as Any]
        let boldattributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: Constants.FONT_BOLD as Any]
        
        let year = car.year ?? 0
        let make = car.make ?? ""
        let model = car.model ?? ""
        let trim = car.trim ?? ""
        
        titleLable.append(NSAttributedString(string: "\(year) -", attributes: boldattributes))
        titleLable.append(NSAttributedString(string: " \(make) \(model) ", attributes: boldattributes))
        titleLable.append(NSAttributedString(string: trim, attributes: attributes))
        
        return titleLable
    }
    
    func getVehicleSubTitle(_ car: Car) -> NSAttributedString {
        
        let subTitleLable = NSMutableAttributedString(string: "")
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : Constants.FONT as Any]
        let boldattributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: Constants.FONT_BOLD as Any]
        
        let price = car.price ?? 0
        let mileage = car.mileage ?? 0
        let dealerLocation = "\(car.dealer?.city ?? ""), \(car.dealer?.state ?? "")"
        
        subTitleLable.append(NSAttributedString(string: "$\(price) | ", attributes: boldattributes))
        subTitleLable.append(NSAttributedString(string: " \(mileage) | ", attributes: attributes))
        subTitleLable.append(NSAttributedString(string: dealerLocation, attributes: attributes))
        
        return subTitleLable
    }
}
