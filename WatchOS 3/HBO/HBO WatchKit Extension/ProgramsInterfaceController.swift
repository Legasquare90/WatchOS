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

class ProgramsInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    var programs: [[String: Any]] = []

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Programación")
            
        Alamofire.request(URL(string: "http://private-a6537-hboupsa.apiary-mock.com/programs")!, method: .get, parameters: nil).responseJSON { (dataResponse) in
            guard dataResponse.result.isSuccess else {
                print("Error while fetching programs: \(dataResponse.result.error)")
                return
            }
            
            guard let programList = dataResponse.result.value as? [[String: Any]] else {
                print("Malformed data received")
                return
            }
            
            print(programList)
            self.programs = programList
            self.setupTable()
        }
    }
    
    override func willActivate() {
        super.willActivate()
        updateColorPrograms()
    }
    
    func updateColorPrograms() {
        for i in 0 ..< programs.count {
            let row = table.rowController(at: i) as! RowProgramController
            let program = programs[i] as! [String:String]
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
            let program = programs[i] as! [String:String]
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
    
    func getProgramColor(initDate: String, finishDate: String) -> UIColor? {
        let now = Date()
        let gregorian = Calendar(identifier: .gregorian)
        let units: Set<Calendar.Component> = [.second, .minute, .hour, .day, .month, .year]
        var components = gregorian.dateComponents(units, from: now)
        
        let componentsInitDate = initDate.components(separatedBy: ":")
        components.minute = Int(componentsInitDate[1])
        components.hour = Int(componentsInitDate[0])
        let timeInit = gregorian.date(from: components)
        
        let componentsFinishDate = finishDate.components(separatedBy: ":")
        components.minute = Int(componentsFinishDate[1])
        components.hour = Int(componentsFinishDate[0])
        let timeEnd = gregorian.date(from: components)
        
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

}

class RowProgramController: NSObject {

    @IBOutlet var containerView: WKInterfaceGroup!
    @IBOutlet var initDateLabel: WKInterfaceLabel!
    @IBOutlet var finishDateLabel: WKInterfaceLabel!
    @IBOutlet var titleLabel: WKInterfaceLabel!
    
}
