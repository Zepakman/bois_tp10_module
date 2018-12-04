//
//  InsertModuleViewController.swift
//  bois_tp10_module
//
//  Created by BOIS Martin on 04/12/2018.
//  Copyright © 2018 BOIS Martin. All rights reserved.
//

import UIKit
import SQLite

class InsertModuleViewController: UIViewController {

    @IBOutlet weak var insertParcours: UITextField!
    @IBOutlet weak var insertCategorie: UITextField!
    @IBOutlet weak var insertCredit: UITextField!
    @IBOutlet weak var insertSigle: UITextField!
    
    @IBOutlet weak var insertModule: UIButton!
    
    var database: Connection!
    
    let module_table = Table("module")
    
    var sigle = ""
    var parcours = ""
    var categorie = ""
    var credit = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func insertModule(_ sender: Any) {
        if (sigle != "" && parcours != "" && categorie != "" && credit != "") {
            performSegue(withIdentifier: "segueBravo", sender: self)
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

}
