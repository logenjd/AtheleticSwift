//
//  ViewController.swift
//  test
//
//  Created by Logeshwaran  on 22/09/23.
//

import UIKit
class AthletesVC: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    var athletesList:[ModelAthlete]?
    var gamesList:[ModelGame]?
    var athletsViewModel = AthletsViewModel()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    func setupTableView(){
        tableView.register(UINib(nibName: "AthletesTableViewCell", bundle: nil), forCellReuseIdentifier: "AthletesTableViewCell")
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.dataSource = athletsViewModel
        tableView.delegate = athletsViewModel
        tableView.rowHeight = 100
        self.athletsViewModel.reloadTableView(delegate: self,  gamesList: self.gamesList, athlete: nil)
        tableView.reloadData()
    }
   
    @objc func refresh(_ sender: AnyObject) {
        self.fetchData()
        
    }
    func fetchData(){
        NetworkManager.shared.getAllAthletes { data, error in
            self.athletesList = data
            NetworkManager.shared.getAllGames { data, error in
                self.gamesList = data
                self.setupData()
                DispatchQueue.main.async {
                    self.athletsViewModel.reloadTableView(delegate: self,  gamesList: self.gamesList, athlete: nil)
                    self.tableView.reloadData()
                }
            }
        }
    }
    func setupData(){
        gamesList = gamesList?.sorted(by: { $0.yearDate.compare($1.yearDate) == .orderedDescending })
        repeatCall(repeatIndex: 0, gamesList: gamesList ?? [])
    }
    func repeatCall(repeatIndex:Int, gamesList:[ModelGame]){
        if repeatIndex < gamesList.count {
            let game = gamesList[repeatIndex]
            NetworkManager.shared.getAthletesWithGame(id: "\(game.game_id ?? 0)", game:game) { data, game, error in
                if repeatIndex < gamesList.count {
                    let newIndex = repeatIndex + 1
                    self.repeatCall(repeatIndex: newIndex, gamesList: gamesList)
                    DispatchQueue.main.async {
                        self.athletsViewModel.reloadTableView(delegate: self,  gamesList: self.gamesList, athlete: nil)
                        self.tableView.reloadData()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing()
                    }
                    self.gamesList = self.gamesList?.filter({$0.athletesList?.count ?? 0 > 0})
                    DispatchQueue.main.async {
                        self.athletsViewModel.reloadTableView(delegate: self,  gamesList: self.gamesList, athlete: nil)
                        self.tableView.reloadData()
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
            self.gamesList = self.gamesList?.filter({$0.athletesList?.count ?? 0 > 0})
            DispatchQueue.main.async {
                self.athletsViewModel.reloadTableView(delegate: self,  gamesList: self.gamesList, athlete: nil)
                self.tableView.reloadData()
            }
        }
    }
    
}
