//
//  SuperDetailFormViewController.swift
//  btown-rides-riders
//
//  Created by Daniel Jones on 2/4/18.
//  Copyright © 2018 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class BaseFormViewController<Value>: UIViewController {
    let tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    lazy var former: Former = Former(tableView: self.tableView)
    
    var currentValue: Value?
    var valueUpdated: ((Value) -> ())?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(currentValue: Value?, valueUpdated: ((Value) -> Void)?) {
        self.currentValue = currentValue
        self.valueUpdated = valueUpdated
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
    }
    
    func tableViewSetup() {
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
    }
}

//MARK: Former Helpers
extension BaseFormViewController {
    func append(rows: RowFormer..., headerTitle: String) -> SectionFormer? {
        let header = LabelViewFormer<FormLabelHeaderView>()
        header.text = headerTitle
        let section = SectionFormer(rowFormers: rows)
            .set(headerViewFormer: header)
        former.append(sectionFormer: section)
        return section
    }
    
    func append(row: RowFormer, headerTitle: String, footerDescription: String) {
        let header = LabelViewFormer<FormLabelHeaderView>()
        header.text = headerTitle
        
        let footer = LabelViewFormer<FormLabelFooterView>()
        footer.text = footerDescription
        footer.configure { (view) in
            //TODO: make the height based upon the size of the letters, so we can change it without concern. I'm just gauging by eye right now
            view.viewHeight = 120
        }
        
        let section = SectionFormer(rowFormer: row)
        section.set(headerViewFormer: header)
        section.set(footerViewFormer: footer)
        former.append(sectionFormer: section)
    }
    
    func addTappableLabelRow(title: String, onSelected: @escaping () -> Void) {
        let labelRow = LabelRowFormer<FormLabelCell>()
        
        labelRow.configure { (row) in
            row.text = title
        }
        
        labelRow.onSelected { _ in
            onSelected()
        }
        
        _ = append(rows: labelRow, headerTitle: "")
    }
}
