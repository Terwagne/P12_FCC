//
//  ApiProtocol.swift
//  
//
//  Created by ISABELLE Terwagne on 24/07/2019.
//

import Foundation
import Alamofire

protocol ApiProtocol {
    func request(url: URL, completionHandler: @escaping (DataResponse<Any>) -> Void)
}
