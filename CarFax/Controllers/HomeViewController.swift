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
        
        navigationItem.title = "Car Fax"
        fetchVahicles()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchVahicles() {
        
        let interactor = Interactor()
        interactor.delegate = NetworkManager()
        interactor.getvehicles().then {[weak self] (results) in
            self?.cars = results.cars
            self?.collectionViewReload()
        }
    }
    
    private func collectionViewReload() {
        
        DispatchQueue.main.async { [weak self] in
            self?.carsCollectionView.reloadData()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CarsCollectionViewCell {
            
            print()
            if let cars = cars {
                cell.backgroundColor = Utilities().randomColor()
                cell.car = cars[indexPath.row]
            }
    
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cars = self.cars else { return }
        
        if let detailViewController = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.car = cars[indexPath.row]
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 375)
    }
}
