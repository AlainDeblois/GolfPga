//
//  ListController.swift
//  ApprendreAPI
//
//  Created by Alain Deblois on 2023-10-13.
//

import UIKit

class ListController: UIViewController, UITableViewDataSource,  UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var season: String = ""
    var pgaTour: [Tournament] = []
    let id = "ListCell"
    var leaders: [Players] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onDictReceived()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func onDictReceived() {
        APIHelper.shared.performRequest(season: season) { pgaTour in
            DispatchQueue.main.async {
                self.pgaTour = pgaTour
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pgaTour.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pga = pgaTour[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: id) as? ListCell {
            cell.setup(pga)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToLeaders", sender: pgaTour[indexPath.row].TournamentID)
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToLeaders" {
            if let nc = segue.destination as? LeadersController {
                nc.tournamentID = (sender as? Int)!
            }
        }
    }

}


