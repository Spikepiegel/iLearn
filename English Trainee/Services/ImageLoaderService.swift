//
//  ImageLoaderService.swift
//  English Trainee
//
//  Created by Николай Лермонтов on 14.05.2023.
//

import Foundation

//curl -H "Authorization: x0xQJT1gqQF53fzjTf6iHzT2q4LZReXqPZKCUbogpWw0HiRNiiKMilok" \
//"https://api.pexels.com/v1/search?query=nature&per_page=1"
//class PhotoApiService {
//
//    func getPhoto(completion: @escaping ((Photo)  -> Void)){
//
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.pexels.com"
//        urlComponents.path = "/v1/search"
//        urlComponents.queryItems = [URLQueryItem(name: "query", value: "природа")]
//
//        let url = urlComponents.url!
//        let token = "x0xQJT1gqQF53fzjTf6iHzT2q4LZReXqPZKCUbogpWw0HiRNiiKMilok"
//
//
//
//        var request = URLRequest.init(url: url)
//        //        request.httpBody = query.data(using: .utf8)
//        //        request.httpBody = [q]
//
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = ["Authorization": token]
//
//        _ = URLSession.init(configuration: .default)
//        let decoder = JSONDecoder()
//
//        let task = URLSession.shared.dataTask(with: request) { data , response , error in
//
////                        let data2 = try? JSONSerialization.jsonObject(with: data!, options: [])
////                                    print(data2)
//            print(response)
//            guard let data = data else {return}
//
//            do {
//
//                let photosResponse: PhotoResponse = try decoder.decode(PhotoResponse.self, from: data)
//                print("Success")
//                completion(photosResponse.photos[0])
//                print(photosResponse)
//
//            } catch {
//                print(error)
//            }
//
//        }
//        task.resume()
//
//    }
//}

class PhotoApiService {
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        
        let parameters = self.prepareParameters(searchTerm: searchTerm)
        let url = self.url(params: parameters)
        var request = URLRequest(url:  url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "GET"
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID 3cdjuwEq_N4w04XCf0CP7FGQz623EW7E82PTudmYNrs"
        return headers
    }
    
    private func prepareParameters(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(1)
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/search/photos"
        urlComponents.queryItems = params.map {URLQueryItem(name: $0, value: $1)}
        return urlComponents.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) ->URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
