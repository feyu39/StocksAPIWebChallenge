//
//  StocksDetailViewController.swift
//  StocksAPIWebChallenge
//
//  Created by Felix Yu on 2/28/21.
//

import UIKit

class StocksDetailViewController: UIViewController {

    @IBOutlet weak var stockVolumeLabel: UILabel!
    @IBOutlet weak var stockLowPriceLabel: UILabel!
    @IBOutlet weak var stockHighPriceLabel: UILabel!
    @IBOutlet weak var stockClosePriceLabel: UILabel!
    @IBOutlet weak var stockOpenPriceLabel: UILabel!
    @IBOutlet weak var stockTitle: UILabel!
    var stockTicker = ""
    var stockOpenPrice = ""
    var stockClosePrice = ""
    var stockVolume = ""
    var stockDate = ""
    var stockHighPrice = ""
    var stockLowPrice = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stock Details"

        // Do any additional setup after loading the view.
        stockTitle.text = stockTicker + " " + stockDate
        stockOpenPriceLabel.text = "Open Price: $" + stockOpenPrice
        stockClosePriceLabel.text = "Close Price: $" + stockClosePrice
        stockHighPriceLabel.text = "High Price: $" + stockHighPrice
        stockLowPriceLabel.text = "Low Price: $" + stockLowPrice
        stockVolumeLabel.text = "Stock Volume: " + stockVolume
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
