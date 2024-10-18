//
//  NetworkManager.swift
//  Cocktails
//
//  Created by Кирилл Бахаровский on 10/19/24.
//

import Foundation

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func fetchData(from name: String, apiKey: String, completion: @escaping ([Cocktail]?) -> Void) {
        
        let urlString = "https://api.api-ninjas.com/v1/cocktail?name=\(name)"
        
        guard let url = URL(string: urlString) else {
            print("Ошибка: Некорректный URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        
        // Создаём сессию для получения данных
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка сети: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Проверяем, что данные существуют
            guard let data = data else {
                print("Ошибка: Нет данных")
                completion(nil)
                return
            }
            // Декодируем данные
            do {
                let decodedData = try JSONDecoder().decode([Cocktail].self, from: data)
                completion(decodedData)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
