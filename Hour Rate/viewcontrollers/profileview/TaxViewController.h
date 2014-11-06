//
//  TaxViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EditProfileViewController.h"

@interface TaxViewController : UIViewController{
	id<Taxprotocol> delegate;
}
@property (weak, nonatomic) IBOutlet UILabel *consoleRat;

@property (nonatomic, retain) id<Taxprotocol> delegate;
@property (nonatomic, retain) NSString *seq;

@end
