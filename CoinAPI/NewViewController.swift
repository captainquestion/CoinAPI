//
//  ViewController.swift
//  CoinAPI
//
//  Created by canberk yılmaz on 2023-03-29.
//

import UIKit

class NewViewController: UIViewController {
    
    @IBOutlet weak var bitconLabel: UILabel!
    
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var thePicker: UIPickerView!
    
    var coinManager = Manager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        thePicker.dataSource = self
        thePicker.delegate = self
    }
}

//MARK: - ManagerDelegate

extension NewViewController: ManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        
        DispatchQueue.main.async {
            self.bitconLabel.text = price
            self.currentLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UIPickerView DataSource & Delegate

extension NewViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return coinManager.currencyArray.count
      }
      
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return coinManager.currencyArray[row]
      }
      
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          let selectedCurrency = coinManager.currencyArray[row]
          coinManager.getCoinPrice(for: selectedCurrency)
      }
}

