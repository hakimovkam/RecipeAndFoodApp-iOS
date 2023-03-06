//
//  NetworkService.swift
//  galleyRecipe
//
//  Created by Камиль Хакимов on 18.01.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, ErrorResponse>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {

    private let session: URLSession

    init() {
        let configuraation = URLSessionConfiguration.default
        configuraation.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession(configuration: configuraation)
    }

    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, ErrorResponse>) -> Void) {

        guard var urlComponent = URLComponents(string: request.url) else {
            return completion(.failure(.apiError))
        }

        var queryItems: [URLQueryItem] = []

        request.defaultQueryItems.forEach {
            let urlQueryItem = $0
            queryItems.append(urlQueryItem)
        }

        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url else {
            return completion(.failure(.apiError))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        session.dataTask(with: url) { data, response, error in

            if let _ = error { // swiftlint:disable:this unused_optional_binding
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
