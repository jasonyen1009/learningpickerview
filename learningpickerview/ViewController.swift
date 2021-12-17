//
//  ViewController.swift
//  learningpickerview
//
//  Created by Hong Cheng Yen on 2021/12/13.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var PickerView: UIPickerView!
    
    
    
    let cityanddistarray = [
        CityandDist(city: "台北市", dist: ["松山區", "大安區", "士林區", "信義區"]),
        CityandDist(city: "新北市", dist: ["林口區", "新莊區", "三重區", "中和區", "永和區"]),
        CityandDist(city: "高雄市", dist: ["楠梓區", "左營區", "鼓山區", "三民區", "鹽埕區", "前金區", "新興區", "苓雅區", "前鎮區", "小港區", "旗津區", "鳳山區", "大寮區", "鳥松區", "林園區", "仁武區", "大樹區", "大社區", "岡山區", "路竹區", "橋頭區", "梓官區", "彌陀區", "永安區"])
    ]
    
    //決定pickerview 區域數量
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    //決定pickerview 區域行數
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return cityanddistarray.count
        }else {
            let selectcity = pickerView.selectedRow(inComponent: 0)
            return cityanddistarray[selectcity].dist.count
        }
    }
    //決定pickerview 區域的每筆資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.isScrolling() {
                pickerView.isUserInteractionEnabled = false
        } else {
                pickerView.isUserInteractionEnabled = true
        }
        if component == 0 {
            return cityanddistarray[row].city
        }else {
            let selectcity = pickerView.selectedRow(inComponent: 0)
            return cityanddistarray[selectcity].dist[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.isUserInteractionEnabled = true
        if component == 0 {
            pickerView.reloadComponent(1)
            //讓每個地區回到第一列
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }
        let selectcity = pickerView.selectedRow(inComponent: 0)
        let selectdist = pickerView.selectedRow(inComponent: 1)
        let city = cityanddistarray[selectcity].city
        let dist = cityanddistarray[selectcity].dist[selectdist]

        print("city: \(city)")
        print("dist: \(dist)")
        cityLabel.text = city
        distLabel.text = dist
        
        
           
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tee(_ sender: Any) {
    }
}

//判斷手反在捲動
extension UIView {
    func isScrolling () -> Bool {

        if let scrollView = self as? UIScrollView {
            if (scrollView.isDragging || scrollView.isDecelerating) {
                return true
            }
        }
        for subview in self.subviews {
            if subview.isScrolling() {
                return true
            }
        }
        return false
    }
}
