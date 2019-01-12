//
//  CalanqueCellAlternativeTableViewCell.swift
//  Les Calanques
//
//  Created by Jean-Marc on 12/01/2019.
//  Copyright © 2019 Suchier Jean-Marc. All rights reserved.
//

import UIKit

class CalanqueCellAlternativeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var calanqueIV: UIImageView!
    
    var calanque: Calanque? {
        
        didSet {
            if calanque != nil {
                calanqueIV.image = calanque!.image
                nomLabel.text = calanque!.nom
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
