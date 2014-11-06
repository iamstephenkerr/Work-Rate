//
//  AddProjectViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 29/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "AddProjectViewController.h"
#import "PriceViewController.h"

@interface AddProjectViewController (){
	
	NSString *projectType;
	
}

@end

@implementation AddProjectViewController

@synthesize price, payRate, nameTextField, btnone, btntwo;


-(void)didRecieveData:(NSString *)data{
	
	price = data;
	
	[payRate setText:[NSString stringWithFormat:@"€ %1$@", price]];
	
}

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
	
	nameTextField.delegate = self;
	
	if(price == NULL){
		price = @"0.00";
	}
	[payRate setText:[NSString stringWithFormat:@"€ %1$@", price]];
	
	projectType = @"1";
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addProject:(id)sender {
	
	NSMutableDictionary *project = [[NSMutableDictionary alloc] init];
	
	if([projectType isEqual: @"1"]){
		project = [[NSMutableDictionary alloc] initWithObjects:
							 [[NSMutableArray alloc] initWithObjects:@"single", [nameTextField text], [NSString stringWithFormat:@"p%1$f", [[NSDate date] timeIntervalSince1970]], [[NSMutableArray alloc] initWithObjects: [[NSMutableDictionary alloc] initWithObjects:
																																			[[NSMutableArray alloc] initWithObjects:[nameTextField text], @"000000", price, [NSString stringWithFormat:@"t%1$f", [[NSDate date] timeIntervalSince1970]], nil] forKeys:
																																			[[NSMutableArray alloc] initWithObjects:@"task_name", @"timer", @"rate", @"identity", nil]], nil], nil] forKeys:
							 [[NSMutableArray alloc] initWithObjects:@"type", @"project_name", @"identity", @"tasks", nil]];
	
	}else if([projectType isEqual: @"2"]){
		
		project = [[NSMutableDictionary alloc] initWithObjects:
				   [[NSMutableArray alloc] initWithObjects:@"multiple", [nameTextField text], [NSString stringWithFormat:@"p%1$f", [[NSDate date] timeIntervalSince1970]], [[NSMutableArray alloc] initWithObjects: [[NSMutableDictionary alloc] initWithObjects:
																																																				   [[NSMutableArray alloc] initWithObjects:@"Task Name", @"000000", price, [NSString stringWithFormat:@"t%1$f", [[NSDate date] timeIntervalSince1970]], nil] forKeys:
																																																					 [[NSMutableArray alloc] initWithObjects:@"task_name", @"timer", @"rate", @"identity", nil]], nil], nil] forKeys:
				   [[NSMutableArray alloc] initWithObjects:@"type", @"project_name", @"identity", @"tasks", nil]];
		
	}
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	NSMutableArray *storage = [prefs objectForKey:@"storage"];
	
	NSMutableArray *newStorage = [[NSMutableArray alloc] initWithArray:storage];
	[newStorage addObject:project];
		
	[prefs setObject:newStorage forKey:@"storage"];  //set the prev Array for key value "favourites"
	[prefs synchronize];
	
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

- (IBAction)buttonOne:(id)sender {
	projectType = @"1";
	
	[btntwo setBackgroundImage:nil forState:UIControlStateNormal];
	[btntwo setTitleColor:[UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:1.0f] forState:UIControlStateNormal];
	
	[btnone setBackgroundImage:[UIImage imageNamed:@"selected_choice.png"] forState:UIControlStateNormal];
	[btnone setTitleColor:[UIColor colorWithRed:(73.0/255.0) green:(173.0/255.0) blue:(112.0f/255.0) alpha:1.0f] forState:UIControlStateNormal];
}
- (IBAction)buttonTwo:(id)sender {
	projectType = @"2";
	
	[btnone setBackgroundImage:nil forState:UIControlStateNormal];
	[btnone setTitleColor:[UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:1.0f] forState:UIControlStateNormal];
		
	[btntwo setBackgroundImage:[UIImage imageNamed:@"selected_choice.png"] forState:UIControlStateNormal];
	[btntwo setTitleColor:[UIColor colorWithRed:(73.0/255.0) green:(173.0/255.0) blue:(112.0f/255.0) alpha:1.0f] forState:UIControlStateNormal];
	
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
	
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* controller = [segue destinationViewController];
    if ([controller isKindOfClass:[PriceViewController class]])
    {
        PriceViewController* vc = (PriceViewController *)controller;
        vc.delegate = self;
    }
}
- (IBAction)openPriceView:(id)sender {
	
	PriceViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"priceView"];
	vc.price = price;
	vc.delegate = self;
	// Push the view controller and make it animated
	[self.navigationController pushViewController:vc animated:YES];
	
}
- (IBAction)closeView:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
