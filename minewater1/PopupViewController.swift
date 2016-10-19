//
//  PopupViewController.swift
//  minewater1
//
//  Created by HQ-ICT-VINAYJ on 19/10/16.
//  Copyright © 2016 HQ-ICT-VINAYJ. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
var flag=0
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

    override func viewDidLoad() {
        super.viewDidLoad()

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

}
