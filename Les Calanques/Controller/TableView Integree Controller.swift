//
//  TableView Integree Controller.swift
//  Les Calanques
//
//  Created by Jean-Marc on 11/01/2019.
//  Copyright © 2019 Suchier Jean-Marc. All rights reserved.
//

import UIKit

let segueID = "Detail"

class TableView_Integree_Controller: UITableViewController {
    
  
    //bien adapté quand la view ne comporte qu'une tableView
    //la variable tableView est definie dans le UITableViewController
    
    var calanques: [Calanque] = []
    var cellID = "CalanqueCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calanques = CalanqueCollection().all()
        tableView.backgroundColor = UIColor.red  //inutile?
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
            //dans quel cas passe-t-on la? Jamais?
            
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueID, sender: calanques[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID {
            if let vc = segue.destination as? DetailController {
                vc.calanqueRecue = sender as? Calanque
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //deux editingStyle possibles: .delete ou .insert
        
        if editingStyle == .delete {
            
            //cet appel permet d'activer le glissement de la ligne pour effacer
             calanques.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
           
        } else if editingStyle == .insert {
            print("Ajouter ici un element")
        }
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        calanques = CalanqueCollection().all()
        tableView.reloadData()
    }
    
    
}
