//
//  ViewController.swift
//  TrackX
//
//  Created by Oliver Stenning on 25/03/2022.
//

import UIKit

class LaunchListViewController: UIViewController {
  
    // UI
    var nextLaunchView = NextLaunchView()
    var launchTableView = UITableView()
    
    let launchTableLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .label
        label.text = "Previous"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    struct Cells {
        static let launchCell = "LaunchCell"
    }
    
    // Data
    var launches: [Launch] = []
    var testLaunches: [Launch] = []
    
    var networkManager: NetworkManager!
    
    init(networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background")
        title = "Launches"
  
        networkManager.getLaunches() { launches, error in
            self.launches = launches ?? []
            print("Launches:")
            print(launches ?? "")

            DispatchQueue.main.async {
                self.launchTableView.reloadData()
            }
            
        }
        
        //networkRequest()
        configureNextLaunchView()
        configureTableView()
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.launchTableView.indexPathForSelectedRow{
            self.launchTableView.deselectRow(at: index, animated: true)
        }
    }
    
    func configureNextLaunchView() {
        view.addSubview(nextLaunchView)
        
        // Constraints
        nextLaunchView.translatesAutoresizingMaskIntoConstraints = false
        nextLaunchView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        nextLaunchView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        nextLaunchView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        nextLaunchView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func configureTableView() {
        view.addSubview(launchTableLabel)
        view.addSubview(launchTableView)
        setTableViewDelegates()
        launchTableView.estimatedRowHeight = 100
        launchTableView.rowHeight = UITableView.automaticDimension
        launchTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        launchTableView.register(LaunchListCell.self, forCellReuseIdentifier: Cells.launchCell)
        launchTableView.backgroundColor = UIColor(named: "BackgroundSecondary")
        


        // Constraints
        launchTableLabel.topAnchor.constraint(equalTo: nextLaunchView.bottomAnchor, constant: 12).isActive = true
        launchTableLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        launchTableLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        launchTableView.translatesAutoresizingMaskIntoConstraints = false
        launchTableView.topAnchor.constraint(equalTo: launchTableLabel.bottomAnchor, constant: 12).isActive = true
        launchTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -12).isActive = true
        launchTableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        launchTableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        launchTableView.layer.cornerRadius = 12
        launchTableView.layer.shadowColor = UIColor.black.cgColor
        launchTableView.layer.shadowOpacity = 0.5
        launchTableView.layer.shadowOffset = CGSize(width: 0, height: 5)
        launchTableView.layer.shadowRadius = 15
        
    }

    func setTableViewDelegates() {
        launchTableView.delegate = self
        launchTableView.dataSource = self
    }
    
    func networkRequest() {
        
        let urlString: String
        urlString = "https://api.spacexdata.com/v5/launches"
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self.parse(json: data)
                    return
                }
            }
        }
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonLaunches = try? decoder.decode([Launch].self, from: json) {
            launches = jsonLaunches.reversed()
            DispatchQueue.main.async {
                self.launchTableView.reloadData()
            }
        }
    }

}

extension LaunchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = launchTableView.dequeueReusableCell(withIdentifier: Cells.launchCell) as! LaunchListCell
        let launch = launches[indexPath.row]
        cell.set(launch: launch)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(named: "Background")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = LaunchDetailViewController()
        detailView.launch = launches[indexPath.row]
        navigationController?.pushViewController(detailView, animated: true)
    }
    
}
