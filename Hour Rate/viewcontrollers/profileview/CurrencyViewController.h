//
//  CurrencyViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProfileViewController.h"

@interface CurrencyViewController : UITableViewController{
	id<Currprotocol> delegate;
}
@property (strong, nonatomic) IBOutlet UITableView *currencyTable;

@property (nonatomic, retain) id<Currprotocol> delegate;

@end
