//
//  RightViewController.swift
//  minewater1
//
//  Created by HQ-ICT-VINAYJ on 14/10/16.
//  Copyright © 2016 HQ-ICT-VINAYJ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RightViewController: UIViewController {
var subsi1=""
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subsi1=LeftViewController.subsi
        p(subsi1)

 NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RightViewController.loadList(_:)),name:"load", object: nil)
 //NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RightViewController.loadList(_:)), name:"NotificationIdentifier", object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var area = [String]()
    func p(comp: String)
    {
        //area.removeAll()
        // print("gg")
        let url = "http://elib.cmpdi.co.in/MineWater/api/area_ttl1.php"
        //print(subsidiary1)
        
        
        Alamofire.request(.POST, url, parameters: ["comp": subsi1])
            .responseJSON { response in
                if let res = response.result.value {
                    let json = JSON(res)
                    print("JSON \(json)")
                    let count=json["result"].count
                    self.area = [String](count: count, repeatedValue: "")
                    //  print(json["result"][0]["COMP"])
                    // print(count)
                    var x=0;
                
                  //  self.DataArray = [Data]()
                    for i in 0..<count {
                        print(i)
                        
                        self.area[i]=json["result"][i]["AREA"].stringValue
                       // self.area.append(json["result"][i]["AREA"].stringValue)
                       //    let z:String=json["result"][i]["NOTICE_REFNO"].stringValue
                        
                        
                        
                        
                    }
                    
                    self.do_table_refresh()
                    // self.chartLoad()
                    
                }
                
                
        }
        
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var urlarea1 = ""
        
        let row = indexPath.row
        print(area[row])
        print("assa")
       // self.tableView.reloadData()
        //let homeModel = HomeModel()
        //homeModel.delegate = self
        //homeModel.downloadItems("http://172.18.1.76/and/aa.json")
        //urlarea1 = "http://elib.cmpdi.co.in/LR/api/project1.php?area="+swiftBlogs[row]
        //urlarea1 = urlarea1.stringByReplacingOccurrencesOfString(" ", withString: "%20")
      //  MenuController1.doSomething1(urlarea1)
      //  MenuController1.doSomething3(plant[row])
       // MenuController1.doSomething2(swiftBlogs[row])
        // let nvc = NewsTableViewController()
        // nvc.q()
        // let pro = ProjectViewController()
        // pro.hide()
        AreaViewController.doSomething(area[row])
        NSNotificationCenter.defaultCenter().postNotificationName("load1",
                                                                  object: nil,
                                                                  userInfo:["message":"a"])
        
    }
    
    

    
    // MARK:  UITextFieldDelegate Methods
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return area.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let row = indexPath.row
        print(area.count)
        cell.textLabel?.text = area[row]
        
        return cell
    }
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
 /*   class func doSomething1(comp: String)
    {
        urlarea = comp
    }
    
    class func doSomething2(comp: String)
    {
        area = comp
    }
    
    class func doSomething3(comp: String)
    {
        pl = comp
    }*/
    
    
    func loadList(notification: NSNotification){
        //load data here
        
        
        let userInfo:Dictionary<String,String!> = notification.userInfo as! Dictionary<String,String!>
        let messageString = userInfo["message"]
        print("messageString")
        //swiftBlogs[0] = messageString!
        subsi1=LeftViewController.subsi
        p(subsi1)
        //self.tableView.reloadData()
    }
    
    func loadList(){
        
        print("hello")
        
    }
    
    
    func loadList1(notification: NSNotification){
        //load data here
        
        
        let userInfo:Dictionary<String,String!> = notification.userInfo as! Dictionary<String,String!>
        let messageString = userInfo["message"]
        print("messageString")
        //swiftBlogs[0] = messageString!
        subsi1=LeftViewController.subsi
        p(subsi1)
        //self.tableView.reloadData()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
