import Foundation


open class CountriesAPI {
    
    open class func getCountries(parameters: [String : Any], completion: @escaping ((_ data: [Country]?, _ error: Error?) -> Void)) {
        
        let urlString = "\(API.BaseURL)\(WebService.allCountries.rawValue)"
        
        APIClient.performRequest(urlString: urlString, headerType: .None, parameters: nil, method: .get) { (status, data, error) in
            completion(data, error)
        }
    }
    
}
