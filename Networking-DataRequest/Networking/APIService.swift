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
                return ""
            case .production:
                return ""
            }
        }
    }
}

public enum WebService: String {
    case register = "users"
    case login = "users/"
    case forgotPassword = "password"
    case changePassword = "password/"
    case viewMyProfile = "profile"
    case updateMyProfile = "profile/"
    case logout = ""
    case allCountries = "all"
}
