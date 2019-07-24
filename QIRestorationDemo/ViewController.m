//
//  ViewController.m
//  QIRestorationDemo
//
//  Created by QLY on 2019/6/30.
//  Copyright © 2019 qishare. All rights reserved.
//

#import "ViewController.h"
#import "PersonDetailController.h"

static NSString * const nameKey = @"nameKey";
static NSString * const ageKey = @"ageKey";
static NSString * const jobKey = @"jobKey";
static NSString * const introKey = @"introKey";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *jobTextField;
@property (weak, nonatomic) IBOutlet UITextView *introTextView;
//若是在appdelegate中统一初始化了 则
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, strong) NSString *intro;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
       
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.restorationIdentifier = @"ViewController";
    self.title = @"你好";
    [self resignKeyboardFirstResponder];
    
}

#pragma mark - 添加隐藏键盘的手势

- (void)resignKeyboardFirstResponder {
    
    UITapGestureRecognizer *resignFirstResponderGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    //不取消原有试图的点击事件
    resignFirstResponderGesture.cancelsTouchesInView = NO;
    resignFirstResponderGesture.enabled = YES;
    [self.view addGestureRecognizer:resignFirstResponderGesture];
    
}


#pragma mark - Action functions

- (void)tapRecognized:(id)sender {
    
    [self.view endEditing:YES];
    
}


- (IBAction)nextPage:(id)sender {
    
    PersonDetailController *ctrl = [[PersonDetailController alloc]init];
    [self.navigationController pushViewController:ctrl animated:YES];
}



// Methods to save and restore state for the object. If these aren't implemented, the object
// can still be referenced by other objects in state restoration archives, but it won't
// save/restore any state of its own
//注意：每层控制器 如nav tab 都需要添加对用的恢复标识 ，否则不会走保存的恢复的方法
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    [coder encodeObject: _nameTextField.text ?: @"" forKey:nameKey];
    [coder encodeObject: _ageTextField.text ?: @"" forKey:ageKey];
    [coder encodeObject: _jobTextField.text ?: @"" forKey:jobKey];
    [coder encodeObject: _introTextView.text ?: @"" forKey:introKey];
    
}
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    self.name =  [NSString stringWithString:[coder decodeObjectForKey:nameKey]];
    self.age = [NSString stringWithString:[coder decodeObjectForKey:ageKey]];
    self.job = [NSString stringWithString:[coder decodeObjectForKey:jobKey]];
    self.intro = [NSString stringWithString:[coder decodeObjectForKey:introKey]];
    
    _nameTextField.text = self.name;
    _ageTextField.text = self.age;
    _jobTextField.text = self.job;
    _introTextView.text = self.intro;
    
}


@end
