//
//  CategoriesViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/10/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Brand : Codable {
    let id, vendor_id : Int
    let name, image : String
    
    var isSelected : Bool? = false
}

struct BrandTraining : Codable {
    let id, brand_id : Int
    let name, image : String
}

class BrandsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var tableView : UITableView!
    
    // MARK: - Properties
    
    var vendor : Company?
    var collectionDataSource = GenericCollectionDataSource<BrandsCell, Brand>()
    var tableDataSource = GenericTableDataSource<BrandTrainingCell, BrandTraining>()
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = collectionDataSource
        tableView.dataSource = tableDataSource
        
        let brands = Resource<[Brand]>(get: URL(string: NetworkingConstants.vendorBrands(forVendorID: vendor?.id ?? 0) )! )
        
        URLSession.shared.load(brands) { (brandsList, status) in
            if let list = brandsList {
                self.collectionDataSource.data = list
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case Segue.Brands.toCategories:
            if let brand = sender {
                if brand is BrandTraining {
                    let vc = segue.destination as! CategoryTableViewController
                    vc.title = (brand as! BrandTraining).name
                    vc.brand = brand as? BrandTraining
                }
            }
            
        default: return
        }
    }

}

extension BrandsViewController : UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let brandID = collectionDataSource.data[indexPath.row].id
        let brandTraining = Resource<[BrandTraining]>(get: URL(string: NetworkingConstants.brandTraining(forBrandID: brandID))!)
        
        URLSession.shared.load(brandTraining) { (trainingList, status) in
            if let list = trainingList {
                self.tableDataSource.data = list
                self.tableView.reloadData()
            }
        }
    }
    
}

extension BrandsViewController : UICollectionViewDelegateFlowLayout  {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension BrandsViewController : UITableViewDelegate  {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = tableDataSource.data[indexPath.row]
        performSegue(withIdentifier: Segue.Brands.toCategories, sender: category)
    }
}
