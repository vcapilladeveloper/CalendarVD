//
//  CalendarViewController.swift
//  iCOAATT
//
//  Created by Victor Capilla Borrego on 26/3/18.
//  Copyright © 2018 Victor Developer. All rights reserved.
//

import Foundation
import UIKit
import EventKit

final class CalendarViewController: UIView {
    /*
    @IBOutlet weak var tableView: UITableView!
    
    var calendarManager = CalendarManager()
    var planning = [CalendarItemModel]()
    var sectionsByDay = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pleaseWait()
        tableView.dataSource = self
        tableView.delegate = self
        calendarManager.calendarManagerDelegate = self
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
        let month = Calendar.current.component(.month, from: Date())
        let year = Calendar.current.component(.year, from: Date())
        calendarManager.getPlannings(month, year)
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "navigationBackground"), for: .default)
        
    }
    
}

extension CalendarViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsByDay.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return planning.filter({$0.date == sectionsByDay[section - 1]}).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
         
            if let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell", for: indexPath) as? CalendarCell {
            if let calendar = cell.subviews.filter({$0.tag == 847}).first as? CalendarView {
                calendar.updateInfo(planning)
            } else {
                cell.setCalendar(planning)
                cell.calendarView?.calendarDelegate = self
                cell.calendarView?.tag = 847
            }
                return cell
                
            } else {
                return UITableViewCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "calendarItemCell", for: indexPath) as? CalendarItemCell {
            cell.planningTitle = planning.filter({$0.date == sectionsByDay[indexPath.section - 1]})[indexPath.row].state //  planning[indexPath.row].state
            cell.planningContent = planning.filter({$0.date == sectionsByDay[indexPath.section - 1]})[indexPath.row].desc //planning[indexPath.row].desc
            cell.defineButtonToAddCalendarEvent(sectionsByDay[indexPath.section - 1])
            cell.calendarItemDelegate = self
            return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}

extension CalendarViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "headerPlanings") as? HeaderPlaningsCell {
                cell.titleDate = sectionsByDay[section-1]
                return cell
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0
        } else {
            return 55.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section != 0 {
            let link = planning.filter({$0.date == sectionsByDay[indexPath.section - 1]})[indexPath.row].link
            UIApplication.shared.openURL(URL(string: link)!)
        }
    }
    
}

extension CalendarViewController: CalendarItemDelegate {
    func saveInCalendar(_ title: String, _ date: Date, _ content: String) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = date
                event.endDate = date
                event.notes = content
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    print(e.localizedDescription)
                    return
                }
            } else {
                CustomAlertView(title: "Error", message: error?.localizedDescription ?? "No se han encontrado eventos").show(animated: true)
            }
        })
    }
}

extension CalendarViewController: CalendarDelegate {
    func changeInfoCalendar(_ month: Int, _ year: Int) {
        pleaseWait()
        calendarManager.getPlannings(month, year)
    }
    
    func openCalendarEvent(_ date: String) {
        if let link = planning.filter({$0.date == date}).first?.link {
            UIApplication.shared.openURL(URL(string: link)!)
        }
    }
}

extension CalendarViewController: CalendarManagerDelegate {
    func calendarDownloaded(_ plannings: [CalendarItemModel]) {
        self.planning = plannings
        DispatchQueue.main.async {
            var set = Set<String>()
            for p in plannings {
                set.insert(p.date)
            }
            
            self.sectionsByDay = set.sorted()
            self.tableView.reloadData()
            self.clearAllNotice()
        }
    }*/
}
