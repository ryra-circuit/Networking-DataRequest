import Foundation

public struct Language: Codable {
    var iso639_1: String?
    var iso639_2: String?
    var name: String?
    var nativeName: String?
    
    public init(iso639_1: String?, iso639_2: String?, name: String?, nativeName: String?) {
        self.iso639_1 = iso639_1
        self.iso639_2 = iso639_2
        self.name = name
        self.nativeName = nativeName
    }
    
    public enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso639_1"
        case iso639_2 = "iso639_2"
        case name = "name"
        case nativeName = "nativeName"
    }
    
}
