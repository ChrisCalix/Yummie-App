//
//  NetworkService.swift
//  Yummie
//
//  Created by Christian Calixto on 15/4/23.
//

import Foundation

struct NetworkService {

    static let shared = NetworkService()

    private init() {}

    func myFirstRequest() {
        request(route: .temp, method: .get, type: String.self) { _ in

        }
    }

    private func request<T: Codable>(route: Route,
                                     method: Method,
                                     parameters: [String: Any]? = nil,
                                     type: T.Type,
                                     completion: (Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            var result: Result<Data, Error>?
            if let data {
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                print("The response is \(responseString)")
            } else if let error {
                result = .failure(error)
                print("The error is: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                // TODO: decode our result and send back to the user

            }
        }.resume()
    }

    //cmd+option+slash
    /// This Function help us to generate a urlRequest
    /// - Parameters:
    ///   - route: path to the resources in the backend
    ///   - method: type of request to be made
    ///   - parameters: whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue

        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params)
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
