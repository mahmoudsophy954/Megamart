//
//  CategoryViewController.swift
//  Megamart
//
//  Created by Macintosh on 10/07/2022.
//

import UIKit
import Floaty

class CategoryViewController: UIViewController {
    
  
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    @IBOutlet weak var floatySubCat: Floaty!
    @IBOutlet weak var productsCollection: UICollectionView!
    
    var menArray = [Int]()
    var womenArray = [Int]()
    var kidsArray = [Int]()
    var saleArray = [Int]()
    var productsArray = [ProductModel]()
    var viewedArray = [ProductModel]()
    let productsViewModel = ProductsViewModel()
    let collectsViewModel = CollectsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
//MARK: -               SubCategory
        
        floatySubCat.addItem("T-shirt",icon: UIImage(named: "T-SHIRTS")!, handler: { item in
            
            self.productsViewModel.fetchData()
            self.productsViewModel.bindingData = { products, error in
                if let products = products {
                    self.viewedArray.removeAll()
                    for  index in 0..<products.count    {
                        
                        if products[index].product_type == Constants.ProductType.TSHIRTS.rawValue{
                            self.viewedArray.append(products[index])
                         
                       }
                    }
                    DispatchQueue.main.async {
                   self.productsCollection.reloadData()
               }
          
            }
            }
        })
        
        floatySubCat.addItem("Shoes",icon: UIImage(named: "SHOES")!, handler: { item in
            self.productsViewModel.fetchData()
            self.productsViewModel.bindingData = { products, error in
                if let products = products {
                    self.viewedArray.removeAll()
                    for  index in 0..<products.count    {
                        
                        if products[index].product_type == Constants.ProductType.SHOES.rawValue{
                            self.viewedArray.append(products[index])
                         
                       }
                    }
                    DispatchQueue.main.async {
                   self.productsCollection.reloadData()
               }
          
            }
            }
        })
        
        floatySubCat.addItem("Acessories",icon: UIImage(named: "Accessories")!, handler: { item in
            self.productsViewModel.fetchData()
            self.productsViewModel.bindingData = { products, error in
                if let products = products {
                    self.viewedArray.removeAll()
                    for  index in 0..<products.count    {
                        
                        if products[index].product_type == Constants.ProductType.ACCESSORIES.rawValue{
                            self.viewedArray.append(products[index])
                         
                       }
                    }
                    DispatchQueue.main.async {
                   self.productsCollection.reloadData()
               }
          
            }
            }
        })
        
        floatySubCat.buttonColor = UIColor.white
        floatySubCat.plusColor = UIColor.black
        self.view.addSubview(floatySubCat)
        
        
        productsCollection.delegate = self
        productsCollection.dataSource = self
        
