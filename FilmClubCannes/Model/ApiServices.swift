//
//  ApiServices.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 24/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation

class ApiServices {
    private let apiSession: ApiProtocol
    init(apiSession: ApiProtocol = ApiSession()) {
        self.apiSession = apiSession
    }
    // MARK: Properties
    let apiKey = valueForAPIKey(named: "apiKey")
    
    /// Creation of the URL for the request
    func createSearchMovieDetailURL(id: Int) -> URL? {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?language=FR&api_key=\(apiKey)"
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
    ///  Request API
    func searchMovieDetail(id: Int, completionHandler: @escaping (Bool, ApiMovieDetail?) -> Void) {
        print(id)
        guard let url = createSearchMovieDetailURL(id: id) else {return}
        print(url)
        apiSession.request(url: url) { responseData in
            guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let apiMovieDetail = try? JSONDecoder().decode(ApiMovieDetail.self,
                                                                 from: data) else {
                                                                    completionHandler(false, nil)
                                                                    return
            }
            completionHandler(true, apiMovieDetail)
        }
    }
}
