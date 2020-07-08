import Foundation

enum AppError: Int, Error {
    case badRequest = 400
    case unauthorised = 401
    case forbidden = 403
    case requestTimeOut = 408
    case internalServerError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeOut = 504
    case plistError = 1001
    case missingUrl = 1002
    case dataformatError = 1003
    case missingHeaders = 1004
    case unknown
    
    init(error: Error) {
        let nsError = error as NSError
        self = AppError(rawValue: nsError.code) ?? .unknown
    }
    
    var localizedDescription: String {
        switch self {
            case .badRequest:
                return "Please check the request you made"
            case .forbidden:
                return "Please check the request"
            case .unauthorised:
                return "Please authenticate and try again"
            case .requestTimeOut:
                return "Request timedout. Please try after some time"
            case .internalServerError:
                return "Problem with server"
            case .badGateway:
                return "Please check with backend team"
            case .gatewayTimeOut:
                return "Gateway timed out. Please check with backend team"
            case .serviceUnavailable:
                return "Service unavailable. Please report"
            default:
                return "Problem with data"
        }
    }
}
