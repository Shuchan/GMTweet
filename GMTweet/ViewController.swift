//
//  ViewController.swift
//  GMTweet
//
//  Created by Shuchan on 2014/12/08.
//  Copyright (c) 2014年 Shuchan. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    var myComposeView: SLComposeViewController!
    var myTwitterButton1: UIButton!
    var myTwitterButton2: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.greenColor()
        
        //現在時刻の獲得
        let myDate: NSDate = NSDate()
        
        //カレンダーを取得.
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        //取得するコンポーネントを決める.
        let myComponents = myCalendar.components(NSCalendarUnit.CalendarUnitYear   |
            NSCalendarUnit.CalendarUnitMonth  |
            NSCalendarUnit.CalendarUnitDay    |
            NSCalendarUnit.CalendarUnitHour   |
            NSCalendarUnit.CalendarUnitMinute |
            NSCalendarUnit.CalendarUnitSecond |
            NSCalendarUnit.CalendarUnitWeekday,
            fromDate: myDate)
        
        let weekdayStrings: Array = ["nil", "日", "月", "火", "水", "木", "金", "土", "日"]
        
        //現在時間表示用ラベル
        let TimeLabel: UILabel = UILabel()
        TimeLabel.font = UIFont(name: "HiraKakuInterface-W1", size: UIFont.labelFontSize())
        
        var myStr: String = "\(myComponents.year)年"
        myStr += "\(myComponents.month)月"
        myStr += "\(myComponents.day)日["
        myStr += "\(weekdayStrings[myComponents.weekday])]"
        myStr += "\(myComponents.hour)時"
        myStr += "\(myComponents.minute)分"
        myStr += "\(myComponents.second)秒"
        
        TimeLabel.text = myStr
        TimeLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 50, height: 20)
        TimeLabel.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 + 30)
        TimeLabel.textAlignment = NSTextAlignment.Center
        TimeLabel.backgroundColor = UIColor.blackColor()
        TimeLabel.textColor = UIColor.whiteColor()
        
        
        let BackLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width - 50, self.view.frame.height - 50))
        BackLabel.backgroundColor = UIColor.blackColor()
        BackLabel.layer.masksToBounds = false
        BackLabel.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        BackLabel.textColor = UIColor.whiteColor()
        BackLabel.shadowColor = UIColor.grayColor()
        BackLabel.textAlignment = NSTextAlignment.Center
        //上の時刻次第で機嫌を変えてみる
        if (myComponents.month) < 5{
            BackLabel.text = "まだ寝て低ていい時間帯"
        } else {
            BackLabel.text = "ちゃんと早寝早起きしなさい"
        }
        
        let myTitleLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width - 100, 50))
        myTitleLabel.backgroundColor = UIColor.cyanColor()
        myTitleLabel.layer.masksToBounds = false
        myTitleLabel.layer.position = CGPoint(x: self.view.frame.width/2, y: 60)
        myTitleLabel.textAlignment = NSTextAlignment.Center
        myTitleLabel.textColor = UIColor.blackColor()
        myTitleLabel.font = UIFont.systemFontOfSize(CGFloat(20))
        myTitleLabel.text = "毎日の挨拶ツイート"
        
        //Twitter用ボタン
        let hex: Int = 0x55ACEE
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        var myColor: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(1.0))
        
        myTwitterButton1 = UIButton()
        myTwitterButton1.frame = CGRectMake(0, 0, 200, 100)
        myTwitterButton1.backgroundColor = myColor
        myTwitterButton1.layer.masksToBounds = true
        myTwitterButton1.setTitle("おはよう世界", forState: UIControlState.Normal)
        myTwitterButton1.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(20))
        myTwitterButton1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myTwitterButton1.layer.cornerRadius = 25.0
        myTwitterButton1.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 - 150)
        myTwitterButton1.tag = 1
        myTwitterButton1.addTarget(self, action: "onPostToTwitter:", forControlEvents: UIControlEvents.TouchUpInside)
        
        myTwitterButton2 = UIButton()
        myTwitterButton2.frame = CGRectMake(0, 0, 200, 100)
        myTwitterButton2.backgroundColor = UIColor.orangeColor()
        myTwitterButton2.layer.masksToBounds = true
        myTwitterButton2.setTitle("おやすみ世界", forState: UIControlState.Normal)
        myTwitterButton2.titleLabel?.font = UIFont.systemFontOfSize(CGFloat(20))
        myTwitterButton2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myTwitterButton2.layer.cornerRadius = 25.0
        myTwitterButton2.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 + 150)
        myTwitterButton2.tag = 2
        myTwitterButton2.addTarget(self, action: "onPostToTwitter:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //ボタンをViewに追加
        self.view.addSubview(BackLabel)
        self.view.addSubview(myTitleLabel)
        self.view.addSubview(myTwitterButton1)
        self.view.addSubview(myTwitterButton2)
        self.view.addSubview(TimeLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onPostToTwitter(sender: AnyObject){
        //SLComposeViewControllerのインスタンス化
        //ServiceTypeをTwitterに指定
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        //投稿するテキストを指定
        if sender.tag == 1 {
            myComposeView.setInitialText("おはよう世界")
        } else if sender.tag == 2 {
            myComposeView.setInitialText("おやすみ世界")
        }
        
        //投稿する画像を指定
        //myComposeView.addImage(UIImage(named: "oouchi.jpg"))
        
        //myComposeViewの画面遷移
        self.presentViewController(myComposeView, animated: true, completion: nil)
    }
    
}

