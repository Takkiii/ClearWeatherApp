//
//  ViewController.swift
//  ClearWeatherApp
//
//  Created by Kenichi Saito on 2/21/15.
//  Copyright (c) 2015 FarConnection. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView!
    var weatherImageView: UIImageView!
    var descriptionLabel: UILabel!
    var minLabel: UILabel!
    var maxLabel: UILabel!
    var nameLabel: UILabel!
    
    var weatherArray = [DailyWeather]()
    
    override func loadView() {
        super.loadView()
        
        // TableViewのsizeはデバイスの大きさに合わせる↓
        let kScreenSize = UIScreen.mainScreen().bounds.size
        
        // TableViewの配置は画面の下半分に設定
        tableView = UITableView(frame: CGRectMake(0, kScreenSize.height/2, kScreenSize.width, kScreenSize.height/2))
        tableView.backgroundColor = UIColor.orangeColor()
        tableView.rowHeight = 100
        tableView.dataSource = self
        self.tableView.separatorStyle = .None
        
        // self.view.addSubview()でviewに追加
        self.view.addSubview(tableView)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        OpenWeatherAPIClient.sharedClient.getWeather({data, error in
            
        })
        
        OpenWeatherAPIClient.sharedClient.getDailyWeather({data, error in
            self.weatherArray = data
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = WeatherTableViewCell(style: .Default, reuseIdentifier: "Cell")
        updateCell(cell, indexPath: indexPath)
        return cell
    }
    
    func updateCell(cell: WeatherTableViewCell, indexPath: NSIndexPath) {
        cell.dateLabel.text = weatherArray[indexPath.row].dt
        cell.minLabel.text = weatherArray[indexPath.row].min
        cell.maxLabel.text = weatherArray[indexPath.row].max
        cell.descriptionLabel.text = weatherArray[indexPath.row].aDescription
        cell.weatherImageView.image = UIImage(named:weatherArray[indexPath.row].main)?.imageWithRenderingMode(.AlwaysTemplate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

