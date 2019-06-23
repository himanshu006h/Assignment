
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
}

struct NetworkDataLoaderConstant {
    static let baseUrlString = "http://gojek-contacts-app.herokuapp.com/contacts.json"
}

class NetworkDataLoader {
    var dataTask: URLSessionDataTask?
    let decoder = JSONDecoder()
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    func loadResult(urlString: String = NetworkDataLoaderConstant.baseUrlString, serviceType: ServiceType = ServiceType.contacts
        , completion: @escaping QueryCompletionHandler) {
        
        let request = urlString.urlRequest()
        
        dataTask = session.dataTask(with: request) { data, response, error in
            defer { self.dataTask = nil }
            if let error = error {
                completion(.failure(.requestFailed(error: error as NSError)))
                return
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
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

    private func parseData(_ data: Data, serviceType: ServiceType = ServiceType.contacts, completion: QueryCompletionHandler) {
        switch serviceType {
        case .contacts:
            do {
                let feedInfo = try decoder.decode([ContactInfo].self, from: data)
                completion(.success(feedInfo))
            } catch _ as NSError {
                completion(.failure(.jsonParsingFailure))
                return
            }
        case .contactsDetails:
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
