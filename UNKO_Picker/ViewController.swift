//
//  ViewController.swift
//  UNKO_Picker
//
//  Created by 牧 良樹 on 2017/07/07.
//  Copyright © 2017年 牧 良樹. All rights reserved.
//
import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    var light = [UIView]()
    
    var callbackImage: UIImageView!
    
    @IBOutlet weak var HiLabel: UILabel!
    @IBOutlet weak var Header: UILabel!
    @IBOutlet weak var colorHeader: UILabel!
    @IBOutlet weak var callImage: UIImageView!
    @IBOutlet weak var hiHeader: UILabel!
    @IBOutlet weak var Footer: UILabel!
  
    @IBOutlet weak var Pause: UIButton!
    @IBOutlet weak var Call: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var Play: UIButton!
    @IBOutlet weak var pick: UIButton!
    @IBOutlet weak var selectVoice: UIButton!
  
    //@IBOutlet weak var down: UIButton!
    var player : MPMusicPlayerController?
    var MooPlayer: AVAudioPlayer!
    var RooPlayer: AVAudioPlayer!
    var MheyPlayer: AVAudioPlayer!
    var RheyPlayer: AVAudioPlayer!
    var MhaiPlayer: AVAudioPlayer!
    var MfufuPlayer: AVAudioPlayer!
    var MfwfwPlayer: AVAudioPlayer!
    var oo = true
    var timer: Timer!
    var musicTime = [String]()
    var mTitle: String = "Title"
    var changeTitle = 0
    var callDic: [String: Any] = [:]
    var dlTiming = [String]()
    var callFlag = false
    var callingFlag = false
    
    let pi = CGFloat(M_PI)
    var testText = "UNKO"
    var voiceNum = 0
  
  //声選択用
  @IBAction func backCaaalll(segue: UIStoryboardSegue) {
    print("受け取ったのは\(voiceNum)です")
    
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "backVoice") {
      let vc: ViewController = (segue.destination as? ViewController)!
      vc.testText = "戻ったああああ"
    }
  }
  
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        player = MPMusicPlayerController.applicationMusicPlayer()
        //player = MPMusicPlayerController.systemMusicPlayer()
        
        let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
        try! audioSession.setCategory(AVAudioSessionCategoryAmbient)
        try! audioSession.setActive(true)
        
        do {
            let MooPath = Bundle.main.url(forResource: "Moo", withExtension: "caf")
            MooPlayer = try AVAudioPlayer(contentsOf: MooPath!)
            let RooPath = Bundle.main.url(forResource: "Roo", withExtension: "caf")
            RooPlayer = try AVAudioPlayer(contentsOf: RooPath!)
            let MheyPath = Bundle.main.url(forResource: "Mhey", withExtension: "caf")
            MheyPlayer = try AVAudioPlayer(contentsOf: MheyPath!)
            let RheyPath = Bundle.main.url(forResource: "Rhey", withExtension: "caf")
            RheyPlayer = try AVAudioPlayer(contentsOf: RheyPath!)
            let MhaiPath = Bundle.main.url(forResource: "Mhai", withExtension: "caf")
            MhaiPlayer = try AVAudioPlayer(contentsOf: MhaiPath!)
            let MfufuPath = Bundle.main.url(forResource: "Mfufu", withExtension: "caf")
            MfufuPlayer = try AVAudioPlayer(contentsOf: MfufuPath!)
            let MfwfwPath = Bundle.main.url(forResource: "Mfwfw", withExtension: "caf")
            MfwfwPlayer = try AVAudioPlayer(contentsOf: MfwfwPath!)
        } catch {
            print("error")
        }
        
        // viewにパンを登録
        
        bottonUpdate()
        callUpdate()
        makeCircle()
        
        print(dlTiming.count)
        
    }
  
  class callFile{
    let file: String = ""
    var player: AVAudioPlayer!
    init(_file: String){
      do{
        let file = Bundle.main.url(forResource: _file,withExtension: "caf")
        player = try AVAudioPlayer(contentsOf: file!)
      }catch{
        print("無理でした！")
      }
    }
    
    
  }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        let call:UIImage = UIImage(named:"forCall4.007.png")!
        callbackImage = UIImageView(image:call)
        let callRect = CGRect(x:0,y:0,width:Call.frame.width,height:Call.frame.height)
        callbackImage.frame = callRect
        callbackImage.center = CGPoint(x:screenWidth/2, y:screenHeight*15/16)
        self.view.addSubview(callbackImage)
        callbackImage.isHidden = false
        
        view.layoutIfNeeded()
    }
    
    func makeCircle(){
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height

        let rect = CGRect(x:0,y:0,width:screenWidth*(160.0/375.0),height:screenWidth*(40.0/375.0))
        
        
        for i in 0...4{
            let ragi1 = pi/8+CGFloat(i)*pi/16*3
            let oho:UIImage = UIImage(named:"lightOn.00\(i+1).png")!
            light.append(UIImageView(image:oho))
            light[i].frame = rect
            //ohoView.bounds.width
            // 画像の中心を画面の中心に設定
            light[i].center = CGPoint(x:screenWidth/2-screenWidth*(110.0/375.0)*cos(ragi1), y:screenHeight*15/16-screenWidth*(110.0/375.0)*sin(ragi1))
            light[i].transform = CGAffineTransform(rotationAngle: ragi1)
            //print(screenWidth)
            
            self.view.addSubview(light[i])
            light[i].isUserInteractionEnabled = true
            light[i].isHidden = true
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pick(sender: AnyObject) {
        // MPMediaPickerControllerのインスタンスを作成
        let picker = MPMediaPickerController()
        // ピッカーのデリゲートを設定
        picker.delegate = self
        // 複数選択を不可にする。（trueにすると、複数選択できる）
        picker.allowsPickingMultipleItems = false
        // ピッカーを表示する
        present(picker, animated: true, completion: nil)
        
    }
    
    // メディアアイテムピッカーでアイテムを選択完了したときに呼び出される
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        // 選択した曲情報がmediaItemCollectionに入っているので、これをplayerにセット。
      player?.setQueue(with: mediaItemCollection)
        // 再生開始
      player?.play()
        
        if let mediaItem = mediaItemCollection.items.first {
            updateSongInformation(mediaItem: mediaItem)
        }
        
        // ピッカーを閉じ、破棄する
        dismiss(animated: true, completion: nil)
        
    }
    
    /// 曲情報を表示する
    func updateSongInformation(mediaItem: MPMediaItem) {
        
        mTitle = mediaItem.title ?? "何にもないよ"
        Header.text = mTitle
        print(mediaItem.title ?? "何もないよ")
        musicTime = []
        
        // アートワーク表示
        if let artwork = mediaItem.artwork {
            let image = artwork.image(at: imageView.bounds.size)
            imageView.image = image
        } else {
            // アートワークがないとき
            // (今回は灰色表示としました)
            imageView.image = nil
            imageView.backgroundColor = UIColor.gray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            /*if(self.oo){
                self.MooPlayer.play()
                self.RooPlayer.play()
            }*/
        }
        if let _player = player as? MPMusicPlayerController {
            if ("\(String( format:"%.2f",_player.currentPlaybackTime))" != "nan"
                && "\(String( format:"%.2f",_player.currentPlaybackTime))" != "0.00" ){
              musicTime.append("\(String( format:"%.2f",_player.currentPlaybackTime))")
            }
        }
        
    }
    
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pushPlay(sender: AnyObject) {
        if let _player = player as? MPMusicPlayerController {
            _player.play()
        }
    }
    
    @IBAction func pushPause(sender: AnyObject) {
        if let _player = player as? MPMusicPlayerController {
            _player.pause()
        }
    }
    
    @IBAction func callinDraged(_ sender: Any, forEvent event: UIEvent) {
        let button = sender as! UIButton
        let touch = event.touches(for: button)?.first
        let pointX = touch?.location(in: self.view).x
        let pointY = touch?.location(in: self.view).y
        let centerX = Call.frame.minX+Call.frame.width/2
        let centerY = Call.frame.minY+Call.frame.height/2
        let zahyo = pointX! - centerX
        let positionX = pointX!-centerX
        let positionY = pointY!-centerY
        let tan = positionY/positionX
        if((positionX*positionX + positionY*positionY) > (Call.frame.width/2)*(Call.frame.width/2)){
            sayCall(tang: tan, tang_z: zahyo)
        }
    }
    
    @IBAction func calloutDragged(_ sender: Any, forEvent event: UIEvent) {
        let button = sender as! UIButton
        let touch = event.touches(for: button)?.first
        let pointX = touch?.location(in: self.view).x
        let pointY = touch?.location(in: self.view).y
        let centerX = Call.frame.minX+Call.frame.width/2
        let centerY = Call.frame.minY+Call.frame.height/2
        let zahyo = pointX! - centerX
        let positionX = pointX!-centerX
        let positionY = pointY!-centerY
        let tan = positionY/positionX
        if((positionX*positionX + positionY*positionY) > (Call.frame.width/2)*(Call.frame.width/2)){
            sayCall(tang: tan, tang_z: zahyo)
        }
    }
    
    
    func sayCall(tang: CGFloat, tang_z: CGFloat){
      
      if let _player = player as? MPMusicPlayerController {
        if ("\(String( format:"%.2f",_player.currentPlaybackTime))" != "nan"
          && "\(String( format:"%.2f",_player.currentPlaybackTime))" != "0.00" ){
          musicTime.append("\(String( format:"%.2f",_player.currentPlaybackTime))")
        }
      }
        
        if(callFlag){
          if(voiceNum == 0){
            
            pushJson()
            
            if(tang>tan(pi+pi/8-pi/16) && tang<tan(pi+pi/8+pi/16) && tang_z<0){
              if(self.oo){
                self.MooPlayer.stop()
                MooPlayer.currentTime = 0
                self.MooPlayer.play()
              }
            }else if(tang>tan(pi+(pi/8+pi/16*3)-pi/16) && tang<tan(pi+(pi/8+pi/16*3)+pi/16) && tang_z<0){
              if(self.oo){
                self.MheyPlayer.stop()
                MheyPlayer.currentTime = 0
                self.MheyPlayer.play()
              }
            }else if(tang>tan(pi+(pi/8+pi/16*3*2)-pi/16) || tang<tan(pi+(pi/8+pi/16*3*2)+pi/16)){
              if(self.oo){
                self.MhaiPlayer.stop()
                MhaiPlayer.currentTime = 0
                self.MhaiPlayer.play()
              }
            }else if(tang>tan(pi+(pi/8+pi/16*3*3)-pi/16) && tang<tan(pi+(pi/8+pi/16*3*3)+pi/16) && tang_z>0){
              if(self.oo){
                self.MfufuPlayer.stop()
                MfufuPlayer.currentTime = 0
                self.MfufuPlayer.play()
              }
            }else if(tang>tan(pi+(pi/8+pi/16*3*4)-pi/16) && tang<tan(pi+(pi/8+pi/16*3*4)+pi/16) && tang_z>0){
              if(self.oo){
                self.MfwfwPlayer.stop()
                MfwfwPlayer.currentTime = 0
                self.MfwfwPlayer.play()
              }
            }
          }else if(voiceNum == 1){
            if(tang>tan(pi+pi/8-pi/16) && tang<tan(pi+pi/8+pi/16) && tang_z<0){
              if(self.oo){
                self.RooPlayer.stop()
                RooPlayer.currentTime = 0
                self.RooPlayer.play()
              }
            }else if(tang>tan(pi+(pi/8+pi/16*3)-pi/16) && tang<tan(pi+(pi/8+pi/16*3)+pi/16) && tang_z<0){
              if(self.oo){
                self.RheyPlayer.stop()
                RheyPlayer.currentTime = 0
                self.RheyPlayer.play()
              }
            }
          }
        }
        callFlag = false
        updateCall()
    }
    
    @IBAction func callBegan(_ sender: Any) {
        //print("押された！")
        callFlag = true
        for j in 0...4{
            light[j].isHidden = false
        }
        updateCall()
    }
    @IBAction func callinEnd(_ sender: Any, forEvent event: UIEvent) {
        callFlag = false
        callingFlag = true
        
        //heyCircle.isHidden = true
        callImage.isHidden = false
        
        let button = sender as! UIButton
        let touch = event.touches(for: button)?.first
        let pointX = touch?.location(in: self.view).x
        let pointY = touch?.location(in: self.view).y
        let centerX = Call.frame.minX+Call.frame.width/2
        let centerY = Call.frame.minY+Call.frame.height/2
        let zahyo = pointX! - centerX
        let tan = (pointY!-centerY)/(pointX!-centerX)
        //sayCall(tang: tan, tang_z: zahyo)
        
        updateCall()
    }
    @IBAction func calloutEnd(_ sender: Any, forEvent event: UIEvent) {
        callFlag = false
        callingFlag = true
        //heyCircle.isHidden = true
        callImage.isHidden = false
        
        let button = sender as! UIButton
        let touch = event.touches(for: button)?.first
        let pointX = touch?.location(in: self.view).x
        let pointY = touch?.location(in: self.view).y
        let centerX = Call.frame.minX+Call.frame.width/2
        let centerY = Call.frame.minY+Call.frame.height/2
        let zahyo = pointX! - centerX
        let tan = (pointY!-centerY)/(pointX!-centerX)
        //sayCall(tang: tan, tang_z: zahyo)
        
        updateCall()
    }
    
    func updateCall(){
        if(callFlag){
            for j in 0...4{
                light[j].isHidden = false
            }
            callImage.isHidden = true
        }else{
            for j in 0...4{
                light[j].isHidden = true
            }
        }
    }
    
    func bottonUpdate(){
        
        self.view.backgroundColor = UIColor.black
        
        let tema = UIColor(red:1.0,green:1.0,blue:1.0,alpha:0.1)
        //let callColor = UIColor(red:1.0/255.0,green:162.0/255.0,blue:255.0/255.0,alpha:1.0)
        
        Footer.text = ""
        Footer.backgroundColor = tema
        hiHeader.text = ""
        hiHeader.backgroundColor = tema
        colorHeader.text = ""
        colorHeader.backgroundColor = tema
        
        Header.text = "→から選曲！"
        Header.textAlignment = NSTextAlignment.center
        Header.textColor = UIColor(red:1.0/255.0,green:162.0/255.0,blue:255.0/255.0,alpha:1.0)
        Header.font = UIFont.boldSystemFont(ofSize: 20)
        
        let CallImage = UIImage(named: "forCall7.001.png")
        callImage.image = CallImage
        callImage.isHidden = false
        
        let playImage = UIImage(named: "call.001.png") // hogeImageという名前の画像
        Play.setBackgroundImage(playImage, for: .normal) // 背景に画像をset
        
        let pauseImage = UIImage(named: "call.002.png")
        Pause.setBackgroundImage(pauseImage, for: .normal)
        
        let pickImage = UIImage(named: "call.005.png")
        pick.setBackgroundImage(pickImage, for: .normal)
      
        let voice = UIImage(named: "voice.png")
        selectVoice.setBackgroundImage(voice, for: .normal)
        
    }
    
    func callUpdate(){
        let callBImage = UIImage(named: "forCall4.007.png") // hogeImageという名前の画像
        Call.setBackgroundImage(callBImage, for: .normal) // 背景に画像をset
    }
  
  //Jsonのあれこれをここでやろう
  func pushJson() {
    
    callDic[mTitle] = musicTime
    //print(callDic)
    
    //print(musicTime)
    
    let urlString = "http://maki.nkmr.io/Caaalll/Caaalll.php"
    let request = NSMutableURLRequest(url: URL(string: urlString)!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do{
      request.httpBody = try JSONSerialization.data(withJSONObject: callDic, options: .prettyPrinted)
      
      let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) -> Void in
        if((data) != nil){
          let resultData = String(data: data!, encoding: .utf8)!
          print("result:\(resultData)")
        }else {
          
        }
      })
      task.resume()
    }catch{
      print("Error:\(error)")
      return
    }
    musicTime = [String]()
  }
  
  @IBAction func pushDown(_ sender: UIButton) {
    let postTitle = "title=\(mTitle)"
    var request = URLRequest(url: URL(string: "http://maki.nkmr.io/Caaalll/dlCaaalll.php")!)
    request.httpMethod = "POST"
    request.httpBody = postTitle.data(using: .utf8)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data, let response = response {
        print(response)
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
          print(json)
        } catch {
          print("Serialize Error")
        }
      } else {
        print(error ?? "Error")
      }
    }
    task.resume()
    
    //print(dlTiming.count)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    timer.fire()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    timer.invalidate()
  }
  
  func update(tm: Timer) {
    
    //次はここをなんとか解決する
    if(dlTiming.count != 0){
      if let _player = player {
        let time = String( format:"%.2f",_player.currentPlaybackTime)
        for i in dlTiming{
          if(time == i){
            if(self.oo){
              self.MooPlayer.play()
              self.RooPlayer.play()
            }
          }
        }
      }
    }
    
    
  }
}


