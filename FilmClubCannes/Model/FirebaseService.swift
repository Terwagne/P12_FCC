//
//  SnapshotExtension.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 24/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

extension QueryDocumentSnapshot {
    func decoded<Type: Decodable>() throws -> Type {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let movie = try JSONDecoder().decode(Type.self, from: jsonData)
        return movie
    }
}
extension QuerySnapshot {
    func decoded<Type: Decodable>() throws ->[Type] {
        let movies: [Type] = try documents.map({ try $0.decoded() })
        print(movies)
        return movies
    }
}
