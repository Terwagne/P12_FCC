//
//  ApiSessionFake.swift
//  FilmClubCannesTests
//
//  Created by ISABELLE Terwagne on 07/08/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Alamofire
@testable import FilmClubCannes

class ApiSessionFake: ApiSession {
    private let fakeResponse: FakeResponse
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    override func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        let result = Request.serializeResponseJSON(options: .allowFragments,
                                                   response: httpResponse, data: data, error: error)
        let urlRequest = URLRequest(url: URL(string: "https://www.google.fr")!)
        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
}
}
