//
//  APIManager.swift
//  Speedo Transfer App
//
//  Created by 1234 on 02/09/2024.
//

import Foundation

import Alamofire

struct APIManager {
    
    static func loadShowData(completion: @escaping(_ error: Error?, _ arrOfShows: [Show]?) -> ()) {
        AF.request("https://api.tvmaze.com/search/shows", method: .get, parameters: ["q": "ali"], headers: nil).response { response in
            
            guard let data = response.data else {
                
                completion(response.error, nil)
                return
            }
            do {
                
                let decoder = JSONDecoder()
                let arrOfShows = try decoder.decode([Show].self, from: data)
                 completion(nil, arrOfShows)
            } catch let error {
                
                print(error.localizedDescription)
            }
            
            
        }
    }
//    static func loadShowDataOfTable(completion: @escaping(_ error: Error?, _ arrOfShows: [Movie]?) -> ()) {
//        AF.request("https://api.tvmaze.com/search/shows", method: .get, parameters: ["movie": "ali"], headers: nil).response { response in
//
//            guard let data = response.data else {
//
//                completion(response.error, nil)
//                return
//            }
//            do {
//
//                let decoder = JSONDecoder()
//                let arrOfShows = try decoder.decode([Movie].self, from: data)
//                 completion(nil, arrOfShows)
//            } catch let error {
//
//                print(error.localizedDescription)
//            }
//
//
//        }
//    }
}
