
//
//  NetworkDataLoader.swift
//  Assignment
//
//  Created by Himanshu Saraswat on 22/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import Foundation

typealias QueryCompletionHandler = (_ result : FetchResult) -> Void
typealias FetchResult = Result<Any, APIErrors>

enum ServiceType: Int {
    case contacts = 0
    case contactsDetails = 1
    case editDetails = 2
    case addDetails = 3
}

struct NetworkDataLoaderConstant {
    static let baseUrlString = "http://gojek-contacts-app.herokuapp.com/contacts.json"
    static let putMethod = "PUT"
    static let postMethod = "POST"

}

class NetworkDataLoader {
    var dataTask: URLSessionDataTask?
    let decoder = JSONDecoder()
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func loadResult(urlString: String = NetworkDataLoaderConstant.baseUrlString, serviceType: ServiceType = ServiceType.contacts
        , bodyPram: [String: Any] = [String: Any](), completion: @escaping QueryCompletionHandler) {
        
        var request: URLRequest
        switch serviceType {
        case .contacts, .contactsDetails:
            request = urlString.urlRequest()
        case .editDetails:
            request = urlString.urlRequest(method: NetworkDataLoaderConstant.putMethod)
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyPram)
        case .addDetails:
            request = urlString.urlRequest(method: NetworkDataLoaderConstant.postMethod)
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyPram)
        }
        
        dataTask = session.dataTask(with: request) { data, response, error in
            defer { self.dataTask = nil }
            if let error = error {
                completion(.failure(.requestFailed(error: error as NSError)))
                return
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 || response.statusCode == 201 {
                self.parseData((String(data:data,
                                       encoding:.isoLatin1)!.data(using: .utf8)!), serviceType: serviceType, completion: { result in
                                        switch result {
                                        case let .success(feedInfo): completion(.success(feedInfo))
                                        case let .failure(error) : completion(.failure(error))
                                        }
                })
            }else{
                if (response as? HTTPURLResponse) != nil{
                    completion(.failure(.responseUnsuccessful))
                }
            }
        }
        dataTask?.resume()
    }
    
    //Parse Data as per service type
    private func parseData(_ data: Data, serviceType: ServiceType = ServiceType.contacts, completion: QueryCompletionHandler) {
        switch serviceType {
        case .contacts:
            do {
                let feedInfo = try decoder.decode([ContactInfo].self, from: data)
                let sortedArray = feedInfo.sorted(by: { $0.first_name! < $1.first_name! })
                completion(.success(sortedArray))
            } catch _ as NSError {
                completion(.failure(.jsonParsingFailure))
                return
            }
        case .contactsDetails, .editDetails, .addDetails:
            do {
                let feedInfo = try decoder.decode(Contactdetails.self, from: data)
                completion(.success(feedInfo))
            } catch _ as NSError {
                completion(.failure(.jsonParsingFailure))
                return
            }
        }
    }
}
