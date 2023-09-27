//
//  AthletsViewModel.swift
//  test
//
//  Created by Logeshwaran  on 27/09/23.
//

import UIKit

class AthletsViewModel: NSObject, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Var
    var athletsViewModel:ModelOrderDisplay?
    var delegate:UIViewController?
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    
    override init() {
        super.init()
    }
    func reloadTableView(delegate:UIViewController?, gamesList:[ModelGame]? = nil,athlete:ModelAthlete?, medals:[ModelMedalDetails]? = [], identifier:OrderActionTypes = .athletesList) {
        self.delegate = delegate
        self.setDetails(identifier:identifier, gamesList:gamesList, athlete:athlete, medals: medals)
    }
    //MARK:- Details
    func setDetails(identifier:OrderActionTypes, gamesList:[ModelGame]?, athlete:ModelAthlete?, medals:[ModelMedalDetails]?) {
        athletsViewModel = ModelOrderDisplay(identifier:identifier, gamesList: gamesList,athlete:athlete, medals: medals)
    }

    //MARK:- Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        if athletsViewModel?.identifier == .athletesList{
            return athletsViewModel?.gamesList?.count ?? 0
        }else if athletsViewModel?.identifier == .athletesDetails{
            return 2
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if athletsViewModel?.identifier == .athletesList{
            return 1
        }else if athletsViewModel?.identifier == .athletesDetails{
            if section == 0{
                return athletsViewModel?.medals?.count ?? 0
            }else{
                return 1
            }
        }
        return  0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if athletsViewModel?.identifier == .athletesList{
            let game = athletsViewModel?.gamesList?[indexPath.section]
            return (game?.athletesList?.count ?? 0 >  0) ? 150 : 0
        }else if athletsViewModel?.identifier == .athletesDetails{
            return indexPath.section == 0 ? 50 : UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if athletsViewModel?.identifier == .athletesList{
            let game = athletsViewModel?.gamesList?[section]
            return (game?.athletesList?.count ?? 0 >  0) ? "\(game?.city ?? "")  \(game?.year ?? 0)" : ""
        }else if athletsViewModel?.identifier == .athletesDetails{
            if athletsViewModel?.medals?.count ?? 0 > 0, section == 0{
                return "Medals"
            }
            if (athletsViewModel?.athlete?.bio ?? "").count > 0 , section == 1{
                return "Bio"
            }
        }
        return ""
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if athletsViewModel?.identifier == .athletesList{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AthletesTableViewCell") as? AthletesTableViewCell{
                cell.collectionView.tag = indexPath.section
                cell.collectionView.register(UINib(nibName: "AthletesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AthletesCollectionViewCell")
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                cell.collectionView.showsHorizontalScrollIndicator = false
                cell.collectionView.showsVerticalScrollIndicator = false
                cell.collectionView.collectionViewLayout = self.flowLayout
                cell.collectionView.layoutIfNeeded()
                cell.collectionView.reloadData()
                return cell
            }
        }else if athletsViewModel?.identifier == .athletesDetails{
            if indexPath.section == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MedalTableViewCell") as? MedalTableViewCell, let medel = athletsViewModel?.medals?[indexPath.row] as? ModelMedalDetails{
                    cell.setup(medel: medel)
                    return cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "BioTableViewCell") as? BioTableViewCell{
                    cell.setup(athlete: athletsViewModel?.athlete)
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    
    //Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if athletsViewModel?.identifier == .athletesList{
            return 1
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if athletsViewModel?.identifier == .athletesList{
            return athletsViewModel?.gamesList?[collectionView.tag].athletesList?.count ?? 0
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if athletsViewModel?.identifier == .athletesList{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AthletesCollectionViewCell", for: indexPath) as? AthletesCollectionViewCell, let athlete = athletsViewModel?.gamesList?[collectionView.tag].athletesList?[indexPath.row]{
                cell.setCell(data: athlete)
                return cell
            }else{
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if athletsViewModel?.identifier == .athletesList{
            let width = collectionView.bounds.width
            let numberOfItemsPerRow: CGFloat = 3
            let spacing: CGFloat = flowLayout.minimumInteritemSpacing
            let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
            let itemDimension = floor(availableWidth / numberOfItemsPerRow)
            return CGSize(width: itemDimension, height: 150)
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if athletsViewModel?.identifier == .athletesList{
            if let athlete = athletsViewModel?.gamesList?[collectionView.tag].athletesList?[indexPath.row]{
                print(athlete.name)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                if let vc = storyBoard.instantiateViewController(withIdentifier: "AthleteDetailVC") as? AthleteDetailVC{
                    vc.athlete = athlete
//                    delegate?.collectionViewCellActions(didSelect: indexPath)
                    self.delegate?.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
        }
        
    }
}
    //MARK:- Order Details
    struct ModelOrderDisplay {
        var title:String = ""
        var identifier:OrderActionTypes = .none
        var subItems:[ModelOrderDetailsItems] = []
        var gamesList:[ModelGame]?
        var athlete:ModelAthlete?
        var medals:[ModelMedalDetails]?
        
        
    }
    struct ModelOrderDetailsItems {
        var title:String = ""
        var identifier:OrderActionTypes = .none
        
        //
        
        init(title: String = "", identifier: OrderActionTypes) {
            self.title = title
            self.identifier = identifier
        }
    }
    enum OrderActionTypes:String {
        case none
        case athletesList
        case athletesDetails
    }
    

//    protocol CollectionViewActionsDelegate {
//        func collectionViewCellActions(didSelect indexPath:IndexPath)
//    }