        self.productsCollection.register(UINib(nibName: Constants.Products_nib_name, bundle: nil), forCellWithReuseIdentifier: Constants.ProductsViewCell_id)
        
        
//MARK: -                 Fetch Products
        
       
          productsViewModel.fetchData()
          productsViewModel.bindingData = { products, error in
              if let products = products {
                  self.productsArray = products
                  self.viewedArray = self.productsArray
                  DispatchQueue.main.async {
   
                 self.productsCollection.reloadData()
             }
        
    }
}
        
        
//MARK: -                   Fetch Collects
        
        
            collectsViewModel.fetchData()
            collectsViewModel.bindingData = { collects, error in
                 if let collects = collects {
                    for   index in 0..<collects.count {
                     switch collects[index].collectionID{
                     case Constants.CategoryId.Men.rawValue :
                         self.menArray.append(collects[index].productID)
                     case Constants.CategoryId.Women.rawValue :
                         self.womenArray.append(collects[index].productID)
                     case Constants.CategoryId.Kids.rawValue :
                         self.kidsArray.append(collects[index].productID)
                     case Constants.CategoryId.Sale.rawValue :
                         self.saleArray.append(collects[index].productID)
                     default:
                         print("******Error in filitring*******")
                     }

         }
       }
   }
}
    
 //MARK: -                   Categories Buttons
    
    
    
    @IBAction func segments_Action(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            productsViewModel.fetchData()
            productsViewModel.bindingData = { products, error in
                if let products = products {
                    self.viewedArray.removeAll()
                    for  index in 0..<products.count    {
                        for i in 0..<self.womenArray.count {
                        if self.womenArray[i] == products[index].id{
                            self.viewedArray.append(products[index])
                         }
                       }
                    }
                    DispatchQueue.main.async {
                   self.productsCollection.reloadData()
                    }
                 }
              }
            
        case 1:
            productsViewModel.fetchData()
            productsViewModel.bindingData = { products, error in
                if let products = products {
                    self.viewedArray.removeAll()
                    for  index in 0..<products.count    {
                        for i in 0..<self.menArray.count {
                        if self.menArray[i] == products[index].id{
                            self.viewedArray.append(products[index])
                         }
                       }
                    }
                    DispatchQueue.main.async {
                   self.productsCollection.reloadData()
                    }
                }
            }
            
        case 2:
            productsViewModel.fetchData()
            productsViewModel.bindingData = { products, error in
                if let products = products {
                    self.viewedArray.removeAll()
                    for  index in 0..<products.count    {
                        for i in 0..<self.saleArray.count {
                        if self.saleArray[i] == products[index].id{
                            self.viewedArray.append(products[index])
                         }
                       }
                    }
                    DispatchQueue.main.async {
                   self.productsCollection.reloadData()
                    }
                }
            }
            
        case 3:
            productsViewModel.fetchData()
            productsViewModel.bindingData = { products, error in
                if let products = products {
                    self.viewedArray.removeAll()
                    for  index in 0..<products.count    {
                        for i in 0..<self.kidsArray.count {
                        if self.kidsArray[i] == products[index].id{
                            self.viewedArray.append(products[index])
                         }
                       }
                    }
                    DispatchQueue.main.async {
                   self.productsCollection.reloadData()
                 }
                }
            }
        default:
            break
        }
        
    }
    

    
//MARK: -                    Navigation Bar Buttons
    
    @IBAction func goFav(_ sender: Any) {
        if Login_Verification(){
            let storyboard = UIStoryboard(name: Constants.Favorites_storyboard,bundle: nil)
            if let favouriteVC = storyboard.instantiateViewController(withIdentifier: Constants.Favorites_ViewController_id) as? Favorites_ViewController{
                self.navigationController?.pushViewController(favouriteVC, animated: true)
            }
        }
        else{
            requestLogin_alert(viewController: self)
        }
    }
    
    @IBAction func goCart(_ sender: Any) {
        
        if Login_Verification(){
            let storyboard = UIStoryboard(name: Constants.bag_storyboard,bundle: nil)
            if let cartVC = storyboard.instantiateViewController(withIdentifier: Constants.BagViewController_id) as? BagViewController{
                self.navigationController?.pushViewController(cartVC, animated: true)
            }
        }
        else{
            requestLogin_alert(viewController: self)
        }
    
   }
    
    
    @IBAction func searchButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.Products_storyboard,bundle: nil)
        if let productVC = storyboard.instantiateViewController(withIdentifier: Constants.ProductsViewController_id) as? ProductsViewController{
            self.navigationController?.pushViewController(productVC, animated: true)
        }
    }
    
       
}


//MARK: -                                     CollectionView Layout


 extension CategoryViewController: UICollectionViewDataSource,UICollectionViewDelegate {


        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
            return viewedArray.count
        }


        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
         
            
            let cell = productsCollection.dequeueReusableCell(withReuseIdentifier: Constants.ProductsViewCell_id, for: indexPath) as! ProductViewCell
            cell.ProductPrice.text = viewedArray[indexPath.row].variants[0].price
               let image = viewedArray[indexPath.row].image.src
               cell.setCell(imageUrl: image)
            return cell
        }



        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
            CGSize(width: productsCollection.bounds.width / 2.2, height: productsCollection.bounds.height / 2.2)
        }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: Constants.productDetails_storyboard,bundle: nil)
         if let productVC = storyboard.instantiateViewController(withIdentifier:Constants.ProductDetails_ViewController_id) as? ProductDetails_ViewController{
             productVC.productID = String(viewedArray[indexPath.row].id)
             self.navigationController?.pushViewController(productVC, animated: true)
       }
    }
  
}
