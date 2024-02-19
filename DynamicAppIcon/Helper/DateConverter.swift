import Foundation

struct DateConverter {

    static func getDate(from dateString: String, format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: dateString)
    }

    enum DateFormat: String {
        case iconDateFormat = "dd/MM/yyyy"
    }
}


