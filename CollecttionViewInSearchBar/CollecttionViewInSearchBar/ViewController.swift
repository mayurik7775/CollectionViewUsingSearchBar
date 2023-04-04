//
//  ViewController.swift
//  CollecttionViewInSearchBar
//
//  Created by Mac on 04/04/23.
//

import UIKit
struct DataModel{
    var name : String = ""
    var images : String = ""
}
class ViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate{

    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var arrData = [DataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        searchBarSetUp()
    }
        private func DataModelSetUp(){
            arrData = [DataModel(name: "FishKari", images: "dinner1"),
            DataModel(name: "BhainganMasala", images: "dinner2"),
            DataModel(name: "Thali", images: "dinner3"),
            DataModel(name: "Paneer", images: "dinner4-1"),
            DataModel(name: "AndaKari", images: "dinner5"),
            DataModel(name: "ZunkaBhakri", images: "dinner6"),
            DataModel(name: "Non-Veg Thali", images: "dinner7"),
            DataModel(name: "Puri Bhaji", images: "dinner8"),
            DataModel(name: "Shev Bhaji", images: "lunch1")]
        }
        private func searchBarSetUp(){
            searchController.searchResultsUpdater = self
            searchController.searchBar.delegate = self
            navigationItem.searchController = searchController
        }
    }
extension ViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else{ return }
        if searchText == "" {
            DataModelSetUp()
        }else {
            arrData = arrData.filter{
                $0.name.contains(searchText.lowercased())
            }
        }
        myCollectionView.reloadData()
    }
}
extension ViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : myCollectionViewCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! myCollectionViewCell
        cell.namelbl.text = arrData[indexPath.row].name
        cell.img.image = UIImage(named: arrData[indexPath.row].images)
        cell.layer.borderWidth = 10
        cell.layer.borderColor = .init(red: 5, green: 5, blue: 5, alpha: 5)
        cell.layer.cornerRadius = 20
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 270, height: 261)
    }
    
}
