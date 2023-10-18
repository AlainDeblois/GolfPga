//
//  ListCell.swift
//  ApprendreAPI
//
//  Created by Alain Deblois on 2023-10-14.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    
    var tourn: Tournament!
    
    func setup(_ newTourn: Tournament) {
        tourn = newTourn
        let dateStr = String(tourn.StartDate.prefix(10))
        self.nameLbl.text = tourn.Name
        self.countryLbl.text = tourn.Name
        self.dateLbl.text = dateStr
        
    }

}
