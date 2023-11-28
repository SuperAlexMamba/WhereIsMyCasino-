//
//  NetworkManager.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 30.11.2023.
//
import Foundation

class Casino: Codable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
}

class NetworkManager {
    
    
    static let shared = NetworkManager()
    
    private init() {
        print("Иниц NM")
    }
    
    func getCasinoList(completion: @escaping (Result<Casino , Error>) -> Void) {
        
        let urlString: String = "url.com" // do ponedelnika
        
        guard let url = URL(string: urlString) else {
            print("bad URL")
            return
        }
                
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error {
//                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            if data == nil {
                print("Data is nil!")
                return
            }
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                print("error when getting response")
                return
            }
            
            if !(200..<300).contains(HTTPResponse.statusCode) {
                print("Error status code - \(HTTPResponse.statusCode)")
            }
            
            
        }
        
        do {
            
        }
        
        catch {
            
        }
        
        
        let casino = Casino(name: "123")
        
        completion(.success(casino))
        
    }
    
    
    
}
