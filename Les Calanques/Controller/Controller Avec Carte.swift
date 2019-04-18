//
//  Controller Avec Carte.swift
//  Les Calanques
//
//  Created by Jean-Marc on 11/01/2019.
//  Copyright © 2019 Suchier Jean-Marc. All rights reserved.
//

import UIKit
import MapKit

class Controller_Avec_Carte: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var userPosition: CLLocation?
    var calanques : [Calanque] = CalanqueCollection().all()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        addAnnotations() // ajout des anotations pour toutes les calanques
        
        //pour le notification center
        NotificationCenter.default.addObserver(self, selector: #selector(notifDetail), name: Notification.Name("detail"), object: nil)
        if calanques.count > 5 {
            let premiere = calanques[5].coordonnees
            setupMap(coordonnees: premiere)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            if let maPosition = locations.last {
                userPosition = maPosition
            }
        }
    }
    
    func setupMap(coordonnees: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.35, longitudeDelta: 0.35)
        let region = MKCoordinateRegion(center: coordonnees, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @objc func notifDetail(notification: Notification) {
        if let calanque = notification.object as? Calanque {
            print("j'ai une calanque")
            toDetail(calanque: calanque)
        }
    }
    
    func toDetail(calanque: Calanque) {
        performSegue(withIdentifier: "Detail", sender: calanque)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let controller = segue.destination as? DetailController {
                controller.calanqueRecue = sender as? Calanque
            }
        }
    }
    
    func addAnnotations() {
        for calanque in calanques {
            
            //annotation basique
            /*
            let annotation = MKPointAnnotation()
            annotation.coordinate = calanque.coordonnees
            annotation.title = calanque.nom
            mapView.addAnnotation(annotation)
             */
            
            //annotation customisee
            let annotation = MonAnnotation(calanque)
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "reuseID"
        
        //verifier que ce ne soit pas la position de l'utilisateur
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        if let anno = annotation as? MonAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if annotationView == nil {
                
                //override
                //annotationView = MonAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
                
                annotationView = MonAnnotationView(controller: self, annotation: anno , reuseIdentifier: reuseIdentifier)
                
                //annotationView = MKAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
                //annotationView?.image = UIImage(named: "placeholder")
                //annotationView?.canShowCallout = true
                return annotationView
            } else {
                return annotationView
            }
        }
        return nil
        
        
    }
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = MKMapType.standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    
    @IBAction func getPosition(_ sender: Any) {
        //attention, il faut mettre a jour info.plist
        //ajouter ligne:  Privacy - Location Always and When In Use Usage Description
        //ajouter ligne:  Privacy - Location When In Use Usage Description
        if userPosition != nil {
            setupMap(coordonnees: userPosition!.coordinate)
        }
        //utiliser Simulator / Debug / Location pour simuler sa position
        
    }
   

}
