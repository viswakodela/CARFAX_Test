//
//  CarfaxRouter.swift
//  Networking
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

class CarfaxRouter<Endpoint: EndPointType>: NSObject, NetworkRouter {
    
    private var task: URLSessionTask?
    
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(from: route)
            print("🙂 Downloading data from: \(request.url?.absoluteString ?? "n/a")")
            task = session.dataTask(with: request, completionHandler: { (data, resp, err) in
                if let error = err {
                    completion(nil, nil, error)
                    return
                }
                print("🤝 Downloaded data from: \(request.url?.absoluteString ?? "n/a")")
                completion(data, resp, err)
            })
        } catch {
            print("🧐Unknown Error from: \(route.path)")
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}

extension CarfaxRouter {

    /// Helps build the url for the given *Endpoint*
    /// - Parameter route: ...
    private func buildRequest(from route: Endpoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        request.httpMethod = route.httpMethod.rawValue

        do {
            switch route.task {
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)

            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    /// Adds the parameters to the *URLRequest* if they are non nil
    /// - Parameters:
    ///   - bodyParameters: bodyParameters defaulted with `nil`
    ///   - urlParameters: urlParameters defaulted with `nil`
    ///   - httpBody: httpBody defaulted with `nil`
    ///   - request: *URLRequest*
    private func configureParameters(bodyParameters: Parameters? = nil, urlParameters: Parameters? = nil, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }

            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        }
    }

    /// Adds headers to the *URLRequest*
    /// - Parameters:
    ///   - additionalHeaders: headers that will be added.
    ///   - request: *URLRequest*
    private func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
