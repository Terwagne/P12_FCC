//  FirestoreTestsCase.swift
//  FilmClubCannesTests
//
//  Created by ISABELLE Terwagne on 11/08/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.

import XCTest
import Firebase
@testable import FilmClubCannes

class FirebaseServiceTests: XCTestCase {
    
    func testGetMoviesSucces() {
        let movie = Movies(id: 10, title: "Metropolis", director: "Fritz Lang", date: "Mardi 5 septembre 2019", place: "La Licorne", image: "https:www. google.com", tmdb: 1510, heure: "19h30")
        let movies = [movie]
        let sut = FirebaseServiceSpy()
        
        let exp = expectation(description: "wait for load completion")
        
        sut.getMovies { result in
            switch result {
            case let .success(receivedMovies):
                XCTAssertEqual(receivedMovies, movies)
            case .failure(.offline):
                XCTFail("Should be success), got \(result) instead")
            }
            exp.fulfill()
        }
        sut.completeGetmoviesSuccessfullyWith(movies: movies)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func testGetMoviesFail() {
        let sut = FirebaseServiceSpy()
        let exp = expectation(description: "Wait for Load Completion")
        
        sut.getMovies { result in
            switch result {
            case .success:
                XCTFail("Should be fail, got \(result) instead")
            case let .failure(receivedError):
                XCTAssertEqual(receivedError, .offline)
            }
            exp.fulfill()
        }
        sut.completeGetMoviesWithOfflineError()
        
        wait(for: [exp], timeout: 1.0)
    }
}

class FirebaseServiceSpy: FirebaseProtocol {
    var message: ((Result) -> Void)?
    
    func getMovies(result: @escaping (Result) -> Void) {
        message = result
    }
    func completeGetmoviesSuccessfullyWith(movies: [Movies]) {
        message?(.success(movies))
    }
    func completeGetMoviesWithOfflineError() {
        message?(.failure(.offline))
    }
}
