//
//  NetworkManager.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import Foundation
import Promises

enum HTTPMETHOD: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

protocol NetworkDelegate {
    func fetchVehicles(requestURL: URL, httpMethod: HTTPMETHOD) -> Promise<Data>
}

class NetworkManager: NetworkDelegate {
    
    func fetchVehicles(requestURL: URL, httpMethod: HTTPMETHOD) -> Promise<Data> {
        
        // Request URL
        var request = URLRequest(url: requestURL)
        
        // HTTP Method
        request.httpMethod = httpMethod.rawValue
        
        return Promise { fulfill, reject in
            
            DispatchQueue.global(qos: .userInitiated).async {
                // Session
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    
                    if let error = error {
                        reject(error)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
                    
                    if let responseData = data {
                        fulfill(responseData)
                    }
                }.resume()
            }
        }
    }
}
