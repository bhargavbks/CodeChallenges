import Foundation

public final class NetworkService {
    
    // MARK: - Properites
    
    internal let session = URLSession.shared
    
    // MARK: - Class Constructors
    
    public static var shared = NetworkService()
    
    // MARK: - Methods
    
    func fetchWeatherData(success _success: @escaping (ForeCast) -> Void,
                                 failure _failure: @escaping (AppError) -> Void) {

        let success: (ForeCast) -> Void = { response in
            DispatchQueue.main.async { _success(response) }
        }
        
        let failure: (AppError) -> Void = { error in
            DispatchQueue.main.async{ _failure(error) }
        }
        
        guard let plistUrl = Bundle.main.url(forResource: "ServiceData", withExtension: "plist") else {
             let error = NSError(domain: "plistError", code: 1001, userInfo: nil)
            failure(AppError(error: error))
            return
        }
        
        do {
            let data = try Data(contentsOf: plistUrl)
            let decoder = PropertyListDecoder()
            let value = try decoder.decode(ServiceModel.self, from: data)
            let queryParameters: HTTPParameters = [
                "appid": value.appId,
                "q": "London,UK",
                "units": "metric",
            ]
            let request = try NetworkRequest.configureRequest(for: .forecast, parameters: queryParameters)
            
            session.dataTask(with: request){(data, response, error) -> Void in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode.isSuccessHTTPCode,
                    let data = data else {
                        if let error = error {
                            failure(AppError(error: error))
                        } else {
                            let error = NSError(domain: "dataformatError", code: 1003, userInfo: nil)
                            failure(AppError(error: error))
                        }
                        return
                }
                do {
                    let responseData = try JSONDecoder().decode(ForeCast.self, from: data)
                    success(responseData)
                } catch let error {
                    failure(AppError(error: error))
                }
            }.resume()
        } catch let error {
            failure(AppError(error: error))
        }
    }
}
