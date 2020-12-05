//
//  ViewController.swift
//  stacking
//
//  Created by Salah Amassi on 05/12/2020.
//

typealias Item = (quantity: Int, name: String, price: Double, addtions: [Addtion]?)
typealias Addtion = (name: String, price: Double)

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contentStackView: UIStackView!
    
    private let addtions: [Addtion] = [
        Addtion("100% halal beef piece", 9.0),
        Addtion("lettuce", 1.0),
        Addtion("100% halal beef piece", 9.0),
        Addtion("100% halal beef piece 100% halal beef ", 9.0),
        Addtion("Pickle", 1.0)]
    
    private lazy var items: [Item] = [
        Item(1, "Big Bik Haraq Big Bik Haraq Big Bik Haraq, 100% halal beef piece , 100% halal beef piece", 11.5, addtions),
        Item(1, "Pulled meal", 14.0, nil),
        Item(3, "Cocktail sauce", 3.75, nil),
        Item(1, "Pulled meal", 14.0, nil),
        Item(3, "Cocktail sauce", 3.75, nil),
        Item(1, "Big Bik Haraq", 11.5, addtions),
        Item(1, "Pulled meal", 14.0, nil),
        Item(3, "Cocktail sauce", 3.75, nil),
        Item(1, "Pulled meal", 14.0, nil),
        Item(1, "Big Bik Haraq", 11.5, addtions),
        Item(3, "Cocktail sauce", 3.75, nil),
        Item(1, "Pulled meal", 14.0, nil),
        Item(3, "Cocktail sauce", 3.75, nil),
        Item(1, "Pulled meal", 14.0, nil),
        Item(3, "Cocktail sauce", 3.75, nil),
        Item(1, "Big Bik Haraq", 11.5, addtions),
        Item(2, "Ice cream with chocolate flavor", 4.0, nil)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // items stack view
        let itemsStack = createItemsStackView(items)
        contentStackView.addArrangedSubview(itemsStack)
        
        
        // footer stack view
        let footer = createFooterStackView()
        footer.ordersubtotalValueLabel.text = "33.25 SAR"
        footer.orderDeliveryValueLabel.text = "3.00 SAR"
        footer.orderTotalValueLabel.text = "36.25 SAR"
        contentStackView.addArrangedSubview(footer.stack)

    }
    
    private func createItemsStackView(_ items: [Item])-> UIStackView{
        let itemsStackView = UIStackView()
        itemsStackView.axis = .vertical
        itemsStackView.spacing = 15
        itemsStackView.layoutMargins = .init(top: 15, left: 15, bottom: 15, right: 15)
        itemsStackView.isLayoutMarginsRelativeArrangement = true
        
        for item in items{
            let itemStackView = createItemStackView(for: item)
            itemsStackView.addArrangedSubview(itemStackView.drawDebugingBorder(with: .red))
        }
        return itemsStackView
    }
    
    private func createItemStackView(for item: Item) -> UIStackView{
        let quantityLabel = UILabel()
        let nameLabel = UILabel()
        let priceLabel = UILabel()
        
        quantityLabel.text = "x \(item.quantity)"
        nameLabel.text = item.name
        priceLabel.text = "\(item.price) SAR"

        
        nameLabel.textColor = .gray
        nameLabel.numberOfLines = 0

        quantityLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.init(751), for: .horizontal)
        nameLabel.setContentHuggingPriority(.init(249), for: .horizontal)
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel])
        nameStackView.axis = .vertical
        
        let hstack = UIStackView(arrangedSubviews: [quantityLabel, nameStackView, priceLabel])
        hstack.axis = .horizontal
        hstack.alignment = .top
        
        hstack.spacing = 8
        if let addtions = item.addtions{
            let addtionsStack = createAddtionsStackView(addtions)
            let vstack = UIStackView(arrangedSubviews: [hstack, addtionsStack])
            vstack.axis = .vertical
            vstack.spacing = 4
            return vstack
        }
        return hstack
    }
    
    private func createAddtionsStackView(_ addtions: [Addtion])-> UIStackView{
        let addtionLabel = UILabel()
        addtionLabel.text = "Addtions"
        let addtionsStack = UIStackView()
        addtionsStack.axis = .vertical
        addtionsStack.spacing = 4
        for addtion in addtions{
            let addtionStack = createAddtionStackView()
            addtionStack.nameLabel.text = addtion.name
            addtionStack.priceLabel.text = "+\(addtion.price) SAR"
            addtionsStack.addArrangedSubview(addtionStack.stack)
        }
        let vstack = UIStackView(arrangedSubviews: [addtionLabel, addtionsStack])
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
    
    private func createFooterStackView() -> (stack: UIStackView, ordersubtotalValueLabel: UILabel, orderDeliveryValueLabel: UILabel, orderTotalValueLabel: UILabel){
        
        // footer line's
        let firstLine = UIView()
        let secondLine = UIView()
        [firstLine, secondLine].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 1).isActive = true
            $0.backgroundColor = .gray
        }
        
        // order subtotal price
        let orderSubtotalLabel = UILabel()
        let orderSubtotalValueLabel = UILabel()
        
        orderSubtotalLabel.text = "Order Total"
        orderSubtotalLabel.textColor = .gray
        orderSubtotalLabel.font = orderSubtotalLabel.font.withSize(22)
        
        orderSubtotalValueLabel.font = orderSubtotalLabel.font.withSize(22)
        orderSubtotalValueLabel.textAlignment = .right
        
        let orderSubtotalStackView = UIStackView(arrangedSubviews: [orderSubtotalLabel, orderSubtotalValueLabel])
        orderSubtotalStackView.axis = .horizontal
        orderSubtotalStackView.distribution = .fillEqually
        
        
        // order delivery price
        let orderDeliveryLabel = UILabel()
        let orderDeliveryValueLabel = UILabel()
        
        orderDeliveryLabel.text = "Order Delivery"
        orderDeliveryLabel.textColor = .gray
        orderDeliveryLabel.font = orderDeliveryLabel.font.withSize(22)
        
        orderDeliveryValueLabel.font = orderDeliveryValueLabel.font.withSize(22)
        orderDeliveryValueLabel.textAlignment = .right

        let orderDeliveryStackView = UIStackView(arrangedSubviews: [orderDeliveryLabel, orderDeliveryValueLabel])
        orderDeliveryStackView.axis = .horizontal
        orderDeliveryStackView.distribution = .fillEqually

        
        // order total price
        let orderTotalLabel = UILabel()
        let orderTotalValueLabel = UILabel()
        
        orderTotalLabel.text = "Total"
        orderTotalLabel.textColor = .red
        orderTotalLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        orderTotalValueLabel.textColor = .red
        orderTotalValueLabel.font = UIFont.boldSystemFont(ofSize: 22)
        orderTotalValueLabel.textAlignment = .right

        let orderTotalStackView = UIStackView(arrangedSubviews: [orderTotalLabel, orderTotalValueLabel])
        orderTotalStackView.axis = .horizontal
        orderTotalStackView.distribution = .fillEqually
        
        
        let footerStackView = UIStackView(arrangedSubviews: [firstLine, orderSubtotalStackView, orderDeliveryStackView, secondLine, orderTotalStackView])
        footerStackView.axis = .vertical
        footerStackView.spacing = 8
        footerStackView.layoutMargins = .init(top: 15, left: 15, bottom: 15, right: 15)
        footerStackView.isLayoutMarginsRelativeArrangement = true
        
        return (footerStackView, orderSubtotalValueLabel, orderDeliveryValueLabel, orderTotalValueLabel)
    }
}

