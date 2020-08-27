//
//  Interactor.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

class Interactor {
    
    var delegate: NetworkDelegate?
    
    func getvehicles(handler: @escaping (_ cars: [Car?]?, _ err: Error?) -> Void) {
        
        guard let url = Constants.BASE_URL.asURL()?.appendingPathComponent("/assignment.json") else { return }
        
        delegate?.fetchVehicles(requestURL: url, httpMethod: HTTPMETHOD.get
            , handler: { (root, err) in
                
                guard let carsData = root?.cars, err == nil else {
                    handler(nil, err)
                    return
                }
                
                handler(carsData, nil)
        })
    }
}
