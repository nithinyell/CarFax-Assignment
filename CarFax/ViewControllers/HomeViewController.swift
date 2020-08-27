//
//  HomeViewController.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let interactor = Interactor()
        interactor.delegate = NetworkManager()
        interactor.getvehicles(handler: {cars, error in
            print("*****", cars)
        })
    }
}
