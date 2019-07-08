//
//  PersonDetailController.m
//  QIRestorationDemo
//
//  Created by QLY on 2019/6/30.
//  Copyright © 2019 qishare. All rights reserved.
//

#import "PersonDetailController.h"
#import "InfoViewController.h"
static NSString * const selectedStateKey = @"selectedStateKey";

@interface PersonDetailController ()<UIViewControllerRestoration>{
    
    UIButton *button;
}

@property (nonatomic, assign) BOOL selected;

@end

@implementation PersonDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     self.restorationClass Class对象 APP状态恢复的时候负责重新创建当前的控制器 需要实现UIViewControllerRestoration
     */
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"详情";
    //! 设置恢复标识
    self.restorationIdentifier = NSStringFromClass(self.class);
    //! 设置用于恢复的类
//    self.restorationClass = self.class;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 88, self.view.frame.size.width, 20)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.text = @"保存一个button的状态，其余控件与之类似：";
    [self.view addSubview:label];
    
    //保存控件的状态
    button = [[UIButton alloc]initWithFrame:CGRectMake(40, 220, 100, 100)];
    [button  setAttributedTitle:[[NSAttributedString alloc]initWithString:@"正常" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]}] forState:UIControlStateNormal];
    [button  setAttributedTitle:[[NSAttributedString alloc]initWithString:@"选中" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]}] forState:UIControlStateSelected];
    button.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    button.selected = _selected;
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = UIColor.orangeColor.CGColor;
    [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *netxButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, 200, 40)];
    [netxButton  setAttributedTitle:[[NSAttributedString alloc]initWithString:@"去查看列表" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]}] forState:UIControlStateNormal];
    [netxButton  setAttributedTitle:[[NSAttributedString alloc]initWithString:@"去查看列表" attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular]}] forState:UIControlStateSelected];
    netxButton.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    netxButton.layer.borderWidth = 1.0;
    netxButton.layer.borderColor = UIColor.grayColor.CGColor;
    [netxButton addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:netxButton];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)buttonTap:(UIButton*)button {
    
    button.selected = !button.selected;
    _selected = button.selected;
    
    
}

- (void)nextPage:(UIButton*)button{
    
    InfoViewController *list = [InfoViewController new];
    [self.navigationController pushViewController:list animated:YES];
    
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder; {
     
     [super encodeRestorableStateWithCoder:coder];
     [coder encodeObject:@(_selected) forKey:selectedStateKey];
    
    
 }
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder; {
    [super decodeRestorableStateWithCoder:coder];
    _selected = [[coder decodeObjectForKey:selectedStateKey] boolValue];
    button.selected = _selected;
    
}

/*
 UIViewControllerRestoration苹果官方解释
 Your data source objects can adopt this protocol to assist a corresponding table or collection view during the state restoration process. Those classes use the methods of this protocol to ensure that the same data objects (and not just the same row indexes) are scrolled into view and selected.
 Before you can implement this protocol, your app must be able to identify data objects consistently between app launches. This requires being able to take some identifying marker of the object and convert that marker into a string that can then be saved with the rest of the app state. For example, a Core Data app could convert a managed object’s ID into a URI that it could then convert into a string.
 Currently, only the UITableView and UICollectionView classes support this protocol. You would implement this protocol in any objects you use as the data source for those classes. If you do not adopt the protocol in your data source, the views do not attempt to restore the selected and visible rows.
 */
#pragma mark - @protocol UIViewControllerRestoration

/**
 A class must implement this protocol if it is specified as the restoration class of a UIViewController.
 //简单描述就是，如果一个控制器没有指明 用于恢复的类 则必须实现此协议；
 //如果视图控制器是从故事板创建的，那么状态恢复,uikit会自动为您查找和创建视图控制器。但是，如果您在代码中手动创建视图控制器，则必须通过采用“uiviewcontrollerrestore”协议重新创建这些视图控制器。对手动创建的视图控制器使用此生成标志-
 
 */
+ (nullable UIViewController *) viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    //! identifierComponents返回的就是我们之前设置的restorationIdentifier
    PersonDetailController *ctrl = [[PersonDetailController alloc]init];
    ctrl.restorationIdentifier = identifierComponents.lastObject;
    ctrl.restorationClass = [self class];
    return ctrl;
}

@end


