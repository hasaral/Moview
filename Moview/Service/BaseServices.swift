//
//  BaseServices.swift
//  Moview
//
//  Created by Hasan Saral on 5.11.2023.
//

import Foundation

class BaseAPI<T: TargetType> {
    
    func requestData<M: Codable>(target: T, responseModel:M.Type , completed: @escaping (Result<M, APError>) -> ()){
        
        guard let url = URL(string: "\(target.baseURL)\(target.search)\(target.path)") else {
            completed(.failure(.invalidURL))
            return
        }
 
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let responseObj = try JSONDecoder().decode(M.self, from: data)
                completed(.success(responseObj))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
