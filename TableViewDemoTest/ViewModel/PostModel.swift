//
//  PostModel.swift
//  TableViewDemoTest
//
//  Created by Ashwini Apurkar on 29/05/24.
//

import Foundation

class PostModel {
    static let shared = PostModel()
    private let baseURL = "https://jsonplaceholder.typicode.com/posts"
    private init() {}
    
    func fetchPosts(page: Int, limit: Int, completion: @escaping (Result<[Post], Error>) -> Void) {
        let urlString = "\(baseURL)?_page=\(page)&_limit=\(limit)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
