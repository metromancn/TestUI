import Foundation

class MMDate {
    //Const
    static let YMDHMS = "yyyyMMddHHmmss"
    static let YMDHM = "yyyyMMddHHmm"
    static let YMD = "yyyyMMdd"
    static let YMDHyphen = "yyyy-MM-dd"
    static let HMColon = "HH:mm"
    
    static let formatYMDHMS = getFormat(YMDHMS)
    static let formatYMDHM = getFormat(YMDHM)
    static let formatYMD = getFormat(YMD)
    static let formatYMDHyphen = getFormat(YMDHyphen)
    static let formatHMColon = getFormat(HMColon)
    
    //Basic
    static func getWeekday(_ date: Date) -> Int {
        //0:Sunday 1:Monday 2:Tuesday 3:Wednesday 4:Thursday 5:Friday 6:Saturday
        return Calendar.current.component(.weekday, from: date) - 1
    }
    
    static func getYear(_ date: Date) -> Int {
        return Calendar.current.component(.year, from: date)
    }
    
    static func getMonth(_ date: Date) -> Int {
        return Calendar.current.component(.month, from: date)
    }
    
    static func getDay(_ date: Date) -> Int {
        return Calendar.current.component(.day, from: date)
    }
    
    static func getHour(_ date: Date) -> Int {
        return Calendar.current.component(.hour, from: date)
    }
    
    static func getMinute(_ date: Date) -> Int {
        return Calendar.current.component(.minute, from: date)
    }
    
    static func getSecond(_ date: Date) -> Int {
        return Calendar.current.component(.second, from: date)
    }
    
    static func getMillisecond(_ date: Date) -> Int {
        return Calendar.current.component(.nanosecond, from: date) / 1000000
    }
    
    //Date To String
    static func toYMDHMS(_ date: Date) -> String {
        return formatYMDHMS.string(from: date)
    }
    
    static func toYMDHM(_ date: Date) -> String {
        return formatYMDHM.string(from: date)
    }
    
    static func toYMD(_ date: Date) -> String {
        return formatYMD.string(from: date)
    }
    
    static func toYMDHyphen(_ date: Date) -> String {
        return formatYMDHyphen.string(from: date)
    }
    
    static func toHMColon(_ date: Date) -> String {
        return formatHMColon.string(from: date)
    }
    
    static func toFormat(_ date: Date, _ formatStr: String) -> String {
        let format = getFormat(formatStr)
        return format.string(from: date)
    }
    
    //String to Date
    static func fromYMDHMS(_ str: String) -> Date {
        return formatYMDHMS.date(from: str)!
    }
    
    static func fromYMDHM(_ str: String) -> Date {
        return formatYMDHM.date(from: str)!
    }
    
    static func fromYMD(_ str: String) -> Date {
        return formatYMD.date(from: str)!
    }
    
    static func fromYMDHyphen(_ str: String) -> Date {
        return formatYMDHyphen.date(from: str)!
    }
    
    static func fromHMColon(_ str: String) -> Date {
        return formatHMColon.date(from: str)!
    }
    
    //Convert
    static func ymdToYMDHyphen(_ str: String) -> String {
        return toYMDHyphen(fromYMD(str))
    }
    
    static func ymdHyphenToYMD(_ str: String) -> String {
        return toYMD(fromYMDHyphen(str))
    }
    
    static func minuteToHM(_ time: Int) -> String {
        let hour = time / 60
        let minute = time % 60
        return String(format: "%02d:%02d", hour, minute)
    }
    
    static func hmToMinute(_ str: String) -> Int {
        let hour = Int(str.substring(0, 2))!
        let minute = Int(str.substring(3, 2))!
        return hour * 60 + minute
    }
    
    static func dateToMinute(_ date: Date) -> Int {
        let hour = getHour(date)
        let minute = getMinute(date)
        return hour * 60 + minute
    }
    
    //Calc
    static func addDay(_ date: Date, _ day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: date)!
    }
    
    static func minuteBetween(_ time1: Int, _ time2: Int) -> Int {
        return (time1 <= time2) ? (time2 - time1) : (time2 + 1440 - time1)
    }
    
    static func dayBetween(_ date1: Date, _ date2: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date1, to: date2).day!
    }
    
    static func minuteBetween(_ date1: Date, _ date2: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date1, to: date2).minute!
    }
    
    //Chinese
    static let CN_YEAR = "年"
    static let CN_MONTH = "月"
    static let CN_DAY = "日"
    static let CN_HOUR = "时"
    static let CN_HH = "小时"
    static let CN_MINUTE = "分"
    static let CN_MM = "分钟"
    static let CN_SECOND = "秒"
    static let CN_WEEK = "周"
    static let CN_WEEK_LIST = ["日", "一", "二", "三", "四", "五", "六"]
    
    static func getMDChinese(_ date: Date) -> String {
        let month = getMonth(date)
        let day = getDay(date)
        return String(format: "%d%@%d%@", month, CN_MONTH, day, CN_DAY)
    }
    
    static func getHMChinese(_ time: Int) -> String {
        let hour = time / 60
        let minute = time % 60
        let hourStr = (hour <= 0 ? "" : "\(hour)\(CN_HOUR)")
        let minuteStr = (minute <= 0 ? "" : "\(minute)\(CN_MINUTE)")
        return "\(hourStr)\(minuteStr)"
    }
    
    static func getHHMMChinese(_ time: Int) -> String {
        let hour = time / 60
        let minute = time % 60
        let hourStr = (hour <= 0 ? "" : "\(hour)\(CN_HH)")
        let minuteStr = (minute <= 0 ? "" : "\(minute)\(CN_MM)")
        return "\(hourStr)\(minuteStr)"
    }
    
    static func getWeekdayChinese(_ date: Date) -> String {
        //0:Sunday 1:Monday 2:Tuesday 3:Wednesday 4:Thursday 5:Friday 6:Saturday
        let weekday = getWeekday(date)
        return "\(CN_WEEK)\(CN_WEEK_LIST[weekday])"
    }
    
    //Private
    static func getFormat(_ format: String) -> DateFormatter {
        let result = DateFormatter()
        result.locale = Locale(identifier: "US")
        result.dateFormat = format
        return result
    }
}
