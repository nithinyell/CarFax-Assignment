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
        
        let price = Utilities().getCurrenyFormat(car.price ?? 0)
        let mileage = Utilities().getMileageFormat(car.mileage ?? 0)
        let dealerLocation = "\(car.dealer?.city ?? ""), \(car.dealer?.state ?? "")"
        
        subTitleLable.append(NSAttributedString(string: "\(price) | ", attributes: boldattributes))
        subTitleLable.append(NSAttributedString(string: " \(mileage) Mi | ", attributes: attributes))
        subTitleLable.append(NSAttributedString(string: dealerLocation, attributes: attributes))
        
        return subTitleLable
    }
    
    func randomColor() -> UIColor {
        
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 0.3)
    }
    
    func getCurrenyFormat(_ price: Int) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: price)) ?? "$--.00"
    }
    
    func getMileageFormat(_ mileage: Int) -> String {
        
        let formatter = NumberFormatter()
        formatter.positiveFormat = "0K"
        formatter.multiplier = 0.001
        
        return formatter.string(from: NSNumber(value: mileage)) ?? "Not Avaliable"
    }
    
    func callDealer(_ ph: String?) {
        if let phoneNumber = ph, let phoneNumberAsUrl = "tel://\(phoneNumber)".asURL() {
            
            if UIApplication.shared.canOpenURL(phoneNumberAsUrl) {
                UIApplication.shared.open(phoneNumberAsUrl)
            } else {
                print("This feature is not supported")
            }
        }
    }
}
