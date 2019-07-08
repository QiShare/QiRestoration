//
//  InfoDetailController.m
//  QIRestorationDemo
//
//  Created by qinwanli on 2019/7/5.
//  Copyright © 2019 qishare. All rights reserved.
//

#import "InfoDetailController.h"

@interface InfoDetailController ()<UIViewControllerRestoration>

@end

@implementation InfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"列表详情界面";
    
    self.restorationIdentifier = NSStringFromClass(self.class);
    self.view.backgroundColor = UIColor.whiteColor;
//    self.restorationClass = self.class;
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 300, 50)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.center = self.view.center;
    label.text = [NSString stringWithFormat:@"%@:标识符：%@",self.model.title,self.model.identifier];
    [self.view addSubview:label];
    
    // Do any additional setup after loading the view.
}


+ (nullable UIViewController *) viewControllerWithRestorationIdentifierPath:(NSArray<NSString *> *)identifierComponents coder:(NSCoder *)coder {
    //! identifierComponents返回的就是我们之前设置的restorationIdentifier
    InfoDetailController *ctrl = [[InfoDetailController alloc]init];
    ctrl.restorationIdentifier = identifierComponents.lastObject;
    ctrl.restorationClass = [self class];
    return ctrl;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
