import Foundation

public struct Translation: Codable {
    var de: String?
    var es: String?
    var fr: String?
    var ja: String?
    var it: String?
    var br: String?
    var pt: String?
    var nl: String?
    var hr: String?
    var fa: String?
    
    public init(de: String?, es: String?, fr: String?, ja: String?, it: String?, br: String?, pt: String?, nl: String?, hr: String?, fa: String?) {
        self.de = de
        self.es = es
        self.fr = fr
        self.ja = ja
        self.it = it
        self.br = br
        self.pt = pt
        self.nl = nl
        self.hr = hr
        self.fa = fa
    }
    
    public enum CodingKeys: String, CodingKey {
        case de = "de"
        case es = "es"
        case fr = "fr"
        case ja = "ja"
        case it = "it"
        case br = "br"
        case pt = "pt"
        case nl = "nl"
        case hr = "hr"
        case fa = "fa"
    }
    
}
