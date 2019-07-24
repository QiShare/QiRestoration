//
//  InfoViewController.m
//  QIRestorationDemo
//
//  Created by QLY on 2019/6/30.
//  Copyright © 2019 qishare. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoModel.h"
#import "InfoDetailController.h"
@interface InfoViewController () <UITableViewDataSource, UITableViewDelegate,UIDataSourceModelAssociation>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *identifierArray;

@property (nonatomic, strong) NSIndexPath *currentPath;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"列表";
    
    [self setupViews];
    
    [self setupDatas];
    //设置恢复标识
    self.restorationIdentifier = NSStringFromClass(self.class);
    
}


#pragma mark - Private functions

- (void)setupViews{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor whiteColor];
    /**
     关于tableView的restorationIdentifier
     官方的描述为：
     To save and restore the table’s data, assign a nonempty value to the table view’s restorationIdentifier property. When its parent view controller is saved, the table view automatically saves the index paths for the currently selected and visible rows. If the table’s data source object adopts the UIDataSourceModelAssociation protocol, the table stores the unique IDs that you provide for those items instead of their index paths.
     实际：UIDataSourceModelAssociation 生效时 并没有自动恢复位置？
     */
    _tableView.restorationIdentifier = NSStringFromClass(_tableView.class);
    
    _tableView.estimatedSectionHeaderHeight = 0.0;
    _tableView.estimatedSectionFooterHeight = 0.0;
    _tableView.tableFooterView = nil;
    _tableView.tableHeaderView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:_tableView];
    
}


- (void)setupDatas{
    
    NSArray *array = @[@"appdelegate",@"controller",@"uirestoration",@"restorationId",@"restorationClass",@"view",@"seeyou",@"come on",@"i have no idea",@"陈宫",@"失败",@"似大江一发不收",@"以为平复心中争斗",@"人员翻白浅蓝",@"浪奔流"];
    NSArray *identifierArray = @[@"QiRestoration_0",@"QiRestoration_1",@"QiRestoration_2",@"QiRestoration_3",@"QiRestoration_4",@"QiRestoration_5",@"QiRestoration_6",@"QiRestoration_7",@"QiRestoration_8",@"QiRestoration_9",@"QiRestoration_10",@"QiRestoration_11",@"QiRestoration_12",@"QiRestoration_13",@"QiRestoration_14"];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i ++) {
        InfoModel *model = [[InfoModel alloc]init];
        model.title = array[i];
        model.identifier = identifierArray[i];
        [tempArray addObject:model];
    }
    self.dataSource = tempArray.copy;
    
}


#pragma mark - Action functions



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = model.title;
    cell.restorationIdentifier = model.identifier;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _currentPath = indexPath;
    
    InfoModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    InfoDetailController *infoDetail = [[InfoDetailController alloc]init];
    infoDetail.model = model;
    //如果这个类中设置了restorationClass，推测如不实现那个方法，则不会恢复，我们试一下。
    [self.navigationController pushViewController:infoDetail animated:YES];
}


#pragma mark - lazy

- (NSArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [[NSArray alloc]init];
    }
    
    return _dataSource;
}

//需要保存些许东西 就实现哈
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
}

#pragma mark - UIDataSourceModelAssociation
/*
 Your data source objects can adopt this protocol to assist a corresponding table or collection view during the state restoration process. Those classes use the methods of this protocol to ensure that the same data objects (and not just the same row indexes) are scrolled into view and selected.
 //你的数据源对象可以实现这个协议，在状态恢复的过程中去支持相关的table or collection view；这些实现了该协议的类，使用这个协议的方法去保证相同的数据对象，（而不仅仅是相同的行的索引）被滚动到视图并且被选中。
 Before you can implement this protocol, your app must be able to identify data objects consistently between app launches. This requires being able to take some identifying marker of the object and convert that marker into a string that can then be saved with the rest of the app state. For example, a Core Data app could convert a managed object’s ID into a URI that it could then convert into a string.
 //在你实现这个协议之前，你的App必须能够在App启动之间，一直（总是可以）辨别出数据源对象。这就要求对象能够有一些辨认标识，并且可以把标识转换为当App状态不活跃时能够被存储的字符串；
 Currently, only the UITableView and UICollectionView classes support this protocol. You would implement this protocol in any objects you use as the data source for those classes. If you do not adopt the protocol in your data source, the views do not attempt to restore the selected and visible rows.
 //目前，只有 UITableView 和 UICollectionView 类 支持这个协议。你将可以实现这个协议在任何你用来作为UITableView 和 UICollectionView数据源的对象中，如果在你的数据源对象中不实现这个协议，那么视图将不会试着去恢复选中的和可见rows;
 //似乎在说 谁实现了UITableView 和 UICollectionView的dataSource ,谁就应该实现这个协议，只有这样才会生效。实际操作发现也是如此。
 */
//即关联 相应索引下的model对象 （数据源对象） 注意要设置tableView的重用标识。设置了

/** 有了UIDataSourceModelAssociation和tableView的restorationIdentifier，这个方法就必须实现，不然会奔溃****/
- (NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view {
    //根据index 返回identifier
    NSString *identifier = nil;
    InfoModel *model = [self.dataSource objectAtIndex:idx.row];
    
    /*
     此方法会在保存时调用两次，idx所返回的数据除了我们选中的行，还会返回一个其他行。 若是采用这种实行映射唯一标识，会出现保存了我们不需要的行的标识，导致恢复滑动位置失效，针对此问题目前笔者尚未有答案。所以在此基础上笔者自己想的解决办法：定义_currentPath追踪当前选中的cell，保存时根据_currentPath保存我们需要的标识，测试中发现可以解决问题。
     if (idx && view) {
       identifier = model.identifier;
    }
    */
    if (idx.row == _currentPath.row && view) {
        identifier = model.identifier;
    }
    //若是不定义_currentPath追踪当前选中的cell.会多保存一个cell，目前尚未有答案。
    return identifier;
}
//此方法 恢复时调用
- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view {
    //根据identifier 返回index;
    NSIndexPath *indexPath = nil;

    if (identifier && view) {
        __block NSInteger row = 0;
        [self.dataSource enumerateObjectsUsingBlock:^(InfoModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.identifier isEqualToString:identifier]) {
                row = idx;
                *stop = YES;
            }
        }];
        indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        _currentPath = indexPath;
        NSLog(@"当前选中的数据源对象标识是：%@,对象抬头是:%@",[self.dataSource[indexPath.row] identifier],[self.dataSource[indexPath.row] title]);

    }

    return indexPath;
}


@end
