//
//  SnapshotExtension.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 24/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Firebase

//class FirebaseService {
//    static let shared = FirebaseService()
//    var database: Firestore?
//    init() {
////        FirebaseApp.configure()
//        database = Firestore.firestore()
//    }

class FirebaseService {
    let decoder = JSONDecoder()
    var movies = [Movies]()
    
    func getMovies(completion: @escaping ([Movies]) -> Void) {
        
        let movieReference = Firestore.firestore().collection("movies").order(by: "id")
        
        movieReference.addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else {return}
            do {
                
                for _ in snapshot.documents {
                    self.movies = try snapshot.decoded()
                }
                completion(self.movies)
                
            } catch {
                print("error")
            }
            
        }
    }
}

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
