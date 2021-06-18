//
//  NetworkManager.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 12.06.2021.
//

import Foundation

enum API: String
{
    case randomURL = "https://www.themealdb.com/api/json/v1/1/random.php"
    case categoriesURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    case mealsByCategoryBaseURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    case detailByIdBaseURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
}

final class NetworkManager: INetworkManager
{
    private init() {}
    static let instance = NetworkManager()
    
    func fetchRequest<T: Decodable>(with url: String, modelType: T.Type, completion: @escaping (Result<(T), Error>) -> Void) {
            guard let url = URL(string: url) else { return completion(.failure(NetworkManagerError.invalidUrl)) }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    return completion(.failure(NetworkManagerError.requestError))
                }
                guard let data = data else { return completion(.failure(NetworkManagerError.requestError)) }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkManagerError.parsingError))
                }
            }.resume()
        }
}
