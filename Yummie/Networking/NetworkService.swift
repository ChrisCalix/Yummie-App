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

    func myFirstRequest<T: Decodable>(completion: @escaping(Result<T, Error>) -> ()) {
        request(route: .fetchAllCategories, method: .get, type: T.self,completion: completion)
    }

    func fetchAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void) {
        request(route: .fetchAllCategories, method: .get, type: AllDishes.self, completion: completion)
    }

    func placeOrder(dishId: String, name: String, completion: @escaping (Result<Order, Error>)->()) {
        let params = [
            "name": name
        ]
        request(route: .placeOrder(dishId), method: .post, parameters: params, type: Order.self, completion: completion)
    }

    func fetchCategoryDishes(categoryId: String, completion: @escaping(Result<[Dish], Error>) -> Void) {
        request(route: .fetchCategoryDishes(categoryId), method: .get, type: [Dish].self, completion: completion)
    }

    func fetchOrders(completion: @escaping(Result<[Order], Error>)->Void ) {
        request(route: .fetchOrders, method: .get, type: [Order].self, completion: completion)
    }
    
    private func request<T: Decodable>(route: Route,
                                     method: Method,
                                     parameters: [String: Any]? = nil,
                                     type: T.Type,
                                     completion: @escaping (Result<T, Error>) -> Void) {
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
//                print("The error is: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)

            }
        }.resume()
    }

    private func handleResponse<T:Decodable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result else {
            completion(.failure(AppError.unknownError))
            return
        }

        switch result {
        case let .success(data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.decodingError))
                return
            }
            if let error = response.error {
                completion(.failure(AppError.serverError(error)))
            }
            if let decodedData = response.data {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.decodingError))
            }

        case let .failure(error):
            completion(.failure(error))
        }
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
