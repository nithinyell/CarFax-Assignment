//
//  NetworkManager.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import Foundation

enum HTTPMETHOD: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

protocol NetworkDelegate {
    func fetchVehicles(requestURL: URL, httpMethod: HTTPMETHOD, handler: @escaping (_ onSuccess: Root?, _ error: Error?) -> Void)
}

class NetworkManager: NetworkDelegate {
    
    func fetchVehicles(requestURL: URL, httpMethod: HTTPMETHOD, handler: @escaping (Root?, Error?) -> Void) {
        
        // Request URL
        var request = URLRequest(url: requestURL)
        
        // HTTP Method
        request.httpMethod = httpMethod.rawValue
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Session
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let error = error {
                    handler(nil, error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
                
                if let responseData = data {
                    
                    do {
                        let vehiclesSummary = try JSONDecoder().decode(Root.self, from: responseData)
                        handler(vehiclesSummary, nil)
                    } catch {
                        print("JSON Decode Fail", error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}
