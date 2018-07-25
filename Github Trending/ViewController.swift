//
//  ViewController.swift
//  Github Trending
//
//  Created by X's Mac on 2018/7/6.
//  Copyright © 2018年 X's Mac. All rights reserved.
//

import UIKit
import PagingMenuController
class message{
    var title: String?
    var url: String?
    var langeuage: String?
    var isfavorite: Bool = false
}
//分页菜单配置
private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    //第1个子视图控制器
    private let viewController1 = allViewController()
    //第2个子视图控制器
    private let viewController2 = C__ViewController()
    private let viewController3 = JavaViewController()
    private let viewController4 = JSViewController()
    private let viewController5 = PythonViewController()
    private let viewController6 = PHPViewController()
    private let viewController7 = HTMLViewController()
    private let viewController8 = RubyViewController()
    private let viewController9 = OtherViewController()
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    //所有子视图控制器
    fileprivate var pagingControllers: [UIViewController] {
        return [viewController1, viewController2,viewController3,viewController4,viewController5,viewController6,viewController7,viewController8,viewController9]
    }
    
    //菜单配置项
    fileprivate struct MenuOptions: MenuViewCustomizable {
        //菜单显示模式
        var displayMode: MenuDisplayMode {
            return .infinite(widthMode: .flexible, scrollingMode: .pagingEnabled)
        }
        //菜单项
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2(),MenuItem3(),MenuItem4(),MenuItem5(),MenuItem6(),MenuItem7(),MenuItem8(),MenuItem9()]
        }
    }
    
    //第1个菜单项
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "All"))
        }
    }
    
    //第2个菜单项
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "C++"))
        }
    }
    fileprivate struct MenuItem3: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Java"))
        }
    }
    fileprivate struct MenuItem4: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "JavaScript"))
        }
    }
    fileprivate struct MenuItem5: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Python"))
        }
    }
    fileprivate struct MenuItem6: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "PHP"))
        }
    }
    fileprivate struct MenuItem7: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Ruby"))
        }
    }
    fileprivate struct MenuItem8: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "HTML"))
        }
    }
    fileprivate struct MenuItem9: MenuItemViewCustomizable {
        //自定义菜单项名称
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: "Other"))
        }
    }
}

//主视图控制器
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //分页菜单配置
        let options = PagingMenuOptions()
        //分页菜单控制器初始化
        let pagingMenuController = PagingMenuController(options: options)
        //分页菜单控制器尺寸设置
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        //建立父子关系
        addChildViewController(pagingMenuController)
        //分页菜单控制器视图添加到当前视图中
        view.addSubview(pagingMenuController.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

