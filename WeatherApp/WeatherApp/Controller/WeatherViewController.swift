import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        static let title: String = "Forecast"
        static let noOfSections: Int = 1
        static let cellIdentifier: String = "forecast"
    }
    
    // MARK: - Properties
    
    let networkService = NetworkService.shared
    var forecastModel: ForeCast?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var forecastTableView: UITableView! {
        didSet {
            forecastTableView.dataSource = self
        }
    }

    // MARK: - IBAction

    // MARK: - View Load Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = Constants.title
        let forecastCell = UINib.init(nibName: "ForecastTableViewCell", bundle: Bundle.main)
        forecastTableView.register(forecastCell, forCellReuseIdentifier: Constants.cellIdentifier)
        loadData()
    }
    
    // MARK: - Methods
    
    func loadData() {
        networkService.fetchWeatherData(success: { [weak self] foreCastData in
            print(foreCastData)
            guard let strongSelf = self else { return }
            strongSelf.forecastModel = foreCastData
            strongSelf.forecastTableView.reloadData()
            }, failure: { error in
                print(error)
        })
    }
}

extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.noOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let forecastData = forecastModel else {
            return 0
        }
        return forecastData.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? ForecastTableViewCell,
            let forecastData = forecastModel else {
            fatalError("Problem creating forecast cell")
        }

        let cellDataModel = ForecastCellDataModel(with: forecastData.list[indexPath.row])
        cell.configure(with: cellDataModel)
        
        return cell
    }
}
