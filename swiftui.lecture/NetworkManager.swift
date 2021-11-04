//
//  NetworkManager.swift
//  swiftui.lecture
//
//  Created by Aston Developer on 8/11/21.
//

import SwiftUI

struct ApiResponse: Codable {
    var account_number: Int
    var account_owner: String
    var username: String
    var password: String
    var balance: Double
}

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    private init() {}
    
    let baseUrl = "https://localhost/account/"
    var accountNumber: String = ""
    
    func getData(completed: @escaping (Result<ApiResponse, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: baseUrl + accountNumber)!) { data, response, error in
            // check for 200
            // check data is valid
            guard let data = data else {
                print("bad data")
                return
            }
            // decode json
            do {
                print(data)
                let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print("error decoding json")
            }
        }
        
        task.resume()
    }
}
