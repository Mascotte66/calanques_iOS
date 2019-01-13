//
//  CalanqueCell.swift
//  Les Calanques
//
//  Created by Jean-Marc on 12/01/2019.
//  Copyright © 2019 Suchier Jean-Marc. All rights reserved.
//

import UIKit

class CalanqueCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var calanqueIV: ImageRonde!
    @IBOutlet weak var nomLabel: UILabel!
    
    var calanque: Calanque!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(_ calanque: Calanque) {
        self.calanque = calanque
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor  = UIColor.lightGray
        
        //que l'on passe par la variable de classe (self) ou par le parametre de setupCell, c'est pareil...
        nomLabel.text = self.calanque.nom
        //nomLabel.text = calanque.nom
        calanqueIV.image = self.calanque.image
        //calanqueIV.image = calanque.image
    }
    
}
