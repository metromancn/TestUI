import UIKit

class MMConst {
    //String
    static let STR_EMPTY = ""
    static let STR_R = "\r"
    static let STR_N = "\n"
    static let STR_N_2 = "\n\n"
    static let STR_T = "\t"
    static let STR_RN = "\r\n"
    static let STR_COMMA = ","
    static let STR_HYPHEN = "-"
    static let STR_HYPHEN_2 = "--"
    static let STR_SHARP = "#"
    static let STR_COLON = ":"
    static let STR_SLASH = "/"
    static let STR_SLASH_BACK = "\\"
    static let STR_QUOTATION_SINGLE = "'"
    static let STR_QUOTATION_DOUBLE = "\""
    static let STR_TO = "→"
    static let STR_SPACE = " "
    static let STR_SPACE_2 = "  "
    static let STR_LEFT = "<"
    static let STR_RIGHT = ">"
    
    //Screen
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX = max(SCREEN_WIDTH, SCREEN_HEIGHT)
    static let SCREEN_MIN = min(SCREEN_WIDTH, SCREEN_HEIGHT)
    static let NATIVE_WIDTH = UIScreen.main.nativeBounds.size.width
    static let NATIVE_HEIGHT = UIScreen.main.nativeBounds.size.height
    static let NATIVE_MAX = max(NATIVE_WIDTH, NATIVE_HEIGHT)
    static let NATIVE_MIN = min(NATIVE_WIDTH, NATIVE_HEIGHT)
    
    //Device
    static let DEVICE_IS_PHONE = UIDevice.current.userInterfaceIdiom == .phone
    static let DEVICE_IS_PHONE_4 = DEVICE_IS_PHONE && SCREEN_MAX == 480.0
    static let DEVICE_IS_PHONE_5 = DEVICE_IS_PHONE && SCREEN_MAX == 568.0
    static let DEVICE_IS_PHONE_678 = DEVICE_IS_PHONE && SCREEN_MAX == 667.0
    static let DEVICE_IS_PHONE_678P = DEVICE_IS_PHONE && SCREEN_MAX == 736.0
    static let DEVICE_IS_PHONE_XS = DEVICE_IS_PHONE && SCREEN_MAX == 812.0
    static let DEVICE_IS_PHONE_XM = DEVICE_IS_PHONE && SCREEN_MAX == 896.0 && NATIVE_MAX == 2688
    static let DEVICE_IS_PHONE_XR = DEVICE_IS_PHONE && SCREEN_MAX == 896.0 && NATIVE_MAX == 1792
    static let DEVICE_IS_PHONE_X_SERIAL = DEVICE_IS_PHONE && SCREEN_MAX >= 812.0
    static let DEVICE_IS_PAD_X_SERIAL = DEVICE_IS_PAD && SCREEN_MAX >= 1194.0

    static let DEVICE_IS_PAD = UIDevice.current.userInterfaceIdiom == .pad
    
    //Device Size
    static let PX_PHONE_4 = CGSize(width: 640, height: 960)
    static let PX_PHONE_SE = CGSize(width: 640, height: 1136)
    static let PX_PHONE_8 = CGSize(width: 750, height: 1334)
    static let PX_PHONE_8P = CGSize(width: 1242, height: 2208)
    static let PX_PHONE_XS = CGSize(width: 1125, height: 2436)
    static let PX_PHONE_XM = CGSize(width: 1242, height: 2688)
    static let PX_PHONE_XR = CGSize(width: 828, height: 1792)
    static let PX_PAD_MINI = CGSize(width: 1536, height: 2048)
    static let PX_PAD_097 = CGSize(width: 1536, height: 2048)
    static let PX_PAD_105 = CGSize(width: 1668, height: 2224)
    static let PX_PAD_129 = CGSize(width: 2048, height: 2732)
    
