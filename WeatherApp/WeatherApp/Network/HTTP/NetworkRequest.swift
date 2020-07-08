import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?

public enum UrlPath: String {
    case forecast = "forecast"
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct NetworkRequest {

    static func configureRequest(for path: UrlPath,
                                 parameters: HTTPParameters? = nil,
                                 body: Data? = nil,
                                 method: HTTPMethod = .get) throws -> URLRequest {
        
        guard let plistUrl = Bundle.main.url(forResource: "ServiceData", withExtension: "plist") else {
            throw NSError(domain: "plistError", code: 1001, userInfo: nil)
        }
        //do {
            let data = try Data(contentsOf: plistUrl)
            let decoder = PropertyListDecoder()
            let value = try decoder.decode(ServiceModel.self, from: data)
            guard let url = URL(string: "\(value.baseUrl)\(path.rawValue)") else {
                throw NSError(domain: "MissingUrl", code: 1002, userInfo: nil)
            }
            var request = URLRequest(url: url)
            let basicHeaders = [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
            
            try configureParametersAndHeaders(parameters: parameters,
                                              headers: basicHeaders,
                                              request: &request)
            return request
//        } catch let error {
//            print(error)
//        }
    }
    
    static func configureParametersAndHeaders(parameters: HTTPParameters?,
                                              headers: HTTPHeaders?,
                                              request: inout URLRequest) throws {
        do {
            if let headers = headers, let parameters = parameters {
                try URLEncoder.encodeParameters(for: &request, with: parameters)
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
        } catch {
            throw NSError(domain: "Url encoding failed", code: 1002, userInfo: nil)
        }
    }
}
