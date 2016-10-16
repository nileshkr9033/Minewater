//
//  SubsidiaryViewController.swift
//  minewater1
//
//  Created by HQ-ICT-VINAYJ on 14/10/16.
//  Copyright © 2016 HQ-ICT-VINAYJ. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class SubsidiaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rightbutton: UIBarButtonItem!
    @IBOutlet weak var leftbutton: UIBarButtonItem!
    let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            leftbutton.target = self.revealViewController()
            leftbutton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            //revealViewController().rightViewRevealWidth = 0
            rightbutton.target = revealViewController()
            rightbutton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())


        }
       // self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }
        // Do any additional setup after loading the view.
    

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct Data
    {
        var company : String
        var discharge : String
        var projectuse : String
        var otheruse : String
    }
   
    var DataArray = [Data]()
    var flag=0
    
    func getData()
    {
        
       // print("_____")
        
        let url = "http://elib.cmpdi.co.in/MineWater/api/comp_ttl1.php"
        //print(subsidiary1)
        
        
        Alamofire.request(.POST, url)//, parameters: ["comp": subsidiary1!,"grade": grade1!,"mode": mode1!,"id": "41"])
            .responseJSON { response in
                if let res = response.result.value {
                    let json = JSON(res)
                    print("JSON \(json)")
                    let count=json["result"].count
                    //  print(json["result"][0]["COMP"])
                    // print(count)
                    var x=0;
                    self.DataArray = [Data]()
                    for i in 0..<count {
                        print(i)
                        
                        
                        let a:String=json["result"][i]["COMP"].stringValue
                        //    let z:String=json["result"][i]["NOTICE_REFNO"].stringValue
                        
                        let b:String=json["result"][i]["DISCHARGE"].stringValue
                        let c:String=json["result"][i]["OWN_USE"].stringValue
                        let d:String=json["result"][i]["OTHER_USE"].stringValue
                        //let e:String=json["result"][i]["TOTAL"].stringValue
                        
                        
                     /*   if a == "ZCIL"{
                            let domesticPercent = (self.roundToPlaces(((b as NSString).doubleValue/1000000),places: 2) / self.roundToPlaces(((e as NSString).doubleValue/1000000),places: 2) )*100
                            self.domesticPercentage.text! = "\(domesticPercent)%"
                            
                            
                            let agriPercent = (self.roundToPlaces(((c as NSString).doubleValue/1000000),places: 2) / self.roundToPlaces(((e as NSString).doubleValue/1000000),places: 2) )*100
                            self.agriculturePercentage.text! = "\(agriPercent)%"
                            
                            
                            let rechargePercent = (self.roundToPlaces(((d as NSString).doubleValue/1000000),places: 2) / self.roundToPlaces(((e as NSString).doubleValue/1000000),places: 2) )*100
                            self.rechargePercentagaaage.text! = "\(rechargePercent)%"
                            self.cilTotal = self.roundToPlaces(((e as NSString).doubleValue/1000000),places: 2)
                            
                        }else{
                            self.sub1.append(a)
                            self.float.append(self.roundToPlaces(((e as NSString).doubleValue/1000000),places: 2))
                        }
                        
                        
                        //   print("z is \(z)")
                        */
                        self.DataArray.append(Data(company: a, discharge: b, projectuse: c,otheruse: d))
                        
                    }
                    
                    
                    self.flag=1
                    self.tableView.reloadData()
                   // self.chartLoad()
                    
                }
                
                
        }
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8   }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        return cell
    }
    
     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? SubsidiaryTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        tableViewCell.tag = indexPath.section
    }
    
    
     func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? SubsidiaryTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
}



extension SubsidiaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        if(flag==1)
        {
        print("#\(DataArray[collectionView.tag].discharge)")
        cell.company.text=DataArray[collectionView.tag].company
        cell.discharge.text=DataArray[collectionView.tag].discharge
        cell.projectuse.text=DataArray[collectionView.tag].projectuse
        cell.otheruse.text=DataArray[collectionView.tag].otheruse
      // cell.backgroundColor = model[collectionView.tag][indexPath.item]
        }
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
         self.performSegueWithIdentifier("area", sender: self)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get reference to the destination view controller
        if(segue?.identifier == "area")
        {
            //let detailVC  = segue!.destinationViewController as! AreaViewController
            let navVC = segue!.destinationViewController as! UINavigationController
            
            let detailVC = navVC.viewControllers.first as! AreaViewController
            // Set the property to the selected location so when the view for
            // detail view controller loads, it can access that property to get the feeditem obj
            //detailVC.detail = selectedLocation
        }
        else if(segue?.identifier == "update")
        {
            let detailVC  = segue!.destinationViewController as! AreaViewController
            // Set the property to the selected location so when the view for
            // detail view controller loads, it can access that property to get the feeditem obj
            //detailVC.url = url
        }
        
    }
}
