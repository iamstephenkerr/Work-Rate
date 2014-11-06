//
//  AddressViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController (){
	UITextField *activeTextField;
	float entry1y;
	float entry2y;
	float entry3y;
	float entry4y;
	float entry5y;
}

@end

@implementation AddressViewController
@synthesize entry1, entry2, entry3, entry4, scrollView, addressArr, entry5, delegate;

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
		
	[scrollView setContentSize:CGSizeMake(320.0, 500.0)];
	
	entry1.delegate = self;
	entry2.delegate = self;
	entry3.delegate = self;
	entry4.delegate = self;
	entry5.delegate = self;
	
	if([addressArr count] > 4){
		[entry1 setText:[addressArr objectAtIndex:0]];
		[entry2 setText:[addressArr objectAtIndex:1]];
		[entry3 setText:[addressArr objectAtIndex:2]];
		[entry4 setText:[addressArr objectAtIndex:3]];
		[entry5 setText:[addressArr objectAtIndex:4]];
	}
	
	entry1y = 116.0f;
	entry2y = 116.0f;
	entry3y = 200.0f;
	entry4y = 260.0f;
	entry5y = 320.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveBtn:(id)sender {
	
	NSMutableArray *temp = [[NSMutableArray alloc] initWithObjects:[entry1 text], [entry2 text], [entry3 text], [entry4 text], [entry5 text], nil];
	[self.delegate didRecieveDataAddress:temp];
	[self.navigationController popViewControllerAnimated:YES];
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
	
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
	
    CGRect rect = self.view.frame;
    rect.size.height -= keyboardSize.height;
	CGPoint scrollPoint;
	if (self.entry5.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry5y - (keyboardSize.height - 100));
	}else if(self.entry4.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry4y - (keyboardSize.height - 100));
	}else if(self.entry3.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry3y - (keyboardSize.height - 100));
	}else if(self.entry2.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry2y - (keyboardSize.height - 100));
	}else if(self.entry1.isFirstResponder){
		scrollPoint = CGPointMake(0.0, entry1y - (keyboardSize.height - 100));
	}
	[self.scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


@end
