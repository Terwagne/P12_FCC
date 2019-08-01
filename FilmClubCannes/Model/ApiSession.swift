//
//  ApiSession.swift
//  FilmClubCannes
//
//  Created by ISABELLE Terwagne on 24/07/2019.
//  Copyright © 2019 ISABELLE Terwagne. All rights reserved.
//

import Foundation
import Alamofire

class ApiSession: ApiProtocol {
    
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            completionHandler(responseData)
        }
    }
}
