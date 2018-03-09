import Foundation

extension Date {
    static func from(dateString: String) -> Date? {
        let formatt = DateFormatter()
        formatt.dateFormat = "yyyy-MM-dd"
        return formatt.date(from: dateString)
    }
    
    var year: Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        return year
    }
}
