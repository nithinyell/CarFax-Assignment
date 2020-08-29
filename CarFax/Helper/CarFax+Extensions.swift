//
//  CarFax+Extensions.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension String {
    
    func asURL() -> URL? {
        return URL(string: self) ?? nil
    }
    
    func subString(from: Int, to: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
    
    func phoneNumberFormatter() -> String? {
        if self.count != 10 { return "No Contact Found" }
        return "(\(self.subString(from: 0, to: 2))) \(self.subString(from: 3, to: 5)) \(self.subString(from: 6, to: 9))"
    }
}

extension URL {
    
    func fetchImageFromURL(onSuccess: @escaping (UIImage?) -> Void) {
        
        if let image = imageCache.object(forKey: self as AnyObject) as? UIImage {
            onSuccess(image)
            print("USING CACHE")
        } else {
            
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let imageData = try Data(contentsOf: self)
                    if let image = UIImage(data: imageData) {
                        imageCache.setObject(image, forKey: self as AnyObject)
                        onSuccess(image)
                        print("API CALL")
                    }
                } catch {
                    onSuccess(nil)
                }
            }
        }
    }
}
