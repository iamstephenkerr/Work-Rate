//
//  HomeCell.h
//  Hour Rate
//
//  Created by Stephen Kerr on 28/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellBg;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@property (nonatomic, retain) NSString *projectId;
@property (nonatomic, retain) NSString *identity;

@end
