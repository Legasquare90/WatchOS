//
//  ProgramsInterfaceController.swift
//  HBO
//
//  Created by Jose Angel Cuadrado on 18/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire
import ClockKit

class ProgramsInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    @IBOutlet var loadingLabel: WKInterfaceLabel!
    
    var programs: [[String: String]] = []

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Programación")
        table.setHidden(true)
        loadingLabel.setHidden(false)
        
        Alamofire.request(URL(string: "http://private-a6537-hboupsa.apiary-mock.com/programs")!, method: .get, parameters: nil).responseJSON { (dataResponse) in
            guard dataResponse.result.isSuccess else {
                print("Error while fetching programs: \(dataResponse.result.error)")
                return
            }
            
            guard let programList = dataResponse.result.value as? [[String: String]] else {
                print("Malformed data received")
                return
            }
            
            print(programList)
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(programList, forKey: "ballTypes")
            userDefaults.synchronize()
            
            self.programs = programList
            self.loadingLabel.setHidden(true)
            self.table.setHidden(false)
            
            self.setupTable()
            self.getComplicationData()
            self.refreshComplication()
        }
    }
    
    override func willActivate() {
        super.willActivate()
        updateColorPrograms()
    }
    
    func getComplicationData() {
        var complicationData: [[String:Any]] = []
        for i in 0 ..< programs.count {
            let program = programs[i]
            let title = program["title"]!
            let initDate = program["timeInit"]!
            let finishDate = program["timeFinish"]!
            let timeInit = getDate(dateString: initDate)
            let timeEnd = getDate(dateString: finishDate)

            if (Date().compare(timeEnd!) == .orderedAscending) {
                let programWithDate = ["title": title, "timeInit": timeInit!, "timeEnd": timeEnd!] as [String : Any]
                complicationData.append(programWithDate)
            }
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(complicationData, forKey: "complicationData")
        userDefaults.synchronize()
    }
    
    func updateColorPrograms() {
        for i in 0 ..< programs.count {
            let row = table.rowController(at: i) as! RowProgramController
            let program = programs[i] 
            let initDate = program["timeInit"]!
            let finishDate = program["timeFinish"]!

            if let color = getProgramColor(initDate: initDate, finishDate: finishDate) {
                row.containerView.setBackgroundColor(color)
            }
        }
    }
    
    func setupTable() {
        table.setNumberOfRows(programs.count, withRowType: "RowProgram")
        for i in 0 ..< programs.count {
            let row = table.rowController(at: i) as! RowProgramController
            let program = programs[i] 
            let title = program["title"]! 
            let initDate = program["timeInit"]!
            let finishDate = program["timeFinish"]!
            row.titleLabel.setText(title)
            row.initDateLabel.setText(initDate)
            row.finishDateLabel.setText(finishDate)
            
            if let color = getProgramColor(initDate: initDate, finishDate: finishDate) {
                row.containerView.setBackgroundColor(color)
            }
        }
    }
    
    func getDate(dateString: String) -> Date? {
        let now = Date()
        let gregorian = Calendar(identifier: .gregorian)
        let units: Set<Calendar.Component> = [.second, .minute, .hour, .day, .month, .year]
        var components = gregorian.dateComponents(units, from: now)
        
        let componentsInitDate = dateString.components(separatedBy: ":")
        components.minute = Int(componentsInitDate[1])
        components.hour = Int(componentsInitDate[0])
        return gregorian.date(from: components)
    }
    
    func getProgramColor(initDate: String, finishDate: String) -> UIColor? {
        let now = Date()
        let timeInit = getDate(dateString: initDate)
        let timeEnd = getDate(dateString: finishDate)
        
        if (now.compare(timeEnd!) == .orderedDescending) {
            return UIColor.red
        } else {
            if (now.compare(timeInit!) != .orderedAscending) {
                return UIColor.green
            } else {
                return nil
            }
        }
    }
    
    func refreshComplication() {
        let complicationServer = CLKComplicationServer.sharedInstance()
        for complication in complicationServer.activeComplications! {
            complicationServer.reloadTimeline(for: complication)
        }
    }

}

class RowProgramController: NSObject {

    @IBOutlet var containerView: WKInterfaceGroup!
    @IBOutlet var initDateLabel: WKInterfaceLabel!
    @IBOutlet var finishDateLabel: WKInterfaceLabel!
    @IBOutlet var titleLabel: WKInterfaceLabel!
    
}
