//
//  NetworkManager.swift
//  swiftui.lecture
//
//  Created by Aston Developer on 8/11/21.
//

import SwiftUI

struct ApiResponse: Codable {
    var firstName: String
    var lastName: String
    var timeStamp: String
}

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    private init() {}
    
    let url = "https://demo.astontech.com/get-data"
    
    func getData(completed: @escaping (Result<ApiResponse, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            // check for 200
            // check data is valid
            guard let data = data else {
                print("bad data")
                return
            }
            // decode json
            do {
                let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print("error decoding json")
            }
        }
        
        task.resume()
    }
}
