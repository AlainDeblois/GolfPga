//
//  LeadersController.swift
//  GolfPGA
//
//  Created by Alain Deblois on 2023-10-16.
//

import UIKit

class LeadersController: UITableViewController {

    var leaders: [Players] = []
    var tournamentID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        getDataFromAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = UITableViewCell()
        var config = cell.defaultContentConfiguration()
        let item = leaders[indexPath.row]
        config.text = String(item.Rank! + 1) +  String(repeating: " ", count: 12) + item.Name!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        let result = formatter.string(from: NSNumber(value: item.Earnings!))
        config.secondaryText = "Bourse:" + result! + "   Score:" + String(Int(item.TotalScore!))
        config.textProperties.font = .boldSystemFont(ofSize: 16)
        config.secondaryTextProperties.font = .boldSystemFont(ofSize: 12)
        //config.textProperties.alignment = .center
        cell.contentConfiguration = config
        return cell
    }
 
    func getUrlPlayers()-> URL? {
        let apiEntryPoint = "https://api.sportsdata.io/golf/v2/json/Leaderboard/"
        let apiKey: String = "key=f2a14a802d664df18d7197d9afe3d84d"
        var urlStr = apiEntryPoint
        urlStr += String(tournamentID)
        urlStr += "?"
        urlStr += apiKey
        return URL(string: urlStr)
    }
    
    func getDataFromAPI() {
        URLSession.shared.dataTask(with: getUrlPlayers()!) { jsondata, _, error in
            if let d = jsondata {
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(LeaderBoard.self, from: d)
                    self.leaders = results.Players
                } catch {
                    print("erreur: \(error.localizedDescription) \(error)")
                }
            } else {
                return
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPlayerProfil", sender: leaders[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPlayerProfil" {
            if let nc = segue.destination as? PlayerProfilController {
                nc.locPlayers = (sender as? Players)
            }
        }
    }

    /*
    // MARK: - Navigation

    */

}
