//
//  Service.swift
//  LBTATwitterTutorial
//
//  Created by Kevin Quisquater on 15/10/2017.
//  Copyright © 2017 Kevin Quisquater. All rights reserved.
//

import TRON
import SwiftyJSON

struct APIService {
    static let shared = APIService()
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com/")
    
    func fetchHomeFeed(completion: @escaping (HomeDatasource?, Error?) -> ()) {
        let request: APIRequest<HomeDatasource, JSONError> = tron.request("twitter/home")
        request.perform(withSuccess: { homeDatasource in
            completion(homeDatasource, nil)
        }) { error in
            completion(nil, error)
            print("Error fetching JSON: ", error)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("JSON Error")
        }
    }
}
