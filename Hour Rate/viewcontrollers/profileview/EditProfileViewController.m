//
//  EditProfileViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "EditProfileViewController.h"

#import "CurrencyViewController.h"
#import "TaxViewController.h"
#import "AddressViewController.h"

@interface EditProfileViewController (){
	NSMutableArray *addressArr;
}


@end

@implementation EditProfileViewController
@synthesize nameField, currency, tax, address, currencydata, taxdata;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.nameField.delegate = self;
	
	NSMutableDictionary *storage;
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	storage = [[NSMutableDictionary alloc] initWithDictionary:[prefs objectForKey:@"userinfo"] copyItems:YES];
	if(![storage objectForKey:@"name"]){
		storage = [[NSMutableDictionary alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"User name", [[NSMutableArray alloc] initWithObjects:@"street", @"other", @"city", @"country", @"phone", nil], @"€", @"21", nil] forKeys:[[NSMutableArray alloc] initWithObjects:@"name", @"address", @"currency", @"tax", nil]];
	}
	addressArr = [storage objectForKey:@"address"];
	
	[nameField setText:[storage objectForKey:@"name"]];
	[currency setText:[NSString stringWithFormat:@"Currency: %1$@", [storage objectForKey:@"currency"]]];
	[tax setText:[NSString stringWithFormat:@"Tax: %1$@%%", [storage objectForKey:@"tax"]]];
	taxdata = [storage objectForKey:@"tax"];
	currencydata = [storage objectForKey:@"currency"];
	
	[prefs setObject:storage forKey:@"userinfo"];  //set the prev Array for key value "favourites"
	[prefs synchronize];
		
}
- (IBAction)saveBtn:(id)sender {
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	NSMutableDictionary *storage = [[NSMutableDictionary alloc] initWithDictionary:[prefs objectForKey:@"userinfo"] copyItems:YES];
	
	if(!storage){
		storage = [[NSMutableDictionary alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"User name", [[NSMutableArray alloc] initWithObjects:@"street", @"other", @"city", @"country", nil], @"€ Euro", @"21", nil] forKeys:[[NSMutableArray alloc] initWithObjects:@"name", @"address", @"currency", @"tax", nil]];
	}
	
	taxdata = [tax text];
	
	taxdata = [taxdata stringByReplacingOccurrencesOfString:@"%" withString:@""];
	taxdata = [taxdata stringByReplacingOccurrencesOfString:@"Tax:" withString:@""];
	
	currencydata = [[currency text] substringFromIndex:[[currency text] length]-1];
		
	[storage setObject:[nameField text] forKey:@"name"];
	[storage setObject:taxdata forKey:@"tax"];
	[storage setObject:currencydata forKey:@"currency"];
	[storage setObject:addressArr forKey:@"address"];

	[prefs setObject:storage forKey:@"userinfo"];  //set the prev Array for key value "favourites"
	[prefs synchronize];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeView:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* controller = [segue destinationViewController];

    if ([controller isKindOfClass:[CurrencyViewController class]])
    {
        CurrencyViewController* vc = (CurrencyViewController *)controller;
        vc.delegate = self;
    }else if([controller isKindOfClass:[TaxViewController class]]){
		TaxViewController* vc = (TaxViewController *)controller;
		vc.delegate = self;
		vc.seq = taxdata;
	}else if([controller isKindOfClass:[AddressViewController class]]){
		AddressViewController *vc = (AddressViewController *)controller;
		vc.addressArr = addressArr;
		vc.delegate = self;
	}
}

-(void)didRecieveData:(NSString *)data{
	
	currencydata = data;
	[currency setText:[NSString stringWithFormat:@"Currency: %1$@", data]];
}
-(void)didRecieveDataTax:(NSString *)data{
	
	taxdata = data;
	[tax setText:[NSString stringWithFormat:@"Tax: %1$@ %%", [NSString stringWithFormat:@"%1$@.%2$@", [taxdata substringToIndex:[taxdata length]-1], [taxdata substringFromIndex:[taxdata length]-1]]]];
}

-(void)didRecieveDataAddress:(NSMutableArray *)data{

	addressArr = data;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
	
    return YES;
}

@end
