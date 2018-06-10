//
//  MonthView.swift
//  NewCalendar
//
//  Created by Victor Capilla Borrego on 23/3/18.
//  Copyright © 2018 Victor Capilla Borrego. All rights reserved.
//

import UIKit

// Porotocol to delegate the funcion of make changes when change the month and year in this view.
protocol MonthViewDelegate {
    func didChangeMonth(_ monthIndex: Int, _ year: Int)
}

// Class to define the most top line in the calender where we set the current month and the current year and put navigation arrow to move arround the months and years
class MonthView: UIView {
    // Months Name Collection
    var monthsName = getMonthsNames()
    
    //Index to save the current Month in the Array of monthsName
    var currentMonthIndex = 0
    
    //Current year of the calendar
    var currentYear = 0
    
    // Delegate reference to send action to the delegate of instance
    var delegate: MonthViewDelegate?
    var bundle: Bundle!
    // Override constructor form inherit UIView constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        bundle = Bundle(for: type(of: self))
        // Make Clear bakcground color
        self.backgroundColor = .clear
        
        // Set the index of the name of the current month
        currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        
        // Set the actual year in currentYear
        currentYear = Calendar.current.component(.year, from: Date())
        
        // Setup the content on the Month View
        setUpViews()
        
        // Set back button disabled to prevent go back to the previous month
        btnBack.isEnabled = false
    }
    
    // Contructor for use in the Storyboard
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Action to go back and forward in month and year. It update the label with the name of the month and the year and tell to the delegate if need to change something with the new month and year
    @objc func backAndfordwardInMonthAction(_ sender: UIButton) {
        print("Change month")
        if sender == btnForward {
            currentMonthIndex += 1
            if currentMonthIndex > 11 {
                currentMonthIndex = 0
                currentYear += 1
            }
        } else {
            currentMonthIndex -= 1
            if currentMonthIndex < 0 {
                currentMonthIndex = 11
                currentYear -= 1
            }
        }
        lblName.text = "\(monthsName[currentMonthIndex]) \(currentYear)"
        delegate?.didChangeMonth(currentMonthIndex, currentYear)
    }
    
    //Set up the back and forward view and the month and year view.
    func setUpViews() {
        self.addSubview(lblName)
        lblName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lblName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lblName.widthAnchor.constraint(equalToConstant: 150).isActive = true
        lblName.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        lblName.text = "\(monthsName[currentMonthIndex]) \(currentYear)"
        
        self.addSubview(btnBack)
        btnBack.layoutIfNeeded()
        btnBack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        btnBack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnBack.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        self.addSubview(btnForward)
        btnForward.layoutIfNeeded()
        btnForward.topAnchor.constraint(equalTo: topAnchor).isActive=true
        btnForward.rightAnchor.constraint(equalTo: rightAnchor).isActive=true
        btnForward.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnForward.heightAnchor.constraint(equalTo: heightAnchor).isActive=true
    }
    
    // Computed constant that defines the month and year
    let lblName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Default month year text"
        lbl.textColor = Style.monthViewLblColor
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // Computed constant that defines the back and forward buttons to move arround de months and years
    let btnForward: UIButton = {
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(named: "forward_arrow", in: Bundle.main, compatibleWith: nil), for: .normal)
        btn.backgroundColor = .clear
        btn.setTitleColor(Style.monthViewBtnRightColor, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(MonthView.backAndfordwardInMonthAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    let btnBack: UIButton = {
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(named: "back_arrow", in: Bundle.main, compatibleWith: nil), for: .normal)
        btn.backgroundColor = .clear
        btn.imageView?.contentMode = .scaleAspectFill
        btn.setTitleColor(Style.monthViewBtnLeftColor, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(MonthView.backAndfordwardInMonthAction(_:)), for: .touchUpInside)
        btn.setTitleColor(.lightGray, for: .disabled)
        return btn
    }()
    
}
