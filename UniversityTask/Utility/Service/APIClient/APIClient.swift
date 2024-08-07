//
//  APIClient.swift
//  UniversityTask
//
//  Created by Bheem Singh on 07/08/24.
//

import Foundation

enum APIEndpoint {
    static let universityList:URL = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
}

enum HttpError: Error {
    case nonSuccessStatusCode
}

final class APIClient {

    static let shared: APIClient = APIClient()
    
    private init(){}
    
    func getAPIData<T: Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping(Result<T, Error>)-> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "get"
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        
        callApi(requestUrl: urlRequest, resultType: resultType) { result in
            completionHandler(result)
        }
    }
    
    func callApi<T:Decodable>(requestUrl: URLRequest, resultType: T.Type, completionHandler: @escaping(Result<T, Error>)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                //parse the responseData here
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(.success(result))
                } catch let error {
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                    _=completionHandler(.failure(error))
                }
            }

        }.resume()
    }
    
}
