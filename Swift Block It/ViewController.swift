//
//  ViewController.swift
//  Swift Block It
//
//  Created by Steve Trease on 31/08/2015.
//  Copyright © 2015 Steve Trease. All rights reserved.
//

// http://stackoverflow.com/questions/31981893/content-blocker-extension-with-a-string-instead-of-a-file

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var elementsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print ("ViewDidLoad")
        elementsLabel.text = String(0)
        
        /*
        
        let fileManager = NSFileManager()
        let fileName = "blockerList.json"
        //  NSURL *jsonPath = [[[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.net.tenshu.The-Blocker"] URLByAppendingPathComponent:@"safari.json"];

       let jsonPath : NSURL = fileManager.containerURLForSecurityApplicationGroupIdentifier("group.trease.eu")!
        // .URLByAppendingPathComponent("blockerList.json")
        print (jsonPath)
        
        // fileManager.fileExistsAtPath(<#T##path: String##String#>)
        
        print ("filemanager")
        // print (NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("blockerList", withExtension: "json")!))
        
        print ("+++")
        let files = fileManager.enumeratorAtPath(jsonPath.path!)
        while let file = files?.nextObject() {
            print(file)
        }
        print ("+++")
        print (jsonPath.path!)
        print (fileManager.fileExistsAtPath(jsonPath.path!))
    
        */
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    @IBAction func resetButton(sender: AnyObject) {
        print("reset button pressed")
        elementsLabel.text = String(0)
    }
    @IBAction func refreshButton(sender: AnyObject) {
        print("refresh button pressed")
        // let request = NSMutableURLRequest(URL: NSURL(string: "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=nohtml&showintro=0&startdate%5Bday%5D=01&startdate%5Bmonth%5D=06&startdate%5Byear%5D=2015&mimetype=plaintext")!)
        let request = NSMutableURLRequest(URL: NSURL(string: "http://pgl.yoyo.org/adservers/serverlist.php?hostformat=nohtml&showintro=0&mimetype=plaintext")!)
        
        request.HTTPMethod = "POST"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            print ("NSURLSession.sharedSession")
            
            if error != nil {
                print ("error: " + error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding: NSASCIIStringEncoding)!
                let elements = result.componentsSeparatedByString("\n")
                dispatch_async(dispatch_get_main_queue(), {
                    print("numbers of elements \(elements.count)")
                    self.elementsLabel.text = String(elements.count)
                })
                // for index in 0...(elements.count - 1) {
                // print (String(index) + " " + elements[index])
                // }
                
                SFContentBlockerManager.reloadContentBlockerWithIdentifier("eu.trease.Swift-Block-It.Content-Blocker",
                    completionHandler:{(error: NSError?) in
                        print ("SFContentBlockerManager.reloadContentBlockerWithIdentifier")
                        print (error?.localizedDescription)
                })
            }
        }
        task.resume()
    }
}

