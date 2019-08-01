//
//  FirebaseDecodable.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 24/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation

struct Movies : Decodable {
        let Id : Int
        let title: String
        let director: String
        let date: String
        let place: String
        let image: String
        let Tmbd: String
        let heure: String
    
}

