//
//  EditProfileViewController.h
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Currprotocol

-(void)didRecieveData:(NSString *)data;

@end
@protocol Taxprotocol

-(void)didRecieveDataTax:(NSString *)data;

@end
@protocol Addrprotocol

-(void)didRecieveDataAddress:(NSMutableArray *)data;

@end


@interface EditProfileViewController : UIViewController <UITextFieldDelegate, Currprotocol, Taxprotocol, Addrprotocol>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *currency;
@property (weak, nonatomic) IBOutlet UILabel *tax;

@property (nonatomic, retain) NSString *currencydata;
@property (nonatomic, retain) NSString *taxdata;

@end
