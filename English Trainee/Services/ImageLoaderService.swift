//
//  ImageLoaderService.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 14.05.2023.
//

import Foundation

//curl -H "Authorization: x0xQJT1gqQF53fzjTf6iHzT2q4LZReXqPZKCUbogpWw0HiRNiiKMilok" \
//"https://api.pexels.com/v1/search?query=nature&per_page=1"
class PhotoApiService {
    
    func getPhoto(completion: @escaping ((Photo)  -> Void)){
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.pexels.com"
        urlComponents.path = "/v1/search"
        urlComponents.queryItems = [URLQueryItem(name: "query", value: "nature")]
        
        let url = urlComponents.url!
        let token = "x0xQJT1gqQF53fzjTf6iHzT2q4LZReXqPZKCUbogpWw0HiRNiiKMilok"
       
        
        
        var request = URLRequest.init(url: url)
        //        request.httpBody = query.data(using: .utf8)
        //        request.httpBody = [q]
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization": token]
        
        _ = URLSession.init(configuration: .default)
        let decoder = JSONDecoder()
        
        let task = URLSession.shared.dataTask(with: request) { data , response , error in

            print(response)
            guard let data = data else {return}
            
            do {
                
                let photosResponse: PhotoResponse = try decoder.decode(PhotoResponse.self, from: data)
                print("Success")
                completion(photosResponse.photos[0])
                print(photosResponse)
                
            } catch {
                print(error)
            }
            
        }
        task.resume()

    }
}
