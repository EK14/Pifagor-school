//
//  ScheduleNestedCollectionViewCell.swift
//  Pifagor
//
//  Created by Элина Карапетян on 11.12.2023.
//

import UIKit

class ScheduleNestedCollectionViewCell: UICollectionViewCell{
    
    override func prepareForReuse() {
        thelast = false
        layer.cornerRadius = 0
        circle.fillColor = UIColor.white.cgColor
    }
    
    private var subject: InnerView! = nil
    var thelast = false
    var circle = CAShapeLayer()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        return label
    }()
    
    func setCell(index: Int, sub: Schedule){
        subject = InnerView(index: index, subject: sub)
        setupTimeLabel(time: sub.startTime)
        setupBackgroundColor()
        setupSubviewsAndConstraints()
        drawVerticalLine()
        drawCircle()
    }
    
    private func setupTimeLabel(time: Int){
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        let text = NSMutableAttributedString.init(string: "\(time):00\n\(time+1):00")
        text.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)],
                           range: NSMakeRange(0, "\(time):00\n".count-1))
        text.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .thin)], range: NSMakeRange("\(time):00\n".count, "\(time+1):00".count))
        timeLabel.attributedText = text
    }
    
    private func setupBackgroundColor(){
        backgroundColor = UIColor(named: "lightgray")
    }
    
    private func setupSubviewsAndConstraints(){
        if thelast{
            layer.cornerRadius = 40
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        layer.borderColor = UIColor.clear.cgColor
        subject.layer.cornerRadius = 10
        subject.clipsToBounds = true
        subject.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subject)
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            subject.topAnchor.constraint(equalTo: topAnchor, constant: bounds.size.height*0.2),
            subject.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subject.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bounds.size.width*0.3),
            subject.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.size.height*0.2),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(bounds.width - (bounds.width * 0.3 - 15)) - 5)
        ])
    }
    
    func drawVerticalLine(){
        let caLayer = CAShapeLayer()
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: bounds.width * 0.3 - 10, y: 0))
        bezierPath.addLine(to: CGPoint(x: bounds.width * 0.3 - 10, y: bounds.height))
        caLayer.path = bezierPath.cgPath
        caLayer.strokeColor = UIColor.black.cgColor
        caLayer.lineWidth = 2
        layer.addSublayer(caLayer)
    }
    
    func drawCircle(){
        let bezierPath = UIBezierPath(ovalIn: CGRect(x: bounds.width * 0.3 - 15, y: bounds.size.height*0.2 + 3, width: 10, height: 10))
        circle.fillColor = UIColor.white.cgColor
        circle.path = bezierPath.cgPath
        circle.strokeColor = UIColor.black.cgColor
        circle.lineWidth = 2
        layer.addSublayer(circle)
    }
    
}

class InnerView: UIView{
    
    private let cellColors = ["orange", "blue", "purple", "green"]
    private var color = String()
    
    private lazy var subjectNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var teacherNameLabel: UILabel = {
        let teacherName = UILabel()
        teacherName.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        teacherName.translatesAutoresizingMaskIntoConstraints = false
        return teacherName
    }()

    var points: [CGPoint] = [
        .zero,
        CGPoint(x: 0, y: 1),
        CGPoint(x: 0.06, y: 1),
        CGPoint(x: 0.06, y: 0)
        ] { didSet { setNeedsLayout() } }

    private lazy var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        self.layer.insertSublayer(_shapeLayer, at: 0)
        return _shapeLayer
    }()
    
    init(index: Int, subject: Schedule){
        super.init(frame: .zero)
        backgroundColor = .white
        self.color = cellColors[index % 4]
        subjectNameLabel.text = subject.subject
        teacherNameLabel.text = subject.teacher
        setupConstraints()
        teacherNameLabel.addLeading(image: UIImage(systemName: "person"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        shapeLayer.fillColor = UIColor(named: color)?.cgColor

        guard points.count > 2 else {
            shapeLayer.path = nil
            return
        }

        let path = UIBezierPath()

        path.move(to: convert(relativePoint: points[0]))
        for point in points.dropFirst() {
            path.addLine(to: convert(relativePoint: point))
        }
        path.close()

        shapeLayer.path = path.cgPath
    }

    private func convert(relativePoint point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * bounds.width + bounds.origin.x, y: point.y * bounds.height + bounds.origin.y)
    }
    
    private func setupConstraints(){
        addSubview(subjectNameLabel)
        addSubview(teacherNameLabel)
        NSLayoutConstraint.activate([
            subjectNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            subjectNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIScreen.main.bounds.width*0.06),
            subjectNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            teacherNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            teacherNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIScreen.main.bounds.width*0.06),
        ])
    }
}
