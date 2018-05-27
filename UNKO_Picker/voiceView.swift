//
//  selectVoice.swift
//  UNKO_Picker
//
//  Created by 牧 良樹 on 2018/03/12.
//  Copyright © 2018年 牧 良樹. All rights reserved.
//

import UIKit

class voiceView: UIViewController,UITableViewDelegate,UITableViewDataSource {

  @IBOutlet weak var voiceTable: UITableView!
  var voiceList = ["牧","レミ","みんな"]
  var selectNum = 0
  

  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectNum = indexPath.row
    performSegue(withIdentifier: "selectedVoice",sender: nil)
    print("選ばれたのは\(selectNum)です")
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "voices", for:indexPath) as UITableViewCell
    cell.textLabel?.text = voiceList[indexPath.row]
    
    return cell
  }

  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return voiceList.count
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "selectedVoice") {
      let vc: ViewController = (segue.destination as? ViewController)!
      print("渡したのは\(selectNum)です")
      vc.voiceNum = selectNum
    }
  }

}


