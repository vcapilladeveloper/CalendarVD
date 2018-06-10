//
//  WeekdaysView.swift
//  NewCalendar
//
//  Created by Victor Capilla Borrego on 23/3/18.
//  Copyright © 2018 Victor Capilla Borrego. All rights reserved.
//

import UIKit

public class WeekdaysView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
    }
    
    public func setupViews() {
        addSubview(daysStackView)
        daysStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        daysStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        daysStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        daysStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        var daysArr = getWeekDaysName()
        for i in 0..<7 {
            let lbl = UILabel()
            lbl.text = daysArr[i]
            lbl.textAlignment = .center
            lbl.textColor = Style.weekdaysLblColor
            daysStackView.addArrangedSubview(lbl)
        }
    }
    
    public let daysStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
