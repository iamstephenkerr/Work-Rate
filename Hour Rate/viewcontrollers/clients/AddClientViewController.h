//
//  AddClientViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 03/06/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddClientViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (weak, nonatomic) IBOutlet UITextField *entry1;
@property (weak, nonatomic) IBOutlet UITextField *entry2;
@property (weak, nonatomic) IBOutlet UITextField *entry3;
@property (weak, nonatomic) IBOutlet UITextField *entry4;
@property (weak, nonatomic) IBOutlet UITextField *entry5;

@property (nonatomic, retain) NSString *identity;

@end
