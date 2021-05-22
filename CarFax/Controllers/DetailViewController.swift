//
//  DetailViewController.swift
//  CarFax
//
//  Created by Nithin on 29/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var car: Car?
    
    lazy var vehicleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var accidentHistory: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Constants.FONT_BOLD
        return label
    }()
    
    lazy var paymentOptions: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Constants.FONT_BOLD
        return label
    }()
    
    lazy var locateDealer: UIButton = {
        let locate = UIButton()
        locate.translatesAutoresizingMaskIntoConstraints = false
        locate.setTitle("Locate Dealer", for: .normal)
        locate.setTitleColor(.blue, for: .normal)
        locate.titleLabel?.font = Constants.FONT
        locate.backgroundColor = Utilities().randomColor()
        return locate
    }()
    
    lazy var singleLineView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Utilities().randomColor()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Details"
        configUI()
        updateUI()
    }
    
    private func configUI() {
        
        view.addSubview(vehicleImage)
        view.addSubview(accidentHistory)
        view.addSubview(paymentOptions)
        view.addSubview(locateDealer)
        view.addSubview(singleLineView)
        
        locateDealer.addTarget(self, action: #selector(onPressLocate), for: .touchUpInside)

        NSLayoutConstraint.activate([
            
            vehicleImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (navigationController?.navigationBar.frame.height ?? 44) + 35),
            vehicleImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            vehicleImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16),
            vehicleImage.heightAnchor.constraint(equalToConstant: 300),
            
            accidentHistory.topAnchor.constraint(equalTo: vehicleImage.bottomAnchor, constant: 8),
            accidentHistory.leadingAnchor.constraint(equalTo: vehicleImage.leadingAnchor),
            accidentHistory.widthAnchor.constraint(equalTo: vehicleImage.widthAnchor),
            
            singleLineView.topAnchor.constraint(equalTo: accidentHistory.bottomAnchor, constant: 10),
            singleLineView.heightAnchor.constraint(equalToConstant: 1.5),
            singleLineView.leadingAnchor.constraint(equalTo: vehicleImage.leadingAnchor),
            singleLineView.widthAnchor.constraint(equalTo: vehicleImage.widthAnchor),
            
            paymentOptions.topAnchor.constraint(equalTo: singleLineView.bottomAnchor, constant: 10),
            paymentOptions.widthAnchor.constraint(equalTo: vehicleImage.widthAnchor),
            paymentOptions.leadingAnchor.constraint(equalTo: vehicleImage.leadingAnchor),
            
            locateDealer.topAnchor.constraint(equalTo: paymentOptions.bottomAnchor, constant: 20),
            locateDealer.widthAnchor.constraint(equalTo: paymentOptions.widthAnchor),
            locateDealer.leadingAnchor.constraint(equalTo: vehicleImage.leadingAnchor),
        ])
    }
    
    private func updateUI() {
        
        guard let car = car else {
            return
        }
        
        let imageUrl = car.images?.photo?.large?.asURL()
        imageUrl?.fetchImageFromURL(onSuccess: { (image) in
            
            DispatchQueue.main.async { [weak self] in
                self?.vehicleImage.image = image
            }
        })
        
        accidentHistory.text = "Accident History: " + (car.accidentHistory?.message ?? "")
        paymentOptions.text = "Down Payment: \(Utilities().getCurrenyFormat(car.monthlyPaymentEstimate?.downPaymentAmount ?? 0))\n" +
            "Down Payment Percentage: \(car.monthlyPaymentEstimate?.downPaymentPercent ?? 0)%\n" +
            "Loan Amount: \(Utilities().getCurrenyFormat(car.monthlyPaymentEstimate?.loanAmount ?? 0))\n" +
            "Monthly Payment: \(Utilities().getCurrenyFormat(car.monthlyPaymentEstimate?.monthlyPayment ?? 0))\n" +
        "Grand Price: \(Utilities().getCurrenyFormat(Double(car.monthlyPaymentEstimate?.price ?? 0)))"
    }
    
    @objc func onPressLocate() {
        
        if let lat = car?.dealer?.latitude, let long = car?.dealer?.longitude {
            Utilities().openGoogleMaps(lat, long)
        }
    }
}
