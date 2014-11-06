//
//  AddClientViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 03/06/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "AddClientViewController.h"

@interface AddClientViewController (){
	UITextField *activeTextField;
	float entry1y;
	float entry2y;
	float entry3y;
	float entry4y;
	float entry5y;
	int i;
	NSMutableDictionary *current;
}

@end

@implementation AddClientViewController
@synthesize entry1, entry2, entry3, entry4, entry5, mainScroll, identity;

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

	NSMutableArray *storage;
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	storage = [prefs objectForKey:@"clients"];
	i = 0;
	for(;i < [storage count]; i++){
		
		if([[storage objectAtIndex:i] objectForKey:@"identity"] == identity){
			current = [storage objectAtIndex:i];
			break;
		}
		
	}
	
	[mainScroll setContentSize:CGSizeMake(320.0, 500.0)];

	entry1.delegate = self;
	entry2.delegate = self;
	entry3.delegate = self;
	entry4.delegate = self;
	entry5.delegate = self;
	
	if([current objectForKey:@"identity"]){
		[entry1 setText:[current objectForKey:@"name"]];
		[entry2 setText:[current objectForKey:@"street"]];
		[entry3 setText:[current objectForKey:@"city"]];
		[entry4 setText:[current objectForKey:@"country"]];
		[entry5 setText:[current objectForKey:@"phone"]];
	}
	
	entry1y = 116.0f;
	entry2y = 116.0f;
	entry3y = 200.0f;
	entry4y = 260.0f;
	entry5y = 330.0f;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveBtn:(id)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	if (textField == entry1) {
		[textField resignFirstResponder];
		[entry2 becomeFirstResponder];
	}
	else if (textField == entry2) {
		[textField resignFirstResponder];
		[entry3 becomeFirstResponder];
		
	}else if (textField == entry3) {
		[textField resignFirstResponder];
		[entry4 becomeFirstResponder];
		
	}else if (textField == entry4) {
		[textField resignFirstResponder];
		[entry5 becomeFirstResponder];
		
	}else{
		[textField resignFirstResponder];
	}
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
	
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
	
    self.mainScroll.contentInset = contentInsets;
    self.mainScroll.scrollIndicatorInsets = contentInsets;
	
    CGRect rect = self.view.frame;
    rect.size.height -= keyboardSize.height;
	CGPoint scrollPoint;
	if (self.entry5.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry5y - (keyboardSize.height - 100));
	}else if (self.entry4.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry4y - (keyboardSize.height - 100));
	}else if(self.entry3.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry3y - (keyboardSize.height - 100));
	}else if(self.entry2.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry2y - (keyboardSize.height - 100));
	}else if(self.entry1.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry1y - (keyboardSize.height - 100));
	}
	[self.mainScroll setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mainScroll.contentInset = contentInsets;
    self.mainScroll.scrollIndicatorInsets = contentInsets;
}
- (IBAction)saveInfo:(id)sender {
	if(identity){
		NSMutableDictionary *content = [[NSMutableDictionary alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:[current objectForKey:@"identity"], [entry1 text], [entry2 text], [entry3 text], [entry4 text], [entry5 text], nil] forKeys:[[NSMutableArray alloc] initWithObjects:@"identity", @"name", @"street", @"city", @"country", @"phone", nil]];
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
		NSMutableArray *storage = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"clients"] copyItems:YES];
		
		[storage replaceObjectAtIndex:i withObject:content];
		
		[prefs setObject:storage forKey:@"clients"];  //set the prev Array for key value "favourites"
		[prefs synchronize];
		
	}else{
				
		NSMutableDictionary *content = [[NSMutableDictionary alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"c%1$f", [[NSDate date] timeIntervalSince1970]], [entry1 text], [entry2 text], [entry3 text], [entry4 text], [entry5 text], nil] forKeys:[[NSMutableArray alloc] initWithObjects:@"identity", @"name", @"street", @"city", @"country", @"phone", nil]];
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
		NSMutableArray *storage = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"clients"] copyItems:YES];
		
		[storage addObject:content];
		
		[prefs setObject:storage forKey:@"clients"];  //set the prev Array for key value "favourites"
		[prefs synchronize];
	}
	[self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backBtn:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}


@end
