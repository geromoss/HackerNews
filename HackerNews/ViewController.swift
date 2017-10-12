//
//  ViewController.swift
//  HackerNews
//
//  Created by Gerardo Lupa on 12-10-17.
//  Copyright © 2017 Gerardo Lupa. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //link variable to MiTabla, this can customize your TableView in different size and positions for labels personalized
    @IBOutlet weak var MiTabla: UITableView!
    
    //variable to receive news using API JSON
    var hackersNews = [AnyObject]()
    
    //var for refresh
    var Elrefresh = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //implement refresh button
        Elrefresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        Elrefresh.addTarget(self, action: #selector(ViewController.populate), for: .valueChanged)
        Elrefresh.tintColor = UIColor.cyan
        Elrefresh.backgroundColor = UIColor.gray
        //load MyTableView
        self.MiTabla.addSubview(Elrefresh)
        
        //load data the hacker new using Alamofire is the best cocoa-pods to load data asynchronous and using JSON
        Alamofire.request("http://hn.algolia.com/api/v1/search_by_date?query=ios").validate(statusCode: 200..<600).responseJSON{ response in
            
            //switch 
            switch response.result{
                
            //load the data
            case .success:
                //put array JSON in a Dictionary variable
                if let dict = response.value as? Dictionary<String,Any>{
                    if let innerDict = dict["hits"]{
                        //traspamos los datos que hay dentro el array a la variable
                        self.hackersNews = innerDict as! [AnyObject]
                        //we make a reaload data for show data in tableview
                        self.MiTabla.reloadData()
                    }
                
                }
            
            //if had an error just show Error in console
            case .failure(let error):
            print("RESPONSE ERROR: \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: code for TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //mostramos en la tabla la cantidad de celdas de acuerdo a la cantidad de datos que hay en el array ActorsArray
        return hackersNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.MiTabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        //load data from array
        let titleRecibido = hackersNews[indexPath.row]["story_title"]
        cell.story_title.text = titleRecibido as? String
        
        let MiAutorRecibido = hackersNews[indexPath.row]["author"]
        cell.author.text = MiAutorRecibido as? String
        
        let CreadoRecibido = hackersNews[indexPath.row]["created_at"]
        cell.created_at.text = CreadoRecibido as? String
        
    return cell
    }
    
    //enable de swipe
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //we show 1 type Delete when you swipe left in some cell
        if (editingStyle == UITableViewCellEditingStyle.delete) {
             hackersNews.remove(at: indexPath.item)
                tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    
    }

    
    func populate(){
        //reaload new data
        Alamofire.request("http://hn.algolia.com/api/v1/search_by_date?query=ios").validate(statusCode: 200..<600).responseJSON{ response in
            
            //switch
            switch response.result{
                
            case .success:
                //load the data
                //let result = response.result.value
                //transpamos los datos a un dictionary
                //print(response.value!)
                if let Otrodict = response.value as? Dictionary<String,Any>{
                    if let OtroinnerDict = Otrodict["hits"]{
                        //traspamos los datos que hay dentro el array a la variable
                        self.hackersNews = OtroinnerDict as! [AnyObject]
                        //self.hackersNews.append(innerDict as [AnyObject])
                       // self.hackersNews.append(innerDict as AnyObject)
                        //hacemos un reload de los datos
                        self.MiTabla.reloadData()
                        //imprimir los datos por consola
                        print("usamos populate")
                    }
                    
                }
                
            //si el acceso no se pudo completar con exito mostrará el error
            case .failure(let error):
                print("RESPONSE ERROR: \(error)")
            }
        }
        
        //load the new data
        MiTabla.reloadData()
        //end the refreshing
        Elrefresh.endRefreshing()
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if (segue.identifier == "detalle") {
            
            if let ElindexPath = MiTabla.indexPathForSelectedRow{
                let destino = segue.destination as! DetalleViewController
                //data to pass to another ViewController
                destino.otroRecivido = hackersNews[ElindexPath.row]["story_url"] as! String
                print("Datos a Enviar: \(destino.otroRecivido)")
            }
        }
    }
    

}

