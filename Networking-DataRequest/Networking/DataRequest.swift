import Foundation
import Alamofire
import SwiftyJSON
import NotificationBannerSwift

enum Result<T> {
    case Success(T)
    case Invalid(String)
    case Failure(Error)
}

enum HeadersType {
    case Guest
    case Main
    case UserSession
}

struct MaltipartData {
    var data: Data
    var name: String // profile_pic
    var fileName: String // file.jpg
    var mimeType: String // image/jpg
}

private func getHeaders(_ type: HeadersType) -> HTTPHeaders {
    switch type {
    case .Guest:
        return [:]
    case .Main:
        return [
            "X-Api-Key": API.APIKey,
            "Accept": "application/json"
        ]
    case .UserSession:
        return [
            "x-api-key": API.APIKey,
            "x-access-token": "",
            "Accept": "application/json"
        ]
    }
}

struct URLDataRequest {
    
    private var urlString: String
    private var headerType: HeadersType
    private var parameters: [String : Any]?
    private var httpMethod: HTTPMethod
    private var arguments: String?
    private var multipartData: [MaltipartData]?
    
    // Normal form
    init(url: String, header: HeadersType, param: [String : Any]?, method: HTTPMethod = .get) {
        urlString = url
        headerType = header
        parameters = param
        httpMethod = method
    }
    
    // Normal form with arguments
    init(url: String, args: String, header: HeadersType, param: [String : Any]?, method: HTTPMethod = .get) {
        urlString = url
        arguments = args
        headerType = header
        parameters = param
        httpMethod = method
    }
    
    // Multipart form
    init(url: String, header: HeadersType, param: [String : Any]?, formData: [MaltipartData]) {
        urlString = url
        headerType = header
        parameters = param
        httpMethod = .post // Not using this, use only multipart
        multipartData = formData
    }
    
    func checkInternetConnection() {
        if let manager = NetworkReachabilityManager(), !manager.isReachable {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Your code here
                let banner = StatusBarNotificationBanner(title: "The Internet connection appears to be offline.", style: .danger)
                banner.haptic = .heavy
                banner.show()
            }
        }
    }
    
    // Normal Request
    public func requestData(completion: @escaping (Result<Data>) -> Void) {
        // Check internet connection availability
        checkInternetConnection()
        
        // Show Activity Indicator
        NetworkActivityIndicatorManager.networkOperationStarted()
        
        print("URL: ========> \(urlString)")
        print("HTTP METHOD: ====> \(httpMethod)")
        print("HEADERS: ====> \(getHeaders(headerType))")
        print("PARAMETERS: => \(parameters ?? [:])")
        
        // Continue with Alamofire request
        AF.request(urlString, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: getHeaders(headerType))
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate()
            .responseJSON { response in
                // Hide Activity Indicator
                NetworkActivityIndicatorManager.networkOperationFinished()
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        let statusCode = response.response?.statusCode ?? 0
                        switch statusCode {
                        case 200...299:
                            completion(.Success(data))
                        default:
                            let json = JSON(data)
                            let message = json["message"].stringValue
                            completion(.Invalid(message))
                        }
                    }
                case .failure(let error):
                    completion(.Failure(error))
                }
        }
    }
    
    // Multipart Upload
    public func uploadData(completion: @escaping (Result<Data>) -> Void) {
        // Check internet connection availability
        checkInternetConnection()

        // Show Activity Indicator
        NetworkActivityIndicatorManager.networkOperationStarted()
        
        // Continue with Alamofire upload
        AF.upload(multipartFormData: { multipartFormData in
            if let multipartData = self.multipartData {
                
                multipartData.forEach({ multipartDataItem in
                    multipartFormData.append(multipartDataItem.data, withName: multipartDataItem.name, fileName: multipartDataItem.fileName, mimeType: multipartDataItem.mimeType)
                })
            }

            if let param = self.parameters {
                for (key, value) in param {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }

        }, to: urlString, method: httpMethod, headers: getHeaders(headerType))
        .validate()
        .responseJSON { response in
            // Hide Activity Indicator
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            switch response.result {
            case .success:
                if let data = response.data {
                    completion(.Success(data))
                }
            case .failure(let error):
                completion(.Failure(error))
            }
        }
    }
}
