import Foundation
import UIKit

public enum ResponseStatus: String {
    case success
    case error
}

public enum AppEnvironment {
    case development
    case staging
    case production
}

public struct API {
    
    private static let appEnvironment: AppEnvironment = .development
    static let APIKey = ""
    
    static var BaseURL: String {
        get {
            switch appEnvironment {
            case .development:
                return "https://restcountries.eu/rest/v2/"
            case .staging:
                return "https://restcountries.eu/rest/v2/"
            case .production:
                return "https://restcountries.eu/rest/v2/"
            }
        }
    }
}

public enum WebService: String {
    case auth = "users"
    case login = "users/"
    case forgotPassword = "password"
    case changePassword = "password/"
    case viewMyProfile = "profile"
    case updateMyProfile = "profile/"
    case allCountries = "all"
}