    //Version
    static let VER_SYS = (UIDevice.current.systemVersion as NSString).floatValue
    static let VER_IS_9 = (VER_SYS >= 9.0 && VER_SYS < 10.0)
    static let VER_IS_10 = (VER_SYS >= 10.0 && VER_SYS < 11.0)
    static let VER_IS_11 = (VER_SYS >= 11.0 && VER_SYS < 12.0)
    static let VER_IS_12 = (VER_SYS >= 12.0 && VER_SYS < 13.0)
    
    //Color
    static let COLOR_APPLE = rgb(0, 121, 255)
    static let COLOR_ALIPAY = rgb(0, 173, 239)
    static let COLOR_ALIPAY_2 = rgb(30, 130, 210)
    static let COLOR_FACEBOOK = rgb(59, 89, 153)
    static let COLOR_GOOGLE = rgb(66, 134, 245)
    static let COLOR_ZHIXING = rgb(84, 148, 230)
    static let COLOR_QUNAR = rgb(21, 188, 212)
    static let COLOR_TIEYOU = rgb(84, 148, 230)
    static let COLOR_RAILMAN = COLOR_ALIPAY_2
    static let COLOR_RAILMAN_BACK = rgb(242, 242, 242)
    static let COLOR_FF313131 = rgb(49, 49, 49)
    static let COLOR_FF666666 = rgb(102, 102, 102)
    static let COLOR_FFFD6E4F = rgb(253, 110, 79)
    static let COLOR_FFBDBDBD = rgb(189, 189, 189)
    static let COLOR_FFB0B0B0 = rgb(176, 176, 176)
    static let COLOR_RAIL_PDF_BACK = rgb(249, 248, 247)
    
    //MetroMan
    static let METROMAN_IOS_ID = "466351433"
    static let METROMAN_IOS_ITEM = "itms-apps://itunes.apple.com/app/id\(METROMAN_IOS_ID)"
    static let METROMAN_IOS_HTTP = "https://itunes.apple.com/cn/app/id\(METROMAN_IOS_ID)?mt=8"
    static let METROMAN_QQ = "436179069"
    static let METROMAN_QQ_URL = "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=\(METROMAN_QQ)&card_type=group&source=external"
    static let METROMAN_SERVER_ROOT = "https://metroman.oss-cn-hangzhou.aliyuncs.com/app/metromanios"
    static let METROMAN_VERSION_TXT = "version.txt"
    static let METROMAN_VER = "v201901"
    static let METROMAN_FAQ = "https://www.metroman.cn/md/faq.html"
    static let METROMAN_PRIVACY = "https://www.metroman.cn/md/privacy.html"
    static let METROMAN_TERMS = "https://www.metroman.cn/md/terms.html"
    static let METROMAN_SUBSCRIPTION = "https://www.metroman.cn/md/subscription.html"
    static let METROMAN_RANK = "https://www.metroman.cn/app/rank.png"
    static let METROMAN_DIFF = "https://www.metroman.cn/app/diff.png"
    
    //RailMan
    static let RAILMAN_IOS_ID = "1333834350"
    static let RAILMAN_IOS_ITEM = "itms-apps://itunes.apple.com/app/id\(RAILMAN_IOS_ID)"
    static let RAILMAN_IOS_HTTP = "https://itunes.apple.com/cn/app/id\(RAILMAN_IOS_ID)?mt=8"
    static let RAILMAN_QQ = "689828518"
    static let RAILMAN_QQ_URL = "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=\(RAILMAN_QQ)&card_type=group&source=external"
    static let RAILMAN_SERVER_ROOT = "https://metroman.oss-cn-hangzhou.aliyuncs.com/app/railmanios"
    static let RAILMAN_VERSION_TXT = "version.txt"
    static let RAILMAN_VER = "v201811"
    static let RAILMAN_AMAP_KEY = "162637b112e20fb316eaaac4f5841039"
    static let RAILMAN_JPUSH_KEY = "998c5961e4f801e4e2040f1d"

    //AdMob
    static let ADMOB_PUB = "ca-app-pub-1765285543134589"
    
    //Other
    static let WEXIN = "MetroManApp"
    static let TAOBAO_HTTP = "https://shop105340988.taobao.com"
    static let GMAIL = "metromancn@gmail.com"
}
