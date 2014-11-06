//
//  AddTaskViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol APVprotocol

-(void)didRecieveData:(NSString *)data;

@end

@interface AddTaskViewController : UIViewController <APVprotocol, UITextFieldDelegate>

@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *identity;

@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (weak, nonatomic) IBOutlet UITextField *consoleView;


@end
