 //
//  NetworkService.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import Foundation


protocol NetworkServiceProtocol {
    func request<Request: DataRequest>(id : String, requestType : RequestType, queryItemsArray: [URLQueryItem] , _ request: Request, completion: @escaping (Result<Request.Response, ErrorResponse>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let baseUrl: String = "https://api.spoonacular.com/recipes/"
//    private let apiKey: String = "68dacdce560d4598baf62743ea86a9a7"
        private let apiKey: String = "997ced0c82834e24a3a3290f8123f2b5"
    
    func request<Request: DataRequest>(id : String, requestType : RequestType, queryItemsArray: [URLQueryItem] ,_ request: Request, completion: @escaping (Result<Request.Response, ErrorResponse>) -> Void) {
        
        let finalUrl: String = self.baseUrl + id + requestType.rawValue
        
        guard var urlComponent = URLComponents(string: finalUrl) else {
            return completion(.failure(.apiError))
        }
        
        var queryItems: [URLQueryItem] = []
        
        queryItemsArray.forEach {
            let urlQueryItem = URLQueryItem(name: $0.name, value: $0.value)
            queryItems.append(urlQueryItem)
        }
        queryItems.append(URLQueryItem(name: "apiKey", value: apiKey))
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return completion(.failure(.apiError))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(.apiError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                try completion(.success(request.decode(data)))
            } catch {
                completion(.failure(.noData))
            }
        }.resume()
    }
}

