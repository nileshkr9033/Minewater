//
//  AreaViewController.swift
//  minewater1
//
//  Created by HQ-ICT-VINAYJ on 15/10/16.
//  Copyright © 2016 HQ-ICT-VINAYJ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class AreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var rightbutton: UIBarButtonItem!
    @IBOutlet weak var leftbutton: UIBarButtonItem!
    let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
    var subsidiary : String = ""
    static var area = ""
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
      //  tableView.delegate = self
      //  tableView.dataSource = self
        
        tableView.reloadData()
        subsidiary=LeftViewController.subsi
        print("Hello\(subsidiary)")

        getData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    struct Data
    {
        var company : String
        var discharge : String
        var projectuse : String
        var otheruse : String
        var domestic : String
        var agriculture : String
        var recharge : String
        var industry : String
    }
    
    var DataArray = [Data]()
    var flag=0
    
    func getData()
    {
        
        // print("_____")
        
        let url = "http://elib.cmpdi.co.in/MineWater/api/area_ttl1.php"
        //print(subsidiary1)
        
        
        Alamofire.request(.POST, url, parameters: ["comp": subsidiary])
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
                        
                        
                        let a:String=json["result"][i]["AREA"].stringValue
                        //    let z:String=json["result"][i]["NOTICE_REFNO"].stringValue
                        
                        let b:String=json["result"][i]["DISCHARGE"].stringValue
                        let c:String=json["result"][i]["OWN_USE"].stringValue
                        let d:String=json["result"][i]["OTHER_USE"].stringValue
                         let e:String=json["result"][i]["DOMESTIC"].stringValue
                         let f:String=json["result"][i]["AGRICULTURE"].stringValue
                         let g:String=json["result"][i]["RECHARGE"].stringValue
                         let h:String=json["result"][i]["INDUSTRY"].stringValue
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
                        self.DataArray.append(Data(company: a, discharge: b, projectuse: c,otheruse: d,domestic: e,agriculture: f,recharge: g,industry: h))
                        
                    }
                    print("#\(self.DataArray.count)")
                    
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        
        return DataArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "Cell"
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as!
        AreaTableViewCell
        
    
        cell.company.text! = DataArray[indexPath.row].company
        cell.discharge.text=DataArray[indexPath.row].discharge
        cell.domestic.text=DataArray[indexPath.row].domestic
        cell.industry.text=DataArray[indexPath.row].industry
        cell.recharge.text=DataArray[indexPath.row].recharge
        cell.projectuse.text=DataArray[indexPath.row].projectuse
        cell.otheruse.text=DataArray[indexPath.row].otheruse
        cell.agriculture.text=DataArray[indexPath.row].agriculture

        print("asdfqwer")
        
        
      //  let cell = UITableViewCell()
      //  cell.textLabel?.text = "hello"
        return cell
    }
    
    class func doSomething(comp: String)
    {
        area = comp
        print(area)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Set selected location to var
       // selectedLocation = feedItems[indexPath.row] as! LocationModel2
        // Manually call segue to detail view controller
        AreaViewController.doSomething(DataArray[indexPath.row].company)
        self.performSegueWithIdentifier("project", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get reference to the destination view controller
        if(segue?.identifier == "project")
        {
            let detailVC  = segue!.destinationViewController as! ProjectViewController
            //let navVC = segue!.destinationViewController as! UINavigationController
            
            // let detailVC = navVC.viewControllers.first as! AreaViewController
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
