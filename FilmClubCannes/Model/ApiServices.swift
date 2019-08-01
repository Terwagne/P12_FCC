//
//  ApiServices.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 24/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Alamofire

class ApiServices {
    
    private let apiSession: ApiProtocol
    
    init(apiSession: ApiProtocol = ApiSession()) {
        self.apiSession = apiSession
    }
    
    // MARK: Properties
    let apiKey = valueForAPIKey(named: "apiKey")
  
  

    
    /// creation of the URL's for the requests
    func createSearchMoviesURL(title: String) -> URL? {

        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(title)&language=FR"
        let urlString2 = urlString.replacingOccurrences(of: " ", with: "+")
        guard let url = URL(string: urlString2) else { return nil }
        print(url)
        return url

    }
    /// creation of the URL's for movie détail Request
    func createSearchMovieDetailURL(id: String) -> URL? {

        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=FR"

        guard let url = URL(string: urlString) else { return nil }
        return url

  }
        
//Requests API
    func searchMovies(title: String, completionHandler: @escaping (Bool, ApiMovies?) -> Void) {
        print(title)
        guard let url = createSearchMoviesURL(title: title) else {return}
      
     apiSession.request(url: url) { responseData in
        
        guard responseData.response?.statusCode == 200 else {
                completionHandler(false, nil)
                return
            }
            guard let data = responseData.data else {
                completionHandler(false, nil)
                return
            }
            guard let apiMovies = try? JSONDecoder().decode(ApiMovies.self,
                                                                from: data) else {
                                                                    completionHandler(false, nil)
                                                                    return
            }
            completionHandler(true, apiMovies)
        }
    }
    
    func searchMovieDetail(id: String, completionHandler: @escaping (Bool, ApiMovieDetail?) -> Void) {
        print(id)
      guard let url = createSearchMovieDetailURL(id: id)else {return}

        print(url)
        apiSession.request(url: url) { responseData in
             DispatchQueue.main.async {
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
}
