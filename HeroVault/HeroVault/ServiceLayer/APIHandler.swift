//
//  APIHandler.swift
//  HeroVault
//
//  Created by Gia Catano on 2024/04/01.
//

import Foundation
import CommonCrypto

enum NetworkingRequestType: String {
    case GET, POST, PATCH, PUT, DELETE
}

enum NetworkingError: Error {
    case internalError
    case invalidUrl
    case invalidData
    case parsingError
}

class APIHandler {
    
    func request<T: Codable>(path: String,
                             networkType: NetworkingRequestType,
                             model: T.Type,
                             completion: @escaping (Result<T, NetworkingError>) -> Void) {
        let endPoint = buildEndpoint(path: path)
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = networkType.rawValue
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(.failure(.internalError))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } catch {
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
    
     func buildEndpoint(path: String) -> String {
        let timeStamp = Date().timeIntervalSince1970
        let authorizationKey = "\(timeStamp)\(Constants.APIKeys.privateAPIKey)\(Constants.APIKeys.publicAPIKey)"
        let hashString = md5HashedString(securedString: authorizationKey)
        return "\(path)?&apikey=\(Constants.APIKeys.publicAPIKey)&ts=\(String(timeStamp))&hash=\(hashString)"
    }
    
     func md5HashedString(securedString: String) -> String {
        let data = Data(securedString.utf8)
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
