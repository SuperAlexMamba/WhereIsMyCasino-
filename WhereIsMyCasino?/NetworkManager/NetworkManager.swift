//
//  NetworkManager.swift
//  WhereIsMyCasino?
//
//  Created by Слава Орлов on 30.11.2023.
//
import Foundation
import Firebase

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getCasinoList(completion: @escaping ([Casino]?) -> Void) {
        let dataBase = Database.database().reference()
        
        dataBase.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
            
            guard let casinoData = snapshot.value as? NSArray else {
                print("Error: Unable to convert snapshot.value to [String: Any]")
                completion(nil)
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: casinoData)
                let decoder = JSONDecoder()
                let casino = try decoder.decode([Casino].self, from: jsonData)
                completion(casino)

                
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func loadImages(url: String , completion: @escaping (UIImage) -> Void) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                completion((UIImage(data: data) ?? UIImage(named: "CasinoImage"))!)

            }
            else {
                return
            }
                        
        }.resume()
        
    }
    

    
}
