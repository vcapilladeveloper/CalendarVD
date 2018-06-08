//
//  CalendarView.swift
//  NewCalendar
//
//  Created by Victor Capilla Borrego on 23/3/18.
//  Copyright © 2018 Victor Capilla Borrego. All rights reserved.
//

import UIKit

public protocol CalendarDelegate {
    func changeInfoCalendar(_ month: Int, _ year: Int)
    func openCalendarEvent(_ date: String)
}

public struct Colors {
    static var darkGray = #colorLiteral(red: 0.3764705882, green: 0.3647058824, blue: 0.3647058824, alpha: 1)
    static var darkRed = #colorLiteral(red: 0.5019607843, green: 0.1529411765, blue: 0.1764705882, alpha: 1)
    static var continuousTraining = #colorLiteral(red: 0.9921568627, green: 0.5960784314, blue: 0.003921568627, alpha: 1)
    static var instrumentalTraining = #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.003921568627, alpha: 1)
    static var technicalSessions = #colorLiteral(red: 0, green: 0.4980392157, blue: 0.5019607843, alpha: 1)
    static var eventsAtCOAATT = #colorLiteral(red: 0.4862745098, green: 0.7411764706, blue: 0.03921568627, alpha: 1)
    static var intenseDay = #colorLiteral(red: 0.9921568627, green: 0.9921568627, blue: 0.7960784314, alpha: 1)
    static var informationDay = #colorLiteral(red: 0.6823529412, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
    static var socialCulturalEvents = #colorLiteral(red: 0.9921568627, green: 0.4941176471, blue: 0.9254901961, alpha: 1)
    static var enterpriseTraining = #colorLiteral(red: 0, green: 0.4980392157, blue: 0.9960784314, alpha: 1)
    static var holiday = #colorLiteral(red: 0.9921568627, green: 0, blue: 0.003921568627, alpha: 1)
    static var visaDeptClosed = #colorLiteral(red: 0.8039215686, green: 0.5333333333, blue: 0.003921568627, alpha: 1)
    static var visaDeptOpened = #colorLiteral(red: 0.9803921569, green: 0.8666666667, blue: 0.5176470588, alpha: 1)
    static var externalTraining = #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.9960784314, alpha: 1)
    static var lightGreen = #colorLiteral(red: 0.5647058824, green: 0.7764705882, blue: 0.5568627451, alpha: 1)
}

public struct Style {
    static var bgColor = UIColor.black
    static var monthViewLblColor = UIColor.black
    static var monthViewBtnRightColor = UIColor.black
    static var monthViewBtnLeftColor = UIColor.black
    static var activeCellLblColor = UIColor.black
    static var activeCellLblColorHighlighted = UIColor.black
    static var weekdaysLblColor = UIColor.black
    
    public static func themeDark() {
        bgColor = Colors.darkGray
        monthViewLblColor = UIColor.white
        monthViewBtnRightColor = UIColor.white
        monthViewBtnLeftColor = UIColor.white
        activeCellLblColor = UIColor.white
        activeCellLblColorHighlighted = UIColor.black
        weekdaysLblColor = UIColor.white
    }
    
    public static func themeLight() {
        bgColor = UIColor.white
        monthViewLblColor = UIColor.black
        monthViewBtnRightColor = UIColor.black
        monthViewBtnLeftColor = UIColor.black
        activeCellLblColor = UIColor.black
        activeCellLblColorHighlighted = UIColor.white
        weekdaysLblColor = UIColor.black
    }
}

public class CalendarView: UIView {
    
    var currentMonthIndex = 0
    var currentYear = 0
    var presentMonthIndex = 0
    var presentYear = 0
    var todaysDate = 0
    var firstWeekDayOfMonth = 0 //(Sunday-Saturday 1-7)
    var calendarDelegate: CalendarDelegate?
    var itemsToCalendar: [CalendarItemModel]?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    public convenience init(theme: MyTheme, _ items: [CalendarItemModel]) {
        self.init()
        itemsToCalendar = items
        initializeView()
    }
    
    public func updateInfo(_ items: [CalendarItemModel]) {
        itemsToCalendar = items
        firstWeekDayOfMonth=getFirstWeekDay()
        //presentMonthIndex=currentMonthIndex
        //presentYear=currentYear
        setupViews()
        myCollectionView.reloadData()
    }
    
    public func changeTheme() {
        myCollectionView.reloadData()
        monthView.lblName.textColor = Style.monthViewLblColor
        monthView.btnForward.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
        monthView.btnBack.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
        
        for i in 0..<7 {
            guard let label = weekdaysView.daysStackView.subviews[i] as? UILabel else {
                return
            }
            (label).textColor = Style.weekdaysLblColor
        }
    }
    
