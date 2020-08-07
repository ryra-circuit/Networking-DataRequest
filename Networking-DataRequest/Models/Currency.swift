import Foundation

public struct Currency: Codable {
    var code: String?
    var name: String?
    var symbol: String?
    
    public init(code: String?, name: String?, symbol: String?) {
        self.code = code
        self.name = name
        self.symbol = symbol
    }
    
    public enum CodingKeys: String, CodingKey {
        case code = "code"
        case name = "name"
        case symbol = "symbol"
    }
    
}
