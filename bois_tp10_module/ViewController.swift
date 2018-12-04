//
//  ViewController.swift
//  bois_tp10_module
//
//  Created by BOIS Martin on 03/12/2018.
//  Copyright © 2018 BOIS Martin. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    // Main Menu Var
    @IBOutlet weak var createTableButton: UIButton!
    @IBOutlet weak var insertModuleButton: UIButton!
    @IBOutlet weak var countTableButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var updateSigleButton: UIButton!
    @IBOutlet weak var deleteModuleButton: UIButton!
    
    // Add Module Panel Var
    @IBOutlet weak var parcoursTextField: UITextField!
    @IBOutlet weak var categorieTextField: UITextField!
    @IBOutlet weak var creditTextField: UITextField!
    @IBOutlet weak var sigleTextField: UITextField!
    
    @IBOutlet weak var addModuleButton: UIButton!
    var database: Connection!
    
    
    let module_table = Table("module")
    let module_sigle = Expression<String>("sigle")
    let module_parcours = Expression<String>("parcours")
    let module_categorie = Expression<String>("categorie")
    let module_credit = Expression<String>("credit")
    
    let alert = UIAlertController(title: "Error", message: "Please enter fields correctly", preferredStyle: .alert)
    
    var sigle = ""
    var parcours = ""
    var categorie = ""
    var credit = ""
    
    var pk = 1000;           // valeur de départ pour la primary key
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Il est possible de créer des fichiers dans le répertoire Documents" de votre application.
        // Ici, création d'un fichier users.sqlite3
        
        do {
            let documentDirectory = try
                FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask, appropriateFor: nil, create:               true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let base = try Connection(fileUrl.path)
            self.database = base;
        }
        catch {
            print (error)
        }
        
        print ("--> viewDidLoad fin")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createTable() {
        print ("--> createTableModule debut")
        
        
        // Instruction pour faire un drop de la table USERS
        let dropTable = self.module_table.drop(ifExists: true)
        
        // Instruction pour faire un create de la table USERS
        let createTable = self.module_table.create { table in
            table.column(self.module_sigle, primaryKey: true)
            table.column(self.module_parcours)
            table.column(self.module_categorie)
            table.column(self.module_credit)
        }
        do {
            // Exécution du drop et du create
            try self.database.run(dropTable)
            try self.database.run(createTable)
            print ("Table module est créée")
        }
        catch {
            print (error)
        }
        
        print ("--> createTableUsers fin")
    }
    
    @IBAction func addModule(_ sender: Any) {
        self.sigle = self.sigleTextField.text!
        self.credit = self.creditTextField.text!
        self.categorie = self.categorieTextField.text!
        self.parcours = self.parcoursTextField.text!
        if (sigle != "" && parcours != "" && categorie != "" && credit != "") {
            var insert = self.module_table.insert(self.module_sigle <- sigle, self.module_parcours <- parcours, self.module_categorie <- categorie, self.module_credit <- credit)
            do {
                try self.database.run(insert)
                print ("Insert ok")
            }
            catch {
                print(error)
            }
            print("--> addModule fini")
        }
            
        else {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func countTable(_ sender: Any) {
        print ("--> CountTable debut")
        var resultat = 0
        do {
            resultat = try self.database.scalar(module_table.count)
            print ("count = ", resultat)
            countLabel.text = String(resultat)
            
        }
        catch {
            print (error)
            resultat = -1
        }
        print ("--> CountTable fin")
    
    }
    
    
    
    
}

