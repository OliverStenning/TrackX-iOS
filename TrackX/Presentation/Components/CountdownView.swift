//
//  CountdownView.swift
//  TrackX
//
//  Created by Oliver Stenning on 13/08/2022.
//

import UIKit

class CountdownView: UIView {
    
    //MARK: - Views
    private let digitStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    private let firstDigit = CountdownNumberView()
    private let secondDigit = CountdownNumberView()
    private let thirdDigit = CountdownNumberView()
    private let fourthDigit = CountdownNumberView()
    
    private let separator: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.font = R.font.archivoBold(size: 24)
        label.textColor = R.color.secondaryTextColor()
        return label
    }()
    
    private let firstUnit: UILabel = {
        let label = UILabel()
        label.font = R.font.archivoBold(size: 13)
        label.textColor = R.color.secondaryTextColor()
        label.isHidden = true
        return label
    }()
    
    private let secondUnit: UILabel = {
        let label = UILabel()
        label.font = R.font.archivoBold(size: 13)
        label.textColor = R.color.secondaryTextColor()
        label.isHidden = true
        return label
    }()
    
    private let topPadding = UIView()
    private let bottomPadding = UIView()
    
    //MARK: - Properties
    var launchDate: Date? {
        didSet {
            configureCountdown()
        }
    }
    
    private var years: Int = 0
    private var months: Int = 0
    private var days: Int = 0
    private var hours: Int = 0
    private var minutes: Int = 0
    private var seconds: Int = 0
    
    private var countdownTimer: Timer?
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration Functions
    private func configureViews() {
        addSubview(topPadding)
        addSubview(digitStack)
        addSubview(firstUnit)
        addSubview(secondUnit)
        addSubview(bottomPadding)
        
        digitStack.addArrangedSubview(firstDigit)
        digitStack.addArrangedSubview(secondDigit)
        digitStack.addArrangedSubview(separator)
        digitStack.addArrangedSubview(thirdDigit)
        digitStack.addArrangedSubview(fourthDigit)
    }
    
    private func configureConstraints() {
        // Padding to keep countdown centered in parent
        topPadding.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            trailing: self.trailingAnchor
        )
        topPadding.anchorHeight(to: bottomPadding)
//        topPadding.anchorSize(height: 0)
        
        bottomPadding.anchor(
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor
        )
        
        digitStack.anchor(
            top: topPadding.bottomAnchor,
            leading: self.leadingAnchor,
            trailing: self.trailingAnchor
        )
        
        firstUnit.anchor(
            top: digitStack.bottomAnchor,
            leading: digitStack.leadingAnchor,
            bottom: bottomPadding.topAnchor,
            padding: .init(top: 4, left: 0, bottom: 0, right: 0)
        )
        
        secondUnit.anchor(
            top: digitStack.bottomAnchor,
//            leading: thirdDigit.leadingAnchor,
            bottom: bottomPadding.topAnchor,
            trailing: fourthDigit.trailingAnchor,
            padding: .init(top: 4, left: 0, bottom: 0, right: 0)
        )
    }
    
    private func configureCountdown() {
        countdownTimer = Timer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        
        if let countdownTimer = countdownTimer {
            RunLoop.main.add(countdownTimer, forMode: RunLoop.Mode.common)
        }
    }
    
    //MARK: - Update Functions
    private func updateTimeFromDate() {
        
        guard let launchDate = launchDate else {
            years = 0
            days = 0
            hours = 0
            minutes = 0
            seconds = 0
            return
        }
        
        let timeDifference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date(), to: launchDate)
        
        years = timeDifference.year ?? 0
        months = timeDifference.month ?? 0
        days = timeDifference.day ?? 0
        hours = timeDifference.hour ?? 0
        minutes = timeDifference.minute ?? 0
        seconds = timeDifference.second ?? 0
    }
    
    @objc private func updateCountdown() {
        updateTimeFromDate()
        
        var firstOutput: String
        var secondOutput: String
        
        firstDigit.numberLabel.textColor = R.color.textColor()
        secondDigit.numberLabel.textColor = R.color.textColor()
        thirdDigit.numberLabel.textColor = R.color.textColor()
        fourthDigit.numberLabel.textColor = R.color.textColor()
        
        firstUnit.isHidden = false
        secondUnit.isHidden = false
        
        let formatString = "%02d"

        enum TimeString: String {
            case years = "Years"
            case months = "Months"
            case days = "Days"
            case hours = "Hours"
            case minutes = "Minutes"
            case seconds = "Seconds"
        }
        
        if years > 0 {
            firstUnit.text = TimeString.years.rawValue
            secondUnit.text = TimeString.months.rawValue
            firstOutput = String(format: formatString, years)
            secondOutput = String(format: formatString, months)
        } else if months > 0 {
            firstUnit.text = TimeString.months.rawValue
            secondUnit.text = TimeString.days.rawValue
            firstOutput = String(format: formatString, months)
            secondOutput = String(format: formatString, days)
        } else if days > 0 {
            firstUnit.text = TimeString.days.rawValue
            secondUnit.text = TimeString.hours.rawValue
            firstOutput = String(format: formatString, days)
            secondOutput = String(format: formatString, hours)
        } else if hours > 0 {
            firstUnit.text = TimeString.hours.rawValue
            secondUnit.text = TimeString.minutes.rawValue
            firstOutput = String(format: formatString, hours)
            secondOutput = String(format: formatString, minutes)
        } else if minutes > 0 {
            firstUnit.text = TimeString.minutes.rawValue
            secondUnit.text =  TimeString.seconds.rawValue
            firstOutput = String(format: formatString, minutes)
            secondOutput = String(format: formatString, seconds)
        } else if seconds > 0 {
            firstUnit.text = TimeString.minutes.rawValue
            secondUnit.text = TimeString.seconds.rawValue
            firstOutput = String(format: formatString, minutes)
            secondOutput = String(format: formatString, seconds)
            firstDigit.numberLabel.textColor = .systemRed
            secondDigit.numberLabel.textColor = .systemRed
            thirdDigit.numberLabel.textColor = .systemRed
            fourthDigit.numberLabel.textColor = .systemRed
        } else {
            firstUnit.isHidden = true
            secondUnit.isHidden = true
            firstOutput = "--"
            secondOutput = "--"

            countdownTimer?.invalidate()
            countdownTimer = nil
        }
        
        firstDigit.numberLabel.text = firstOutput[0]
        secondDigit.numberLabel.text = firstOutput[1]
        thirdDigit.numberLabel.text = secondOutput[0]
        fourthDigit.numberLabel.text = secondOutput[1]
    }
}
