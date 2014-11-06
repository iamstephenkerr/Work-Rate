//
//  TimerViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 28/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "AddTaskViewController.h"

@protocol Editprotocol

-(void)didRecieveTheData:(NSString *)data :(NSString *)data2;

@end

@interface TimerViewController : UIViewController <Editprotocol, APVprotocol, UITextFieldDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *invoiceBtn;
@property (nonatomic, retain) NSString *identity;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *rate;
@property (nonatomic, retain) NSString *taskname;
@property (nonatomic, retain) NSString *type;

@property (nonatomic, retain) NSString *projectid;

@property (weak, nonatomic) IBOutlet UIView *rotationView;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, retain) NSTimer *mainTimer;
@property (weak, nonatomic) IBOutlet UIView *resultsView;
@property (weak, nonatomic) IBOutlet UIButton *timerBtn;
@property (weak, nonatomic) IBOutlet UILabel *project_title;

@property (weak, nonatomic) IBOutlet UILabel *resultsTime;
@property (weak, nonatomic) IBOutlet UILabel *resultsRate;
@property (weak, nonatomic) IBOutlet UILabel *resultsTotal;
@property (weak, nonatomic) IBOutlet UILabel *mainRate;

@end
