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

final class NetworkManager: ObservableObject {
    
    // create a single static instance of this class
    static let shared = NetworkManager()
    
    private init() {}
    
    let url = "https://demo.astontech.com/get-data"
    
    func getData(completed: @escaping (Result<ApiResponse, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
            // check that we get a 200 response
            
            // check that data is valid
            guard let data = data else {
                print("invalid data")
                return
            }
            
            do {
                print("\(data)")
                let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print("error decoding json")
            }
        }
        task.resume()
    }
    
}
