//
//  CinemaModelTestsCase.swift
//  FilmClubCannesTests
//
//  Created by ISABELLE Terwagne on 09/08/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import XCTest
import MapKit
@testable import FilmClubCannes

class CinemaModelTestsCase: XCTestCase {
var annotation = MKPointAnnotation()
var region = MKCoordinateRegion()
   
    func testCinemaLicorne_whenThisLocationIsChoose_thenReturnGoodLocation() {
        guard let cinema = Cinema(rawValue: "La Licorne") else {return}
        region = cinema.regionPlace
        annotation.coordinate = cinema.coordinate
        annotation.title = cinema.title
        annotation.subtitle = cinema.subtitle
        XCTAssertEqual(cinema.coordinate.latitude, 43.549420)
        XCTAssertEqual(cinema.coordinate.longitude, 6.981927)
        XCTAssertEqual(annotation.title, "Théâtre de la Licorne")
        XCTAssertEqual(annotation.subtitle, "25 Av Francis Tonner, 06150 Cannes La Bocca")
    }
    func testCinemaArcades_whenThisLocationIsChoose_thenReturnGoodLocation() {
        guard let cinema = Cinema(rawValue: "Les Arcades") else {return}
        region = cinema.regionPlace
        annotation.coordinate = cinema.coordinate
        annotation.title = cinema.title
        annotation.subtitle = cinema.subtitle
        XCTAssertEqual(cinema.coordinate.latitude, 43.552368)
        XCTAssertEqual(cinema.coordinate.longitude, 7.015368)
        XCTAssertEqual(annotation.title, "Cinéma Les Arcades")
        XCTAssertEqual(annotation.subtitle, "77 rue Félix Faure, 06400 Cannes")
    }
    
    func testCinemaRaimu_whenThisLocationIsChoose_thenReturnGoodLocation() {
        guard let cinema = Cinema(rawValue: "Raimu") else {return}
        region = cinema.regionPlace
        annotation.coordinate = cinema.coordinate
        annotation.title = cinema.title
        annotation.subtitle = cinema.subtitle
        XCTAssertEqual(cinema.coordinate.latitude, 43.567027)
        XCTAssertEqual(cinema.coordinate.longitude, 6.964819)
        XCTAssertEqual(annotation.title, "Le Raimu")
        XCTAssertEqual(annotation.subtitle, "MJC Ranguin, Avenue Borde, 06150 Cannes La Bocca")
    }
    
    func testCinemaPicaud_whenThisLocationIsChoose_thenReturnGoodLocation() {
        guard let cinema = Cinema(rawValue: "MJC Picaud") else {return}
        region = cinema.regionPlace
        annotation.coordinate = cinema.coordinate
        annotation.title = cinema.title
        annotation.subtitle = cinema.subtitle
        XCTAssertEqual(cinema.coordinate.latitude, 43.550481)
        XCTAssertEqual(cinema.coordinate.longitude, 7.001865)
        XCTAssertEqual(annotation.title, "Studio 13")
        XCTAssertEqual(annotation.subtitle, "23 Avenue du Dr Picaud, 06400 Cannes")
    }
    
    func testCinemaCinéToile_whenThisLocationIsChoose_thenReturnGoodLocation() {
        guard let cinema = Cinema(rawValue: "Le Cinétoile") else {return}
        region = cinema.regionPlace
        annotation.coordinate = cinema.coordinate
        annotation.title = cinema.title
        annotation.subtitle = cinema.subtitle
        XCTAssertEqual(cinema.coordinate.latitude, 43.569087)
        XCTAssertEqual(cinema.coordinate.longitude, 7.004763)
        XCTAssertEqual(annotation.title, "Cinétoile Rocheville")
        XCTAssertEqual(annotation.subtitle, "2 chemin du Perrier,06110 Le Cannet")
        
}
    func testCinemaCannetToile_whenThisLocationIsChoose_thenReturnGoodLocation() {
        guard let cinema = Cinema(rawValue: "Le Cannet Toiles") else {return}
        region = cinema.regionPlace
        annotation.coordinate = cinema.coordinate
        annotation.title = cinema.title
        annotation.subtitle = cinema.subtitle
        XCTAssertEqual(cinema.coordinate.latitude, 43.576003)
        XCTAssertEqual(cinema.coordinate.longitude, 7.017493)
        XCTAssertEqual(annotation.title, "Le Cannet Toiles")
        XCTAssertEqual(annotation.subtitle, "32 bis Bd Sadi Carnot, 06110 Le Cannet")
}
} 
