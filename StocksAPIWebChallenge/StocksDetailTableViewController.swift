//
//  StocksDetailTableViewController.swift
//  StocksAPIWebChallenge
//
//  Created by Felix Yu on 2/23/21.
//

import UIKit

class StocksDetailTableViewController: UITableViewController {

    var stockTicker = ""

    var stockDayKeys = [String]()
    var stockDayDictionary: [String:TimeSeriesDaily] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(stockTicker)
        self.title = "Stock Times"
        let function  = "TIME_SERIES_DAILY"
        //query link for API
        let query = "https://www.alphavantage.co/query?function=\(function)&symbol=\(stockTicker)&outputsize=compact&apikey=\(apiKey)"
        let url = URL(string: query)
        //get the data, start session
        let session = URLSession.shared
       let dataTask = session.dataTask(with: url!) { (data, response, error) in
            //check for errors
            if error == nil && data != nil
            {
             //parse JSON. Must parse from top down
                let decoder = JSONDecoder()
                do{
                    let stock =  try decoder.decode(StockDetail.self, from: data!)
                    self.stockDayDictionary = stock.timeSeriesDaily
                    //get keys for the stock.timeSeriesDaily part (which is the date of the stock)
                    stock.timeSeriesDaily.keys.forEach({ (key) in
                        self.stockDayKeys.append(key)
                        //add to an array for displaying information into tableview
                     })
                    print(stock)
                    DispatchQueue.main.async {
                       self.tableView.reloadData()
                    }
                }
                catch{
                    print("Error in data processing")
                    print(error)
                    self.showError()
                }
            }
        else
            {
                self.showError()
            }
        }
        dataTask.resume() //need this for parsing
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func showError()
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the stock feed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stockDayKeys.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockDetailCell", for: indexPath)
        //get stock key which is the date of stock
        let stockKey = stockDayKeys[indexPath.row]
        
        //display it on table view
        cell.textLabel?.text = self.stockTicker
        cell.detailTextLabel?.text = stockKey
        
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let stocksDetailVC = segue.destination as? StocksDetailViewController
        {
            let index = tableView.indexPathForSelectedRow?.row //indexPath.row but without having to pass in tableview cell
            let stockDate = stockDayKeys[index!]
            //get key (date) of the selected row
            stocksDetailVC.stockTicker = stockTicker
            stocksDetailVC.stockDate = stockDate
            stocksDetailVC.stockClosePrice = stockDayDictionary[stockDate]?.close ?? "Error"
            stocksDetailVC.stockOpenPrice = stockDayDictionary[stockDate]?.open ?? "Error"
            stocksDetailVC.stockVolume = stockDayDictionary[stockDate]?.volume ?? "Error"
            stocksDetailVC.stockLowPrice = stockDayDictionary[stockDate]?.low ?? "Error"
            stocksDetailVC.stockHighPrice = stockDayDictionary[stockDate]?.high ?? "Error"

        }
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
