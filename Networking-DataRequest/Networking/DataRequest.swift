import Foundation
import Alamofire
import SwiftyJSON
import NotificationBannerSwift

enum Result<T> {
    case Success(T)
    case Failure(Error)
}


public enum HeaderType {
    case Guest
    case UserSession
    case Contents
    case None
}


enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}


enum ContentType: String {
    case json = "application/json"
    case formData = "application/x-www-form-urlencoded"
    case multipartFormData = "multipart/form-data"
}


public struct MaltipartData {
    var data: Data
    var name: String // profile_pic
    var fileName: String // file.jpg
    var mimeType: String // image/jpg
}


private func getHeaders(_ type: HeaderType) -> HTTPHeaders {
    
    switch type {
    case .Guest:
        return [
            HTTPHeaderField.authorization.rawValue: API.APIKey,
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue
        ]
    case .UserSession:
        return [
            HTTPHeaderField.authorization.rawValue: API.APIKey,
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue,
            "x-access-token": "" // Set accesstoken here
        ]
    case .Contents:
        return [
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue
        ]
    case .None:
        return [:]
    }
}


struct URLDataRequest {
    
    private var urlString: String
    private var headerType: HeaderType
    private var parameters: [String : Any]?
    private var httpMethod: HTTPMethod
    private var arguments: String?
    private var multipartData: [MaltipartData]?
    
    
    //MARK: Normal form - Ex: base_url/end_point -> (GET, POST, PUT, DELETE)
    init(url: String, header: HeaderType, param: [String : Any]?, method: HTTPMethod = .get) {
        urlString = url.addingPercentEncoding(withAllowedCharacters : CharacterSet.urlQueryAllowed) ?? ""
        headerType = header
        parameters = param
        httpMethod = method
    }
    
    
    //MARK: Multipart form - Ex: base_url/end_point -> (POST)
    init(url: String, header: HeaderType, param: [String : Any]?, formData: [MaltipartData]) {
        urlString = url.addingPercentEncoding(withAllowedCharacters : CharacterSet.urlQueryAllowed) ?? ""
        headerType = header
        parameters = param
        httpMethod = .post
        multipartData = formData
    }
    
    
    /*//MARK: Check internet connection
    func checkInternetConnection() {
        if let manager = NetworkReachabilityManager(), !manager.isReachable {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Your code here
                let banner = StatusBarNotificationBanner(title: "The Internet connection appears to be offline.", style: .danger)
                banner.haptic = .heavy
                banner.show()
            }
        }
    }*/
    
    
    //MARK: Normal Request
    public func requestData(completion: @escaping (Result<Data>) -> Void) {
        // Check internet connection availability
        //checkInternetConnection()
        
        // Show Activity Indicator
        NetworkActivityIndicatorManager.networkOperationStarted()
        
        // Log API request info
        self.logAPIRequestInfo(isUpload: false)
        
        // Continue with Alamofire request
        AF.request(urlString, method: httpMethod, parameters: httpMethod == .get ? nil : parameters, encoding: JSONEncoding.default, headers: getHeaders(headerType))
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
                        completion(.Success(data))
                    } else {
                        let _error = CustomError.dataError(message: "Failed to read data.")
                        completion(.Failure(_error))
                    }
                case .failure(let error):
                    completion(.Failure(error))
                }
        }
    }
    
    
    //MARK: Multipart Upload
    public func uploadData(completion: @escaping (Result<Data>) -> Void) {
        // Check internet connection availability
        //checkInternetConnection()

        // Show Activity Indicator
        NetworkActivityIndicatorManager.networkOperationStarted()
        
        // Log API request info
        //self.logAPIRequestInfo(isUpload: true)
        
        // Continue with Alamofire upload
        AF.upload(multipartFormData: { multipartFormData in
            
            if let multipartData = self.multipartData {
                
                multipartData.forEach({ multipartDataItem in
                    multipartFormData.append(multipartDataItem.data, withName: multipartDataItem.name, fileName: multipartDataItem.fileName, mimeType: multipartDataItem.mimeType)
                })
            }
            
            if let param = self.parameters {
                for (key, value) in param {
                    multipartFormData.append(("\(value)").data(using: String.Encoding.utf8)!, withName: key)
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
                    } else {
                        let _error = CustomError.dataError(message: "Failed to read data.")
                        completion(.Failure(_error))
                    }
                case .failure(let error):
                    completion(.Failure(error))
                }
        }
    }
    
    
    //MARK: Log API request info
    func logAPIRequestInfo(isUpload: Bool) {
        
        print("**** \(isUpload ? "UPLOAD" : "REQUEST") INFO ****")
        print("URL: ========> \(urlString)")
        print("HTTP METHOD: ====> \(httpMethod)")
        print("HEADERS: ====> \(getHeaders(headerType))")
        print("PARAMETERS: => \(parameters ?? [:])")
        print("ARGUMENTS: => \(arguments ?? "")")
        
        if isUpload {
            print("MULTIPART DATA COUNT: => \(multipartData?.count ?? 0)")
        }
    }
    
}


public enum CustomError: Error {
    case serverError(message: String)
    case sessionExpired(message: String)
    case dataError(message: String)
}


extension CustomError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .serverError(let message):
            return NSLocalizedString(message, comment: "")
            
        case .sessionExpired(message: let message):
            return NSLocalizedString(message, comment: "")
            
        case .dataError(message: let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
