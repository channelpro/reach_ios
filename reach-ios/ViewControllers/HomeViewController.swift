//
//  HomeViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Person {
    let firstName, lastName : String
}

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var pointsLabel : UILabel!
    @IBOutlet weak var profilePicture: ProfilePictureProgressView!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var sideMenuTableView : UITableView!
    
    // MARK: - Properties
    let sideMenu = SideMenu()
    var collectionDataSource = GenericCollectionDataSource<NewsFeedCell,Person>()
    var sideMenuDataSource = GenericTableDataSource<SideMenuCell,SideMenuItem>()
    
    // MARK: - Views Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionDataSource.data = [Person(firstName: "Greatest", lastName: "Ever"), Person(firstName: "Zabre Greatest", lastName: "Ever"), Person(firstName: "Greatest", lastName: "Pop")]
        
        collectionView.dataSource = collectionDataSource
        
        sideMenu.tableView = sideMenuTableView
        sideMenuDataSource.data = [SideMenuItem(name: "Home", image: ""), SideMenuItem(name: "Help", image: ""), SideMenuItem(name: "FAQs", image: ""), SideMenuItem(name: "About Us", image: ""), SideMenuItem(name: "Contact Us", image: ""), SideMenuItem(name: "Terms & Conditions", image: ""), SideMenuItem(name: "Settings", image: "")]
        
        sideMenuTableView.dataSource = sideMenuDataSource
        sideMenuTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profilePicture.animateProgress()
    }

    // MARK: - Actions
    
    @IBAction func didTapHamburger(_ sender: UIBarButtonItem) {
        
        sideMenu.showSideMenu()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

extension HomeViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sideMenu.dismissMenu {
            
            print(self.sideMenuDataSource.data[indexPath.row].name)
        }
    }
}
