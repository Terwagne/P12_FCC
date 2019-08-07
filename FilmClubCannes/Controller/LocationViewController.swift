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
    
    @IBOutlet weak var locationMap: MKMapView!
    var movies: [Movies]?
    var mov: Movies?
    var licorneMap = CLLocationCoordinate2DMake(43.549420, 6.981927)
    var picaudMap = CLLocationCoordinate2DMake(43.550481, 7.001865)
    var raimuMap = CLLocationCoordinate2DMake(43.567027, 6.964819)
    var arcadesMap = CLLocationCoordinate2DMake(43.552368, 7.015368)
    var cinetoileMap = CLLocationCoordinate2DMake(43.569087, 7.004763)
    var canettoilesMap = CLLocationCoordinate2DMake(43.576003, 7.017493)
    
    var annotation = MKPointAnnotation()
    var span = MKCoordinateSpan(latitudeDelta: 0.0002, longitudeDelta: 0.0002)
    var regionRadius = CLLocationCoordinate2DMake(1000, 1000)
    var region = MKCoordinateRegion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        witchLocation()
        // Do any additional setup after loading the view.
    }
    
    func witchLocation() {
        guard let mov = mov else {return}
    
        if mov.place == "La Licorne" {
            annotation.coordinate = licorneMap
            annotation.title = "Théâtre de la Licorne"
            annotation.subtitle = "25 Av Francis Tonner, 06150 Cannes La Bocca"
            region = MKCoordinateRegion(center: licorneMap, latitudinalMeters: 1000, longitudinalMeters: 1000)
        } else if mov.place == "Raimu" {
            annotation.coordinate = raimuMap
            annotation.title = "Le Raimu"
            annotation.subtitle = "MJC Ranguin, Avenue Borde, 06150 Cannes La Bocca"
            region = MKCoordinateRegion(center: raimuMap, latitudinalMeters: 1000, longitudinalMeters: 1000)
        } else if mov.place == "MJC Picaud" {
            annotation.coordinate = picaudMap
            annotation.title = "Studio 13"
            annotation.subtitle = "23 Avenue du Dr Picaud, 06400 Cannes"
            region = MKCoordinateRegion(center: picaudMap, latitudinalMeters: 1000, longitudinalMeters: 1000)
        } else if mov.place == "Les Arcades" {
            annotation.coordinate = arcadesMap
            annotation.title = "Les Arcades"
            annotation.subtitle = "77 rue Félix Faure, 06400 Cannes"
            region = MKCoordinateRegion(center: arcadesMap, latitudinalMeters: 1000, longitudinalMeters: 1000)
        } else if mov.place == "Le Cinétoile" {
            annotation.coordinate = cinetoileMap
            annotation.title = "Cinétoile Rocheville"
            annotation.subtitle = "2 chemin du Perrier,06110 Le Cannet"
            region = MKCoordinateRegion(center: cinetoileMap,
                                        latitudinalMeters: 1000, longitudinalMeters: 1000)
        } else if mov.place == "Le Cannet Toiles" {
            annotation.coordinate = canettoilesMap
            annotation.title = "Le Cannet Toiles"
            annotation.subtitle = "32 bis Bd Sadi Carnot, 06110 Le Cannet"
            region = MKCoordinateRegion(center: canettoilesMap,
                                        latitudinalMeters: 1000, longitudinalMeters: 1000)}
        locationMap.addAnnotation(annotation)
        locationMap.setRegion(region, animated: true)
    }
    
}
