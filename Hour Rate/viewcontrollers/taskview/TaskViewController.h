//
//  TaskViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 29/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, retain) NSString *identity;

@property (weak, nonatomic) IBOutlet UITableView *taskTable;
@property (weak, nonatomic) IBOutlet UITextField *project_name;

@end
