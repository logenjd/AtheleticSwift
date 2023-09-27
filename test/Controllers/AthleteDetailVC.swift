//
//  AthleteDetailVC.swift
//  test
//
//  Created by Logeshwaran  on 26/09/23.
//

import UIKit

class AthleteDetailVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var hightLabel: UILabel!
    
    @IBOutlet weak var medalsLabel: UILabel!

    
    @IBOutlet weak var bioTitleLabel: UILabel!
    @IBOutlet weak var bioDescriptionLabel: UILabel!
    
    var athlete:ModelAthlete?
    var medals:[ModelMedalDetails] = [ModelMedalDetails]()
    
    var athletsDetailViewModel = AthletsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = athlete?.name ?? ""
        setupView()
        fetchData()
    }
    
    func setupView(){
        setupMedelView()
        if let a = athlete{
            let imgUrl = NetworkManager.shared.k_BaseURL + NetworkManager.shared.k_Photo.replacingOccurrences(of: "{id}", with: a.athlete_id ?? "")
            self.userImageView.contentMode = .scaleAspectFill
            self.userImageView.sd_setImage(with: URL(string:imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
            self.nameLabel.text = "Name: \(a.name ?? "")"
            self.dobLabel.text = "DOB: \(a.dateOfBirth ?? "")"
            self.weightLabel.text = "Weight: \("\(a.weight ?? 0)")kg"
            self.hightLabel.text = "Height: \("\(a.height ?? 0)")cm"
        }
        

    }
    func setupMedelView(){
        tableView.register(UINib(nibName: "MedalTableViewCell", bundle: nil), forCellReuseIdentifier: "MedalTableViewCell")
        tableView.register(UINib(nibName: "BioTableViewCell", bundle: nil), forCellReuseIdentifier: "BioTableViewCell")
        tableView.dataSource = athletsDetailViewModel
        tableView.delegate = athletsDetailViewModel
    }
    func fetchData(){
        NetworkManager.shared.getAthleteMedalDetailsWith(id: self.athlete?.athlete_id ?? "") { data, error in
            self.medals = data
            DispatchQueue.main.async {
                self.athletsDetailViewModel.reloadTableView(delegate: self, athlete:  self.athlete, medals: self.medals,identifier: .athletesDetails)
                self.tableView.reloadData()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension AthleteDetailVC: UITableViewDataSource, UITableViewDelegate{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{
//            return self.medals.count
//        }
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0{
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "MedalTableViewCell") as? MedalTableViewCell, let medel = self.medals[indexPath.row] as? ModelMedalDetails{
//                cell.setup(medel: medel)
//                return cell
//            }
//        }else {
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "BioTableViewCell") as? BioTableViewCell{
//
//                cell.setup(athlete: self.athlete)
//                return cell
//            }
//        }
//
//        return UITableViewCell()
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0{
//            return 50
//        }
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if self.medals.count > 0, section == 0{
//            return "Medals"
//        }
//        if (self.athlete?.bio ?? "").count > 0 , section == 1{
//            return "Bio"
//        }
//        return ""
//    }
//}
