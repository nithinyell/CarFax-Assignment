//
//  HomeViewController.swift
//  CarFax
//
//  Created by Nithin on 27/08/20.
//  Copyright © 2020 Nithin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Properties
    var cars: [Car?]?
    
    //MARK: Outlets
    @IBOutlet weak var carsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let interactor = Interactor()
        interactor.delegate = NetworkManager()
        interactor.getvehicles(handler: {cars, error in
            if error == nil {
                self.cars = cars
                
            }
        })
    }
    
    private func collectionViewReload() {
        
        DispatchQueue.main.async { [weak self] in
            self?.carsCollectionView.reloadData()
        }
    }
    
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 35
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CarsCollectionViewCell {
            
            print()
            if let cars = cars {
                cell.backgroundColor = self.randomColor()
                cell.car = cars[indexPath.row]
            }
    
            return cell
        }
        
        return UICollectionViewCell()
    }
}
