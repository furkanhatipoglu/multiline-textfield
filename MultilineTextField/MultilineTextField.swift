//
//  MultilineTextField.swift
//
//
//  Created by Furkan Hatipoglu on 12/12/2017.
//  Copyright © 2017 frknhatipoglu. All rights reserved.
//

import Foundation
import GrowingTextView

public class MultilineTextField: UIView, GrowingTextViewDelegate {
    
    
    private var titleLabel: UILabel!
    private var lineLayer: CALayer!
    var growTextView: GrowingTextView!
    
    public var placeHolderText: String? {
        didSet {
            updatePlaceHolder()
        }
    }
    public var placeHolderTextColor: UIColor! {
        didSet {
            if placeHolderTextColor == nil {
                placeHolderTextColor = UIColor.darkGray
            }
            updateTextColor()
        }
    }
    public var lineColor: UIColor! {
        didSet {
            if lineColor == nil {
                lineColor = UIColor.red
            }
            self.lineLayer.backgroundColor = lineColor.cgColor
        }
    }
    
    public var textColor: UIColor! {
        didSet {
            if textColor == nil {
                textColor = UIColor.black
            }
            growTextView.textColor = textColor
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setComponents()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updatePlaceHolder () {
        titleLabel.text = placeHolderText
        growTextView.placeHolder = placeHolderText
    }
    
    private func updateTextColor () {
        titleLabel.textColor = placeHolderTextColor
        growTextView.placeHolderColor = placeHolderTextColor ?? UIColor.darkGray
    }
    
    private func setComponents () {
        setTitleLabel()
        setTextView()
        setLineLayer()
    }
    
    private func setTitleLabel () {
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 5, y: 0, width: self.bounds.width - 10, height: 20)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.alpha = 0
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(titleLabel)
    }
    
    private func setTextView () {
        
        let textFieldFrame = CGRect(x: 0, y: 20, width: self.bounds.width, height: self.bounds.height - 25)
        growTextView = GrowingTextView(frame: textFieldFrame)
        growTextView.placeHolderColor = UIColor.darkGray
        growTextView.delegate = self
        growTextView.textColor = UIColor.black
        growTextView.backgroundColor = UIColor.clear
        growTextView.placeHolderLeftMargin = 0
        growTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        growTextView.font = UIFont.systemFont(ofSize: 16)
        growTextView.returnKeyType = .done
        self.addSubview(growTextView)
        
    }
    
    private func setLineLayer () {
        lineLayer = CALayer()
        lineLayer.frame = CGRect(x: 0, y: growTextView.frame.maxY + 2, width: growTextView.bounds.width, height: 0.5)
        lineLayer.backgroundColor = UIColor.darkGray.cgColor
        self.layer.addSublayer(lineLayer)
        
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        setTextIsNotNill()
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setTextIsNill()
        } else {
            setTextIsNotNill()
        }
    }
    
    private func setTextIsNotNill () {
        UIView.animate(withDuration: 0.5) {
            self.lineLayer.frame = CGRect(x: 0, y: self.lineLayer.frame.minY, width: self.lineLayer.bounds.width, height: 2)
            self.lineLayer.backgroundColor = UIColor.red.cgColor
            self.titleLabel.alpha = 1
            self.growTextView.placeHolderColor = self.placeHolderTextColor.withAlphaComponent(0)
        }
    }
    
    private func setTextIsNill () {
        UIView.animate(withDuration: 0.5) {
            self.lineLayer.frame = CGRect(x: 0, y: self.lineLayer.frame.minY, width: self.lineLayer.bounds.width, height: 0.5)
            self.lineLayer.backgroundColor = UIColor.darkGray.cgColor
            self.titleLabel.alpha = 0
            self.growTextView.placeHolderColor = self.placeHolderTextColor
        }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension MultilineTextField {
    func getText() -> String {
        if let text = self.growTextView.text {
            return text
        }
        return ""
    }
}
