//
//  AddProjectViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 29/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"

@interface AddProjectViewController : UIViewController <UITextFieldDelegate, APVprotocol>

@property (nonatomic, retain) NSString *price;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *payRate;
@property (weak, nonatomic) IBOutlet UIButton *btnone;
@property (weak, nonatomic) IBOutlet UIButton *btntwo;

@end
