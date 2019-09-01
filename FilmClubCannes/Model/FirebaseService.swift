//
//  SnapshotExtension.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 24/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService: FirebaseProtocol {
    let decoder = JSONDecoder()
    var movies = [Movies]()
    
    ///  Methode to get information from Firestore
    func getMovies(result: @escaping (Result) -> Void) {
        let movieReference = Firestore.firestore().collection("movies").order(by: "id")
        
        movieReference.addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else {return}
            do {
                self.movies = try snapshot.decoded()
                result(.success(self.movies))
            } catch {
                result(.failure(.offline))
            }
        }
    }
}
// extensions to decode Json from firestore
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
