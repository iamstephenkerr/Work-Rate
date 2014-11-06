//
//  ClientListViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 02/06/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ClientListViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *clientTable;

@property (nonatomic, retain) NSString *projectId;

@end
