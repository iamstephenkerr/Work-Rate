//
//  EditTaskViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 01/06/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"AddTaskViewController.h"
#import "TimerViewController.h"

@interface EditTaskViewController : UIViewController <APVprotocol, UITextFieldDelegate, UINavigationControllerDelegate>{
	id<Editprotocol> delegate;
}
@property (weak, nonatomic) IBOutlet UITextField *task_name;
@property (weak, nonatomic) IBOutlet UILabel *price_rate;

@property (nonatomic, retain) id<Editprotocol> delegate;

@property(nonatomic, retain) NSString *identity;
@property(nonatomic, retain) NSString *price;
@property(nonatomic, retain) NSString *taskname;

@end
