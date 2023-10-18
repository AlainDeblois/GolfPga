//
//  ViewController.swift
//  ApprendreAPI
//
//  Created by Alain Deblois on 2023-10-13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currentSeasonTF: UITextField!
    
    var currentYear: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        currentYear = format.string(from: Date())
        currentSeasonTF.text = currentYear
    }
    
    @IBAction func btnGoPressed(_ sender: UIButton) {
        let season = currentSeasonTF.text ?? currentYear
        performSegue(withIdentifier: "ToList", sender: season)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToList" {
            if let listCont = segue.destination as? ListController {
                listCont.season = sender as! String
            }
        }
    }
}

