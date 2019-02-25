//
//  DZAutoTextView.swift
//  DZLabel
//
//  Created by Darren Zheng on 2019/2/25.
//

import UIKit

//open class DZAutoTextView: UITextView {
//    override open func layoutSubviews() {
//        super.layoutSubviews()
//
//        if __CGSizeEqualToSize(bounds.size, intrinsicContentSize) {
//            invalidateIntrinsicContentSize()
//        }
//    }
//
//    override open var intrinsicContentSize: CGSize {
//        get {
//            var size = contentSize
//            size.width += (textContainerInset.left + textContainerInset.right ) / 2.0
//            size.height += (textContainerInset.top + textContainerInset.bottom) / 2.0
//            return size
//        }
//    }
//
//}
//open class DZAutoTextView: UITextView {
//    // limit the height of expansion per intrinsicContentSize
//    var maxHeight: CGFloat = 0.0
//    private let placeholderTextView: UITextView = {
//        let tv = UITextView()
//
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.backgroundColor = .clear
//        tv.isScrollEnabled = false
////        tv.textColor = .disabledTextColor
//        tv.isUserInteractionEnabled = false
//        return tv
//    }()
//    var placeholder: String? {
//        get {
//            return placeholderTextView.text
//        }
//        set {
//            placeholderTextView.text = newValue
//        }
//    }
//
//    override init(frame: CGRect, textContainer: NSTextContainer?) {
//        super.init(frame: frame, textContainer: textContainer)
//        isScrollEnabled = false
//        autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        NotificationCenter.default.addObserver(self, selector: #selector(UITextInputDelegate.textDidChange(_:)), name: Notification.Name.UITextViewTextDidChange, object: self)
//        placeholderTextView.font = font
//        addSubview(placeholderTextView)
//
//        if #available(iOS 9.0, *) {
//            NSLayoutConstraint.activate([
//                placeholderTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
//                placeholderTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
//                placeholderTextView.topAnchor.constraint(equalTo: topAnchor),
//                placeholderTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
//                ])
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override open var text: String! {
//        didSet {
//            invalidateIntrinsicContentSize()
//            placeholderTextView.isHidden = !text.isEmpty
//        }
//    }
//
//    override open var font: UIFont? {
//        didSet {
//            placeholderTextView.font = font
//            invalidateIntrinsicContentSize()
//        }
//    }
//
//    override open var contentInset: UIEdgeInsets {
//        didSet {
//            placeholderTextView.contentInset = contentInset
//        }
//    }
//
//    override open var intrinsicContentSize: CGSize {
//        var size = super.intrinsicContentSize
//
//        if size.height == UIViewNoIntrinsicMetric {
//            // force layout
//            layoutManager.glyphRange(for: textContainer)
//            size.height = layoutManager.usedRect(for: textContainer).height + textContainerInset.top + textContainerInset.bottom
//        }
//
//        if maxHeight > 0.0 && size.height > maxHeight {
//            size.height = maxHeight
//
//            if !isScrollEnabled {
//                isScrollEnabled = true
//            }
//        } else if isScrollEnabled {
//            isScrollEnabled = false
//        }
//
//        return size
//    }
//
//    @objc private func textDidChange(_ note: Notification) {
//        // needed incase isScrollEnabled is set to true which stops automatically calling invalidateIntrinsicContentSize()
//        invalidateIntrinsicContentSize()
//        placeholderTextView.isHidden = !text.isEmpty
//    }
//}
