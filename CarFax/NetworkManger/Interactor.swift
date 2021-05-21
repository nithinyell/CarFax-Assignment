//
//  Interactor.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import Promises

class Interactor {
    
    var delegate: NetworkDelegate?
    
    func getvehicles() -> Promise<Results> {
                
        return Promise { fulfill, reject in
           
            guard let url = Constants.BASE_URL.asURL()?.appendingPathComponent("/assignment.json") else {
                return
            }
            
            self.delegate?.fetchVehicles(requestURL: url, httpMethod: .get).then({ (data) in
                return try JSONDecoder().decode(Results.self, from: data)
            }).then({ (results) in
                fulfill(results)
            }).catch({ (error) in
                print("Error ", error)
            })
        }
    }
}
