//
//  NetworkDataFetcher.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 17.05.2023.
//

import Foundation

class NetworkDataFetcher {
    let networkService = PhotoApiService()
    
    func fetchImages(searchTerm: String, completion: @escaping (PhotoResponse?) -> Void ) {
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received requesting data \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: PhotoResponse.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable> (type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        }
        catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
