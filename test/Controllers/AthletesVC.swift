//
//  ViewController.swift
//  test
//
//  Created by Logeshwaran  on 22/09/23.
//

import UIKit
class AthletesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    var athletesList:[ModelAthlete]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return athletesList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AthletesCollectionViewCell", for: indexPath) as? AthletesCollectionViewCell{
            let athlete = self.athletesList?[indexPath.row]
            cell.setCell(data: athlete)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        NetworkManager.shared.getAllAthletes { data, error in
            self.athletesList = data
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    func setupPage(){
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = "Olympic Athletes"
        self.navigationItem.title = "some title"
        setupCollectionView()
    }
    func setupCollectionView(){
        collectionView.register(UINib(nibName: "AthletesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AthletesCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = self.flowLayout
        collectionView.reloadData()
    }
}

