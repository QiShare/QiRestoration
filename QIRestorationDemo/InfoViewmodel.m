//
//  InfoViewmodel.m
//  QIRestorationDemo
//
//  Created by qinwanli on 2019/7/5.
//  Copyright © 2019 qishare. All rights reserved.
//

#import "InfoViewmodel.h"
#import "InfoModel.h"
@implementation InfoViewmodel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDatas];
    }
    return self;
}

- (void)setupDatas{
    
    NSArray *array = @[@"appdelegate",@"controller",@"uirestoration",@"restorationId",@"restorationClass",@"view",@"seeyou",@"come on",@"i have no idea",@"陈宫",@"失败",@"似大江一发不收",@"以为平复心中争斗",@"人员翻白浅蓝",@"浪奔"];
    NSArray * identifierArray = @[@"QiRestoration_0",@"QiRestoration_1",@"QiRestoration_2",@"QiRestoration_3",@"QiRestoration_4",@"QiRestoration_5",@"QiRestoration_6",@"QiRestoration_7",@"QiRestoration_8",@"QiRestoration_9",@"QiRestoration_10",@"QiRestoration_11",@"QiRestoration_12",@"QiRestoration_13",@"QiRestoration_14"];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i ++) {
        InfoModel *model = [[InfoModel alloc]init];
        model.title = array[i];
        model.identifier = identifierArray[i];
        [tempArray addObject:model];
    }
    self.dataSource = tempArray.copy;
}



@end
