//
//  BaseAPI.swift
//  VKApp
//
//  Created by Sergey Lyubeznov on 10/01/2017.
//  Copyright © 2017 Sergey Lyubeznov. All rights reserved.
//

import UIKit

enum HTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum StatusCode:Int {
    case notFound = 404, unauthorized = 401, some = 500
    
    var description:String {
        
        switch self {
        case .notFound:
            return "Not Found"
        case .unauthorized:
            return "Unauthorized"
        default:
            return ""
        }
    }
}

class BaseAPI: NSObject {
    
    var completion:((_ data:AnyObject?, _ erorr:Error?) -> Void)?
    
    var object:AnyObject?
    
    var addAccessToken = true
    
    internal var dataTask:URLSessionTask?

    public func startRequest(completion:@escaping (_ data: AnyObject?,_ error:Error?) -> Void) {
        
        guard let loginInfo = object as? [String:String] else {
            return
        }
        
        let method = self.method()
        let parameters = self.parameters()
        
        var baseUrl = getBaseUrl(at: loginInfo)
        
        if baseUrl.length > 0 {
            baseUrl = baseUrl + self.path()
        } else {
            return
        }
        
        self.completion = completion
        
        var config = URLSessionConfiguration.default
        
        if Constants.Permissions.NeedAuth {
            if let authConfig = authConfig(at: loginInfo) {
                config = authConfig
            }
        }
        
        guard let url = URL(string:baseUrl) else {return}
        
        var request = URLRequest.init(url: url)
        request.httpMethod = method.rawValue
        
        if Constants.Permissions.JsonBody {
            let jsonData = jsonDataBody(param: parameters)
            request.httpBody = jsonData
        }
        
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        
        var jsonObject:[String:Any]?
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                self.apiDidReturnError(error: error)
            } else if let httpResponse = response as? HTTPURLResponse {
                
                let statusCode = httpResponse.statusCode
                
                if statusCode == 200 {
                
                    jsonObject = self.getJsonObject(data: data!)
                    if jsonObject != nil {
                        self.apiDidReturnData(data: jsonObject as AnyObject)
                    }
                } else {
                    
                    if (data != nil) {
                        jsonObject = self.getJsonObject(data: data!)
                        if jsonObject != nil {
                            print(jsonObject!)
                        }
                    }
                    
                    let domain = StatusCode(rawValue: statusCode)?.description
                    let newError = NSError(domain: domain!, code: statusCode, userInfo: nil)
                    self.apiDidReturnError(error:newError)
                }
            }
        }
        self.dataTask = dataTask
        dataTask.resume()
    }
    
    private func jsonDataBody(param:[String:Any]) -> Data? {
        let jsonData = try? JSONSerialization.data(withJSONObject: param)
        return jsonData
    }
    
    private func getJsonObject(data:Data) -> [String:Any]? {
        var jsonObject:[String:Any] = [:]
        do {
            jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as![String:Any]
        } catch {
            return nil
        }
        
        return jsonObject
    }
    
    func apiDidReturnData(data:AnyObject) {
        
        DispatchQueue.main.async {
            if self.completion != nil {
                self.completion?(data,nil)
            }
        }
    }
    
    func apiDidReturnError(error:Error) {
        DispatchQueue.main.async {
            if self.completion != nil {
                self.completion?(nil,error)
            }
        }
    }
    
    func method() -> HTTPMethod {
        return .get
    }
    
    func parameters() -> [String:Any] {
        return [String:Any]()
    }
    
    func path() -> String {
        return ""
    }
    
    private func getBaseUrl(at loginInfo:[String:String]) -> String {
        
        guard let host = loginInfo["host"],
            let port = loginInfo["port"],
            let webProtocol = loginInfo["protocol"]   else {
            return ""
        }
        
        return String(format:"%@://%@:%@",webProtocol,host,port)
    }
    
    private func authConfig(at loginInfo:[String:String]) -> URLSessionConfiguration? {
        
        guard let user = loginInfo["user"],
        let password = loginInfo["password"]
        else {
            return nil
        }
        
        let config = URLSessionConfiguration.default
        let userPasswordString = user+":"+password
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData?.base64EncodedString(options:.endLineWithLineFeed)
        let authString = "Basic \(base64EncodedCredential!)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        
        return config
    }
    
    func convertToDictionary(data: Data) -> [String: Any]? {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        return nil
    }
    
}

extension BaseAPI:URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}

