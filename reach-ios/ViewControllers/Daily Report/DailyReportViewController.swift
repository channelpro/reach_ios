//
//  DailyReportViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class DailyReportViewController: UIViewController {

    // MARK: - Properties
    
    var dataSource = GenericTableDataSource<DailyReportCell, ReportSaleModel>()
    var passedSale : ReportSaleModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedSales = PersistenceManager.getAllSavedSales() {
            dataSource.data.removeAll()
            dataSource.data = savedSales
            tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapSubmit(_ sender: UIButton) {

        guard let salesList = PersistenceManager.getAllSavedSales() else { return }

        let postObj = ["sales" : salesList]
//
        let sales = Resource<ReportSaleModel>(url: URL(string: NetworkingConstants.sales)!, method: HttpMethod.post(postObj))

        URLSession.shared.load(sales) { (response, status) in

            if status.code == 200 {
                
                self.showBanner(message: .SuccessPostingSales)
                
                PersistenceManager.deleteAddSalesData()
                self.dataSource.data.removeAll()
                self.tableView.reloadData()
                
            } else if status.code == 403 {
                self.showBanner(message: .ErrorPosting)
            }
        }

    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}


extension DailyReportViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PersistenceManager.removeSalesObject(saleToRemove: dataSource.data[indexPath.row])
        
        dataSource.data.remove(at: indexPath.row)
        
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
}
