//
//  AddTaskViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "AddTaskViewController.h"

#import "PriceViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

@synthesize price, currentPrice, consoleView, identity;

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
	
	
	consoleView.delegate = self;
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
	
	[self.view addGestureRecognizer:tap];
	
	if(price == NULL){
		price = @"0.00";
	}
	[currentPrice setText:[NSString stringWithFormat:@"€ %1$@", price]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addTask:(id)sender {
	
	NSMutableDictionary *task = [[NSMutableDictionary alloc] initWithObjects:
								 [[NSMutableArray alloc] initWithObjects:[consoleView text], @"000000", price, [NSString stringWithFormat:@"t%1$f", [[NSDate date] timeIntervalSince1970]], nil] forKeys:
								 [[NSMutableArray alloc] initWithObjects:@"task_name", @"timer", @"rate", @"identity", nil]];
	
	
	
	
	NSUserDefaults *prefstemp = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	NSMutableArray *storagetemp = [prefstemp objectForKey:@"storage"];
	
	NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
	
	NSMutableArray *newstoragetemp = [[NSMutableArray alloc] initWithArray:storagetemp copyItems:TRUE];
	
	NSMutableArray *tt2 = [[NSMutableArray alloc] init];
	
	int z = 0;
	int y = 0;
	bool dobreak = false;
	
	for (int i = 0; !dobreak && i < [storagetemp count]; i++) {
		
		temp = [[NSMutableDictionary alloc] initWithDictionary:[storagetemp objectAtIndex:i] copyItems:TRUE];
		
		for(int x = 0; x < [[temp objectForKey:@"tasks"] count]; x++){
			
			if([[[storagetemp objectAtIndex:i] objectForKey:@"identity"] isEqual:identity]){

				tt2 = [[NSMutableArray alloc] initWithArray:[temp objectForKey:@"tasks"] copyItems:TRUE];
				
				z = x;
				y = i;
				
				dobreak = true;
				
				break;
			}
			
		}
		
	}
	
	
	
	[tt2 addObject:task];
					
	[temp setObject:tt2 forKey:@"tasks"];
		
	[newstoragetemp replaceObjectAtIndex:y withObject:temp];
	
	[prefstemp setObject:newstoragetemp forKey:@"storage"];  //set the prev Array for key value "favourites"
	[prefstemp synchronize];
	
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

-(void)didRecieveData:(NSString *)data{
	
	price = data;
	
	[currentPrice setText:[NSString stringWithFormat:@"€ %1$@", price]];
	
}
- (IBAction)closeView:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
	
    return YES;
}
-(void)dismissKeyboard {
	[consoleView resignFirstResponder];
}

@end
