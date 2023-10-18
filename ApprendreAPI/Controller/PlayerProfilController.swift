//
//  PlayerProfilController.swift
//  GolfPGA
//
//  Created by Alain Deblois on 2023-10-17.
//

import UIKit

class PlayerProfilController: UIViewController {

    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var imageIV: UIImageView!
    
    var locRes: Player? = nil
    var locPlayers: Players! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlayerFromAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firstNameLbl.text = locRes?.FirstName
        lastNameLbl.text = locRes?.LastName
        countryLbl.text = locPlayers.Country!
        getPhoto()
    }
    
    func getPlayerFromAPI() {
        var url = "https://api.sportsdata.io/golf/v2/json/Player/"
        url += String(locPlayers.PlayerID!)
        url += "?key=f2a14a802d664df18d7197d9afe3d84d"
        let urlString = URL(string: url)
        URLSession.shared.dataTask(with: urlString!) { [self] jsondata, _, error in
            if let d = jsondata {
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(Player.self, from: d)
                    locRes = results
                } catch {
                    print("erreur: \(error.localizedDescription) \(error)")
                }
            } else {
                return
            }
        }.resume()
    }

    func getPhoto() {
        guard let url = URL(string: locRes!.PhotoUrl!) else { return }
        
        URLSession.shared.dataTask(with: url) {data, res, err in
            DispatchQueue.main.async {
                if let d = data {
                    let img = UIImage(data: d)
                    self.imageIV.image = img
                }
                if let e = err {
                    print("Erreur \(e.localizedDescription)")
                }
            }
        }.resume()
    }
    
    /*
    // MARK: - Navigation

    */
}
