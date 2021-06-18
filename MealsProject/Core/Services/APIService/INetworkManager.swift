//
//  INetworkManager.swift
//  MealsProject
//
//  Created by Sergey Starchenkov on 12.06.2021.
//

protocol INetworkManager
{
    func fetchRequest<T: Decodable>(with url: String, modelType: T.Type, completion: @escaping (Result<(T), Error>) -> Void)
}

enum NetworkManagerError: Error {
    case invalidUrl
    case parsingError
    case requestError
}
