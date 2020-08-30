//
//  Cars.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

struct Root: Codable {
    
    let cars: [Car?]?
    
    enum CodingKeys: String, CodingKey {
        case cars = "listings"
    }
}

struct Car: Codable {
    
    let model: String?
    let price: Int?
    let images: CarImages?
    let year: Int?
    let trim: String?
    let make: String?
    let mileage: Int?
    let dealer: Dealer?
    let accidentHistory: AccidentHistory?
    let monthlyPaymentEstimate: MonthlyPaymentEstimate?
    
    enum CodingKeys: String, CodingKey {
        case model
        case price = "currentPrice"
        case images
        case year
        case trim
        case make
        case mileage
        case dealer
        case accidentHistory
        case monthlyPaymentEstimate
    }
}

struct CarImages: Codable {
    
    let photo: Sizes?
    
    enum CodingKeys: String, CodingKey {
        case photo = "firstPhoto"
    }
}

struct Sizes: Codable {
    
    let large: String?
    let medium: String?
    let small: String?
}

struct Dealer: Codable {
    
    let city: String?
    let state: String?
    let phone: String?
    let latitude: String?
    let longitude: String?
}

struct AccidentHistory: Codable {
    
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "text"
    }
}

struct MonthlyPaymentEstimate: Codable {
        
    let downPaymentAmount: Double?
    let downPaymentPercent: Int?
    let interestRate: Int?
    let loanAmount: Double?
    let monthlyPayment: Double?
    let termInMonths: Int?
    let price: Int?
    
    enum CodingKeys: String, CodingKey {
        case downPaymentAmount
        case downPaymentPercent
        case interestRate
        case loanAmount
        case monthlyPayment
        case termInMonths
        case price
    }
}
