//
//  TableView Integree Controller.swift
//  Les Calanques
//
//  Created by Jean-Marc on 11/01/2019.
//  Copyright © 2019 Suchier Jean-Marc. All rights reserved.
//

import UIKit

class TableView_Integree_Controller: UITableViewController {
    
    var calanques: [Calanque] = []
    var cellID = "CalanqueCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calanques = CalanqueCollection().all()
        tableView.backgroundColor = UIColor.red
        let bg = UIImageView(frame: view.bounds)
        bg.image = calanques[0].image
        bg.contentMode = .scaleAspectFill
        tableView.backgroundView = bg
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return calanques.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? CalanqueCell {
            cell.setupCell(calanques[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            let calanque = calanques[indexPath.row]
            cell.textLabel?.text = calanque.nom
            cell.imageView?.image = calanque.image
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }

   

}
