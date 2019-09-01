//
//  FirebaseProtocol.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 17/08/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation

enum MoviesError: Error {
    case offline
}
enum Result {
    case success([Movies])
    case failure(MoviesError)
}
protocol FirebaseProtocol {
    func getMovies(result: @escaping (Result) -> Void)
}
