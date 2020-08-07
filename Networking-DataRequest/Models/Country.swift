import Foundation

public struct Country: Codable {
    var name: String?
    var topLevelDomain: [String]?
    var alpha2Code: String?
    var alpha3Code: String?
    var callingCodes: [String]?
    var capital: String?
    var altSpellings: [String]?
    var region: String?
    var subregion: String?
    var population: Int?
    var latlng: [Double]?
    var demonym: String?
    var area: Double?
    var gini: Double?
    var timezones: [String]?
    var borders: [String]?
    var nativeName: String?
    var numericCode: String?
    var currencies: [Currency]?
    var languages: [Language]?
    var translations: Translation?
    var flag: String?
    var regionalBlocs: [RegionalBloc]?
    var cioc:String?
    
    public init(name: String?, topLevelDomain: [String]?, alpha2Code: String?, alpha3Code: String?, callingCodes: [String]?, capital: String?, altSpellings: [String]?, region: String?, subregion: String?, population: Int?, latlng: [Double]?, demonym: String, area:Double?, gini: Double?, timezones: [String]?, borders: [String]?, nativeName: String?, numericCode: String?, currencies: [Currency]?, languages: [Language]?, translations: Translation?, flag: String?, regionalBlocs: [RegionalBloc]?, cioc: String?) {
        self.name = name
        self.topLevelDomain = topLevelDomain
        self.alpha2Code = alpha2Code
        self.alpha3Code = alpha3Code
        self.callingCodes = callingCodes
        self.capital = capital
        self.altSpellings = altSpellings
        self.region = region
        self.subregion = subregion
        self.population = population
        self.latlng = latlng
        self.demonym = demonym
        self.area = area
        self.gini = gini
        self.timezones = timezones
        self.borders = borders
        self.nativeName = nativeName
        self.numericCode = numericCode
        self.currencies = currencies
        self.languages = languages
        self.translations = translations
        self.flag = flag
        self.regionalBlocs = regionalBlocs
        self.cioc = cioc
    }
    
    public enum CodingKeys: String, CodingKey {
        case name = "name"
        case topLevelDomain = "topLevelDomain"
        case alpha2Code = "alpha2Code"
        case alpha3Code = "alpha3Code"
        case callingCodes = "callingCodes"
        case capital = "capital"
        case altSpellings = "altSpellings"
        case region = "region"
        case subregion = "subregion"
        case population = "population"
        case latlng = "latlng"
        case demonym = "demonym"
        case area = "area"
        case gini = "gini"
        case timezones = "timezones"
        case borders = "borders"
        case nativeName = "nativeName"
        case numericCode = "numericCode"
        case currencies = "currencies"
        case languages = "languages"
        case translations = "translations"
        case flag = "flag"
        case regionalBlocs = "regionalBlocs"
        case cioc = "cioc"
    }
    
}
