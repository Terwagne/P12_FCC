//
//  LocationViewController.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 04/08/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var locationMap: MKMapView!
    
    // MARK: Properties
    var movies: [Movies]?
    var mov: Movies?
    var annotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        witchLocation()
        // Do any additional setup after loading the view.
    }
    /// Methode to display location
    func witchLocation() {
        guard let mov = mov, let cinema = Cinema(rawValue: mov.place)  else {return}
        region = cinema.regionPlace
        annotation.coordinate = cinema.coordinate
        annotation.title = cinema.title
        annotation.subtitle = cinema.subtitle
        
        locationMap.addAnnotation(annotation)
        locationMap.setRegion(region, animated: true)
    }
}
