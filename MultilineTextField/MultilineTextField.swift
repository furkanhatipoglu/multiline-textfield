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
    
    public var textView: GrowingTextView!
    public var endEditingWithReturnButton = false
    
    public var placeHolderText: String? {
        didSet {
            updatePlaceHolder()
        }
    }
    public var placeHolderTextColor: UIColor! = UIColor.darkGray {
        didSet {
            updateTextColor()
        }
    }
    public var lineColorUnselected: UIColor! = UIColor.darkGray {
        didSet {
            self.lineLayer.backgroundColor = lineColorUnselected.cgColor
        }
    }
    
    public var lineColorSelected: UIColor! = UIColor.darkGray
    
    
    public var textColor: UIColor! = UIColor.darkGray {
        didSet {
            textView.textColor = textColor
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
        textView.placeHolder = placeHolderText
    }
    
    private func updateTextColor () {
        titleLabel.textColor = placeHolderTextColor
        textView.placeHolderColor = placeHolderTextColor
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
        textView = GrowingTextView(frame: textFieldFrame)
        textView.placeHolderColor = UIColor.darkGray
        textView.delegate = self
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.clear
        textView.placeHolderLeftMargin = 0
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(textView)
        
    }
    
    private func setLineLayer () {
        lineLayer = CALayer()
        lineLayer.frame = CGRect(x: 0, y: textView.frame.maxY + 2, width: textView.bounds.width, height: 0.5)
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
            self.lineLayer.backgroundColor = self.lineColorSelected.cgColor
            self.titleLabel.alpha = 1
            self.textView.placeHolderColor = self.placeHolderTextColor.withAlphaComponent(0)
        }
    }
    
    private func setTextIsNill () {
        UIView.animate(withDuration: 0.5) {
            self.lineLayer.frame = CGRect(x: 0, y: self.lineLayer.frame.minY, width: self.lineLayer.bounds.width, height: 0.5)
            self.lineLayer.backgroundColor = self.lineColorUnselected.cgColor
            self.titleLabel.alpha = 0
            self.textView.placeHolderColor = self.placeHolderTextColor
        }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"  && endEditingWithReturnButton {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension MultilineTextField {
    func getText() -> String {
        if let text = self.textView.text {
            return text
        }
        return ""
    }
}
