//
//  CarFax+Extensions.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import Foundation

extension String {
    
    func asURL() -> URL? {
        return URL(string: self) ?? nil
    }
}
