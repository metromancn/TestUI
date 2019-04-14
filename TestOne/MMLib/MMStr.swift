import Foundation

class MMStr {
    //Join
    static func join(_ list: [String], _ separator: String) -> String {
        return list.joined(separator: separator)
    }
    
    static func joinRow(_ list: [String]) -> String {
        return join(list, MMConst.STR_RN)
    }
    
    static func joinTab(_ list: [String]) -> String {
        return join(list, MMConst.STR_T)
    }
    
    static func joinComma(_ list: [String]) -> String {
        return join(list, MMConst.STR_COMMA)
    }
    
    //Split
    static func split(_ text: String, _ separator: String) -> [String] {
        return text == MMConst.STR_EMPTY ? [String]() : text.components(separatedBy: separator)
    }
    
    static func splitRow(_ text: String) -> [String] {
        return split(text, MMConst.STR_RN)
    }
    
    static func splitTab(_ text: String) -> [String] {
        return split(text, MMConst.STR_T)
    }
    
    static func splitComma(_ text: String) -> [String] {
        return split(text, MMConst.STR_COMMA)
    }
    
    //
    static func isEmpty(_ text: String?) -> Bool {
        return text == nil || text == MMConst.STR_EMPTY
    }
}
