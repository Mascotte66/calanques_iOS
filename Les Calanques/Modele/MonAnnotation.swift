
//
//  MonAnnotation.swift
//  Les Calanques
//
//  Created by Jean-Marc on 15/01/2019.
//  Copyright © 2019 Suchier Jean-Marc. All rights reserved.
//

import UIKit
import MapKit

class MonAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var calanque: Calanque
    var title: String?
    
    init(_ calanque: Calanque) {
        self.calanque = calanque
        coordinate = self.calanque.coordonnees
        title = self.calanque.nom
    }
    //un commentaire
}