    public func initializeView() {
        
        currentMonthIndex = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        todaysDate = Calendar.current.component(.day, from: Date())
        firstWeekDayOfMonth=getFirstWeekDay()
        presentMonthIndex=currentMonthIndex
        presentYear=currentYear
        setupViews()
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.register(DateCVCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    public func setupViews() {
        addSubview(monthView)
        monthView.topAnchor.constraint(equalTo: topAnchor).isActive=true
        monthView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        monthView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        monthView.heightAnchor.constraint(equalToConstant: 35).isActive=true
        monthView.delegate=self
        
        addSubview(weekdaysView)
        weekdaysView.topAnchor.constraint(equalTo: monthView.bottomAnchor).isActive=true
        weekdaysView.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        weekdaysView.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        weekdaysView.heightAnchor.constraint(equalToConstant: 30).isActive=true
        
        addSubview(myCollectionView)
        myCollectionView.topAnchor.constraint(equalTo: weekdaysView.bottomAnchor, constant: 0).isActive=true
        myCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive=true
        myCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive=true
        myCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    let monthView: MonthView = {
        let v=MonthView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let weekdaysView: WeekdaysView = {
        let v=WeekdaysView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let myCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let myCollectionView=UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints=false
        myCollectionView.backgroundColor=UIColor.clear
        myCollectionView.allowsMultipleSelection=false
        return myCollectionView
    }()
    
    public func getFirstWeekDay() -> Int {
        let day = ("\(currentYear)-\(currentMonthIndex)-01".date?.firstDayOfTheMonth.weekday)!
        if Calendar.current.firstWeekday != 1 {
            if day-(Calendar.current.firstWeekday - 1) == 0 {
                 return 7
            } else {
                return day-(Calendar.current.firstWeekday - 1)
            }
        } else {
            return day
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CalendarView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DateCVCell {
            cell.backgroundColor=Colors.darkRed
            if let lbl = cell.subviews[1] as? UILabel {
                lbl.textColor=UIColor.white
            }
            calendarDelegate?.openCalendarEvent(cell.date)
            
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor=UIColor.clear
        if let lbl = cell?.subviews[1] as? UILabel {
         lbl.textColor = Style.activeCellLblColor
        }
    }
}

extension CalendarView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return getNumberOfDaysInMonth(currentMonthIndex-1, currentYear) + firstWeekDayOfMonth - 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DateCVCell {
        cell.backgroundColor=UIColor.clear
        if indexPath.item <= firstWeekDayOfMonth - 2 {
            cell.isHidden=true
        } else {
            let calcDate = indexPath.row-firstWeekDayOfMonth+2
            cell.isHidden=false
            cell.lbl.text="\(calcDate)"
            let day = (calcDate > 0 && calcDate < 10) ? "0\(calcDate)" : "\(calcDate)"
            let month = (currentMonthIndex > 0 && currentMonthIndex < 10) ? "0\(currentMonthIndex)" : "\(currentMonthIndex)"
            cell.date = "\(day)-\(month)-\(currentYear)"
            if let items = itemsToCalendar, items.filter({$0.date == "\(day)-\(month)-\(currentYear)"}).count > 0 {
                if let type = items.filter({$0.date == "\(day)-\(month)-\(currentYear)"}).first?.state_id {
                        cell.lbl.backgroundColor = getBackgroundColor(type)
                } else {
                    cell.lbl.backgroundColor = .white
                }
            }
            
            if calcDate < todaysDate && currentYear == presentYear && currentMonthIndex == presentMonthIndex {
                cell.isUserInteractionEnabled=true
                cell.lbl.textColor = UIColor.lightGray
            } else {
                cell.isUserInteractionEnabled=true
                cell.lbl.textColor = Style.activeCellLblColor
            }
        }
        return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func getBackgroundColor(_ state: Int) -> UIColor {
        switch state {
        case 7:
            return Colors.continuousTraining
        case 8:
            return Colors.instrumentalTraining
        case 9:
            return Colors.technicalSessions
        case 10:
            return Colors.eventsAtCOAATT
        case 11:
            return Colors.intenseDay
        case 12:
            return Colors.informationDay
        case 13:
            return Colors.socialCulturalEvents
        case 14:
            return Colors.enterpriseTraining
        case 15:
            return Colors.holiday
        case 16:
            return Colors.visaDeptClosed
        case 17:
            return Colors.visaDeptOpened
        case 18:
            return Colors.externalTraining
        default:
            return Colors.lightGreen
        }
    }
    
}

class DateCVCell: UICollectionViewCell {
    var date = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor.clear
        
        setupViews()
    }
    
    func setupViews() {
        addSubview(lbl)
        lbl.topAnchor.constraint(equalTo: topAnchor).isActive=true
        lbl.leftAnchor.constraint(equalTo: leftAnchor).isActive=true
        lbl.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        lbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive=true
    }
    
    let lbl: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font=UIFont.systemFont(ofSize: 16)
        label.textColor=Colors.darkGray
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//get first day of the month
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
}

//get date from string
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}

extension CalendarView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7 - 8
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

extension CalendarView: MonthViewDelegate {
    public func didChangeMonth(_ monthIndex: Int, _ year: Int) {
        currentMonthIndex=monthIndex+1
        currentYear = year
        firstWeekDayOfMonth=getFirstWeekDay()
        monthView.btnBack.isEnabled = !(currentMonthIndex == presentMonthIndex && currentYear == presentYear)
        calendarDelegate?.changeInfoCalendar(monthIndex + 1, year)
    }
}
