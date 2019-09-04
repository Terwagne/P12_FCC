//
//  LocationModel.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 08/08/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

// MARK: Enum Cinema List
enum Cinema: String {
    case licorne = "La Licorne"
    case raimu = "Raimu"
    case picaud = "MJC Picaud"
    case arcades = "Les Arcades"
    case cinetoile = "Cinétoile"
    case canetoile = "Le Cannet Toiles"
    
    // MARK: Properties
    private var deltaMeters: Double {
        return 1000
    }
    var regionPlace: MKCoordinateRegion {
        return coordinateRegion(center: coordinate)
        
    }
    /// Methode to localize cinema and center localisation in the region with delta meters
    func coordinateRegion(center: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: center, latitudinalMeters: deltaMeters, longitudinalMeters: deltaMeters)
    }
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .licorne:
            return CLLocationCoordinate2D(latitude: 43.549420, longitude: 6.981927)
        case .raimu:
            return CLLocationCoordinate2D(latitude: 43.567027, longitude: 6.964819)
        case .picaud:
            return CLLocationCoordinate2D(latitude: 43.550481, longitude: 7.001865)
        case .arcades:
            return CLLocationCoordinate2D(latitude: 43.552368, longitude: 7.015368)
        case .cinetoile:
            return CLLocationCoordinate2D(latitude: 43.569087, longitude: 7.004763)
        case .canetoile:
            return CLLocationCoordinate2D(latitude: 43.576003, longitude: 7.017493)
        }
    }
    /// Calculate properties for anotation
    var title: String {
        switch self {
        case .licorne:
            return "Théâtre de la Licorne"
        case .picaud:
            return "Studio 13"
        case .raimu:
            return "Le Raimu"
        case .arcades:
            return "Cinéma Les Arcades"
        case .cinetoile:
            return "Cinétoile Rocheville"
        case . canetoile:
            return "Le Cannet Toiles"
        }
    }
    var subtitle: String {
        switch self {
        case .licorne:
            return "25 Av Francis Tonner, 06150 Cannes La Bocca"
        case .picaud:
            return "23 Avenue du Dr Picaud, 06400 Cannes"
        case .raimu:
            return "MJC Ranguin, Avenue Borde, 06150 Cannes La Bocca"
        case .arcades:
            return "77 rue Félix Faure, 06400 Cannes"
        case .cinetoile:
            return "2 chemin du Perrier,06110 Le Cannet"
        case . canetoile:
            return "32 bis Bd Sadi Carnot, 06110 Le Cannet"
        }
    }
}
