//
//  HomeViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 28/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *projectTable;

@end
