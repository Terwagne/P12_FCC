//
//  ApiTestscase.swift
//  FilmClubCannesTests
//
//  Created by ISABELLE Terwagne on 07/08/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import XCTest
@testable import FilmClubCannes

class ApiTestsCase: XCTestCase {
    
    func testUrlMovieSearch() {
        let id = 11703
        let apiKey = valueForAPIKey(named: "apiKey")
        let url = "https://api.themoviedb.org/3/movie/\(id)?language=FR&api_key=\(apiKey)"
        XCTAssertEqual("https://api.themoviedb.org/3/movie/\(id)?language=FR&api_key=\(apiKey)", url)
    }
    
    func testSearchMovieShouldPostFailedCallback () {
        // Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let apiSessionFake = ApiSessionFake(fakeResponse: fakeResponse)
        let apiService = ApiServices(apiSession: apiSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        apiService.searchMovieDetail(id: 11703) {(success, movies) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSearchMovieShouldPostFailedcallbackIfNoData () {// NoData
        // Given
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let apiSessionFake = ApiSessionFake(fakeResponse: fakeResponse)
        let apiService = ApiServices(apiSession: apiSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        apiService.searchMovieDetail(id:11703) {(success, movies) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSearchMovieShouldPostFailedcallbackIfIncorrectResponse() { // IfIncorrectResponse
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO,
                                        data: FakeResponseData.correctData, error: nil)// CallbackIfError
        let apiSessionFake = ApiSessionFake(fakeResponse: fakeResponse)
        let apiService = ApiServices(apiSession: apiSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        apiService.searchMovieDetail(id: 11703){(success, movies) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSearchMovieShouldPostSuccessCallbackIfResponseCorrectAndNildata() { //
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let apiSessionFake = ApiSessionFake(fakeResponse: fakeResponse)
        let apiService = ApiServices(apiSession: apiSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        apiService.searchMovieDetail(id: 11703) {(success, movies) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSearchMovieShouldPostCallbackIfInCorrectData() {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.incorrectData, error: nil)
        let apiSessionFake = ApiSessionFake(fakeResponse: fakeResponse)
        let apiService = ApiServices(apiSession: apiSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
       apiService.searchMovieDetail(id: 11703) { success, movies in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testSearchMovieShouldPostFailedcallbackIfNoErrorAndCorrectData () {
        // Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK,
                                        data: FakeResponseData.correctData, error: nil)
        let apiSessionFake = ApiSessionFake(fakeResponse: fakeResponse)
        let apiService = ApiServices(apiSession: apiSessionFake)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change ")
        apiService.searchMovieDetail(id: 11703) { (success, Movies) in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(Movies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
}

}
