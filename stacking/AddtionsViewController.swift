//
//  AddtionsViewController.swift
//  stacking
//
//  Created by Salah Amassi on 07/12/2020.
//

import UIKit

class AddtionsViewController: UIViewController {
    
    @IBOutlet weak var contentStackView: UIStackView!
    
    private let addtions: [Addtion] = [
        Addtion("100% halal beef piece", 9.0),
        Addtion("lettuce", 1.0),
        Addtion("100% halal beef piece", 9.0),
        Addtion("100% halal beef piece 100% halal beef ", 9.0),
        Addtion("Pickle", 1.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let addtionsStackView = createAddtionsStackView(addtions)
    
        let wrapperView = UIView()
        wrapperView.backgroundColor = .white
        
        wrapperView.addSubview(addtionsStackView)
        wrapperView.applySketchShadow()
        
        addtionsStackView.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        contentStackView.addArrangedSubview(wrapperView)
        
        
        let addtionsStackView1 = createAddtionsStackView(addtions)
    
        let wrapperView1 = UIView()
        wrapperView1.backgroundColor = .white
        
        wrapperView1.addSubview(addtionsStackView1)
        wrapperView1.applySketchShadow()
        
        addtionsStackView1.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        contentStackView.addArrangedSubview(wrapperView1)
        
        contentStackView.spacing = 12

    }
    
    private func createAddtionsStackView(_ addtions: [Addtion])-> UIStackView{
        let addtionLabel = UILabel()
        addtionLabel.text = "Addtions"
        
        let expandDismissButton = UIButton(type: .system)
        expandDismissButton.setTitle("Expand", for: .normal)
        expandDismissButton.setTitleColor(.blue, for: .normal)
        expandDismissButton.setTitleColor(.red, for: .highlighted)
        expandDismissButton.contentHorizontalAlignment = .trailing
        
        expandDismissButton.addTarget(self, action: #selector(performExpandDismissButtonAction(_:)), for: .primaryActionTriggered)
        
        let titleStackView = UIStackView(arrangedSubviews: [addtionLabel, expandDismissButton])
        titleStackView.axis = .horizontal
        titleStackView.distribution = .fillEqually
        
        let addtionsStack = UIStackView()
        addtionsStack.axis = .vertical
        addtionsStack.spacing = 4
        
        for addtion in addtions{
            let addtionStack = createAddtionStackView()
            addtionStack.nameLabel.text = addtion.name
            addtionStack.priceLabel.text = "+\(addtion.price) SAR"
            addtionsStack.addArrangedSubview(addtionStack.stack)
        }
        addtionsStack.isHidden = true
        let vstack = UIStackView(arrangedSubviews: [titleStackView, addtionsStack])
        vstack.layoutMargins = .init(top: 0, left: 15, bottom: 0, right: 15)
        vstack.isLayoutMarginsRelativeArrangement = true
        vstack.axis = .vertical
        vstack.spacing = 8
        return vstack
    }
    
    private func createAddtionStackView() -> (stack: UIStackView, nameLabel: UILabel, priceLabel: UILabel){
        let addtionNameLabel = UILabel()
        let addtionPriceLabel = UILabel()
        
        addtionNameLabel.textColor = .gray
        addtionPriceLabel.textColor = .gray
        addtionNameLabel.numberOfLines = 0
        
        addtionNameLabel.setContentHuggingPriority(.init(249), for: .horizontal)
        addtionPriceLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        
        let addtionNameStackView = UIStackView(arrangedSubviews: [addtionNameLabel])
        addtionNameStackView.axis = .vertical
        
        let addtionStackView = UIStackView(arrangedSubviews: [addtionNameStackView, addtionPriceLabel])
        addtionStackView.axis = .horizontal
        addtionStackView.alignment = .top
        addtionStackView.spacing = 4
        return (addtionStackView, addtionNameLabel, addtionPriceLabel)
    }
    
    
    @objc
    private func performExpandDismissButtonAction(_ sender: UIButton){
        guard let superview = sender.superview?.superview as? UIStackView else { return }
        guard let addtionsStackView = superview.arrangedSubviews.last else { return }
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 1,
                       options: [],
                       animations: {
                        if sender.title(for: .normal) == "Expand"{
                            sender.setTitle("Dismiss", for: .normal)
                            addtionsStackView.isHidden = false
                        }else{
                            sender.setTitle("Expand", for: .normal)
                            addtionsStackView.isHidden = true
                        }
                       },
                       completion: nil)
        
    }
    
}
