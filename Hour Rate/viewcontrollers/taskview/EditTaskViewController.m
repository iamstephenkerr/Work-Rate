//
//  EditTaskViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 01/06/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "EditTaskViewController.h"
#import "PriceViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController
@synthesize identity, task_name, price_rate, price, taskname, delegate;

-(void)didRecieveData:(NSString *)data{
	
	price = data;
	
	[price_rate setText:[NSString stringWithFormat:@"€ %1$@", price]];
	
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
	
	task_name.delegate = self;
	
	if(price == NULL){
		price = @"0.00";
	}
	
	[price_rate setText:[NSString stringWithFormat:@"€ %1$@", price]];
	
	[task_name setText:taskname];
	
	
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeView:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveBtn:(id)sender {
	
	NSUserDefaults *prefstemp = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	NSMutableArray *storagetemp = [prefstemp objectForKey:@"storage"];
	
	NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
	
	NSMutableArray *newstoragetemp = [[NSMutableArray alloc] initWithArray:storagetemp copyItems:TRUE];
	
	
	NSMutableDictionary *tt2 = [[NSMutableDictionary alloc] init];
	
	int z = 0;
	int y = 0;
	bool dobreak = false;
	for (int i = 0; !dobreak && i < [storagetemp count]; i++) {
		
		temp = [[NSMutableDictionary alloc] initWithDictionary:[storagetemp objectAtIndex:i] copyItems:TRUE];
		
		for(int x = 0; x < [[temp objectForKey:@"tasks"] count]; x++){
			
			if([[[[[storagetemp objectAtIndex:i] objectForKey:@"tasks"] objectAtIndex:x] objectForKey:@"identity"] isEqual:identity]){
				tt2 = [[NSMutableDictionary alloc] initWithDictionary:[[temp objectForKey:@"tasks"] objectAtIndex:x] copyItems:TRUE];
				z = x;
				y = i;
				
				dobreak = true;
				
				break;
			}
			
		}
		
	}
	
	[tt2 setValue:[task_name text] forKey:@"task_name"];
	[tt2 setValue:price forKey:@"rate"];
		
	NSMutableArray *tt3 = [[NSMutableArray alloc] initWithArray:[temp objectForKey:@"tasks"] copyItems:TRUE];
	
	[tt3 replaceObjectAtIndex:z withObject:tt2];
	
	[temp setObject:tt3 forKey:@"tasks"];
		
	[newstoragetemp replaceObjectAtIndex:y withObject:temp];
	
	[prefstemp setObject:newstoragetemp forKey:@"storage"];  //set the prev Array for key value "favourites"
	[prefstemp synchronize];
	
	[self.delegate didRecieveTheData:price :[task_name text]];
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* controller = [segue destinationViewController];
    if ([controller isKindOfClass:[PriceViewController class]])
    {
        PriceViewController* vc = (PriceViewController *)controller;
        vc.delegate = self;
		vc.price = price;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
	
	return YES;
}

@end
