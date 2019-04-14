import Foundation

enum MMCurrency: Int {
    case none = 0
    case usd = 1
    case cny = 2
    case eur = 3
    case gbp = 4
    case rub = 5
    case krw = 6
    case inr = 7
    case jpy = 8
    case aud = 9
    case cad = 10
    case hkd = 11
    case sgd = 12
    
    static let ALL_VALUE = ["", "$", "¥", "€", "£", "₽", "₩", "₹", "¥", "$", "$", "$", "$"]
    
    func getValue() -> String {
        return MMCurrency.ALL_VALUE[self.rawValue]
    }
}
