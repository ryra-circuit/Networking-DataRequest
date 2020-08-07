import Foundation


public enum ErrorResponse : Error {
    case error(Int, Data?, Error)
}


public struct APIError {
    var code: Int
    var message: String
}
