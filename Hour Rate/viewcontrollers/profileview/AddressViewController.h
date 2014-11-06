//
//  AddressViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditProfileViewController.h"

@interface AddressViewController : UIViewController<UITextFieldDelegate>{
	id<Addrprotocol> delegate;
}

@property (weak, nonatomic) IBOutlet UITextField *entry1;
@property (weak, nonatomic) IBOutlet UITextField *entry2;
@property (weak, nonatomic) IBOutlet UITextField *entry3;
@property (weak, nonatomic) IBOutlet UITextField *entry4;
@property (retain, nonatomic) NSMutableArray *addressArr;
@property (weak, nonatomic) IBOutlet UITextField *entry5;

@property (nonatomic, retain) id<Addrprotocol> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
