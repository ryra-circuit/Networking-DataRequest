import Foundation

public struct RegionalBloc: Codable {
    var acronym:String?
    var name: String?
    var otherAcronyms: [String]?
    var otherNames: [String]?
    
    public init(acronym: String?, name: String?, otherAcronyms: [String]?, otherNames: [String]?) {
        self.acronym = acronym
        self.name = name
        self.otherAcronyms = otherAcronyms
        self.otherNames = otherNames
    }
    
    public enum CodingKeys: String, CodingKey {
        case acronym = "acronym"
        case name = "name"
        case otherAcronyms = "otherAcronyms"
        case otherNames = "otherNames"
    }
    
}
