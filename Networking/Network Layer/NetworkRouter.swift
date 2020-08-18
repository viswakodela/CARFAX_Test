//
//  NetworkRouter.swift
//  Networking
//
//  Created by Viswa Kodela on 2020-08-18.
//  Copyright © 2020 Viswa Kodela. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

/// **NetworkRouter** is responsible to create the router by using the attributes specified in the requested *Endpoint*
protocol NetworkRouter: AnyObject {
    associatedtype Endpoint: EndPointType
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
