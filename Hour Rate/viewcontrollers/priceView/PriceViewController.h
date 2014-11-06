//
//  PriceViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 29/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProjectViewController.h"

@interface PriceViewController : UIViewController{
	id<APVprotocol> delegate;
}

@property (weak, nonatomic) IBOutlet UILabel *consoleLabel;

@property (nonatomic, retain) NSString *price;

@property (nonatomic, retain) id<APVprotocol> delegate;



@end
