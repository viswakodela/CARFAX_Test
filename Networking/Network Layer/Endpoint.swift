//
//  Endpoint.swift
//  Networking
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

/// EndpointType is mainly responsible to create the *URLRequest* by abstracting all the required content that are responsible to create the **Route**
public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

public extension EndPointType {
    var headers: HTTPHeaders? {
        return HTTPHeaders()
    }

    var baseURL: URL {
        return URL(string: "https://carfax-for-consumers.firebaseio.com")!
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

/// **HTTPTask** will help to choose the required case according to the *urlParameters*, *bodyParameters* and *additionalHeaders* we specify to create the URL
public enum HTTPTask {
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)

    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
}
