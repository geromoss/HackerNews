//
//  DetalleViewController.swift
//  HackerNews
//
//  Created by Gerardo Lupa on 12-10-17.
//  Copyright © 2017 Gerardo Lupa. All rights reserved.
//  I used Alamofire to load data using JSON  - use cococapod and add PodFile
//  pod 'Alamofire', '~> 4.0'


import UIKit

class DetalleViewController: UIViewController {
    
 
    @IBOutlet weak var MywebView: UIWebView!
    
    
    var otroRecivido = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let Myurl = URL(string: otroRecivido)
        let requestObj = URLRequest(url: Myurl!)
        
        MywebView.loadRequest(requestObj)

        // Do any additional setup after loading the view.
        print(otroRecivido)
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
