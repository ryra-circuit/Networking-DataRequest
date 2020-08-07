import Alamofire


open class APIClient {
    
    open class func performRequest<T: Decodable>(urlString: String, headerType: HeaderType, parameters: [String: Any]?, method: HTTPMethod, completion: @escaping (_ status: Bool, _ data: T?, _ error: Error?) -> Void) {
        
        URLDataRequest(url: urlString, header: headerType, param: parameters, method: method).requestData { (result) in
            
            switch result {
            case .Success(let data):
                // Decoding
                let responseData: T = try! JSONDecoder().decode(T.self, from: data)
                completion(true, responseData, nil)
                
            case .Failure(let error):
                completion(false, nil, error)
            }
        }
    }
    
    
    open class func performUpload<T: Decodable>(urlString: String, headerType: HeaderType, parameters: [String: Any]?, formData: [MaltipartData], completion: @escaping (_ status: Bool, _ data: T?, _ error: Error?) -> Void) {
        
        URLDataRequest(url: urlString, header: headerType, param: parameters, formData: formData).uploadData { (result) in
            
            switch result {
            case .Success(let data):
                // Decoding
                let responseData: T = try! JSONDecoder().decode(T.self, from: data)
                completion(true, responseData, nil)
                
            case .Failure(let error):
                completion(false, nil, error)
            }
        }
    }
    
}
