//
//  StocksTableViewController.swift
//  StocksAPIWebChallenge
//
//  Created by Felix Yu on 2/23/21.
//

import UIKit
let apiKey = "01E3VALZ2Y1H9RJD"
class StocksTableViewController: UITableViewController {

    var stocksNameList = ["Apple", "IBM", "Tesla", "Google", "Amazon"]
    var stocksTickerList = ["AAPL", "IBM", "TSLA", "GOOG", "AMZN"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Stocks List"
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stocksTickerList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stocksTicker", for: indexPath)

        cell.textLabel?.text = stocksNameList[indexPath.row]
        cell.detailTextLabel?.text = stocksTickerList[indexPath.row]

        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let stocksDetailVC = segue.destination as? StocksDetailTableViewController
        {
            let index = tableView.indexPathForSelectedRow?.row //indexPath.row but without having to pass in tableview cell
            stocksDetailVC.stockTicker = stocksTickerList[index!]
        }
    }
    


}
