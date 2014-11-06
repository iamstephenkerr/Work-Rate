//
//  PriceViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 29/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "PriceViewController.h"

#import "AddProjectViewController.h"

@interface PriceViewController (){
	NSString *sequence;
}

@end

@implementation PriceViewController
@synthesize consoleLabel, price, delegate;

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
	if(price == NULL){
		price = @"€ 0.00";
	}
	sequence = [self convertToSeq:price];
	
	[consoleLabel setText:[NSString stringWithFormat:@"€ %1$@", price]];
	
}

-(NSString *)convertToSeq:(NSString *)input{
	
	input = [input stringByReplacingOccurrencesOfString:@"." withString:@""];
	input = [input stringByReplacingOccurrencesOfString:@" " withString:@""];
	input = [input stringByReplacingOccurrencesOfString:@"€" withString:@""];
	
	return input;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addNumber:(int)number{
	
	if(number > -1){
		sequence = [NSString stringWithFormat:@"%1$@%2$d", sequence, number];
	}else if([sequence length] > 0){
		sequence = [sequence substringToIndex:[sequence length]-1];
	}else{
		sequence = @"000";
	}
	
	while([sequence length] < 4){
		sequence = [NSString stringWithFormat:@"0%1$@", sequence];
	}
	
	if([sequence isEqualToString:@""]){
		[consoleLabel setText:@"€ 0.00"];
	}else{

		if(([[sequence substringToIndex:1] isEqualToString:@"0"] && [[sequence substringToIndex:2] isEqualToString:@"00"]) || ([[sequence substringToIndex:1] isEqualToString:@"0"] && ![[sequence substringToIndex:2] isEqualToString:@"0"])){
			sequence = [sequence substringFromIndex:1];
		}
		
		[consoleLabel setText:[NSString stringWithFormat:@"€ %1$@", [NSString stringWithFormat:@"%1$@.%2$@", [sequence substringToIndex:[sequence length]-2], [sequence substringFromIndex:[sequence length]-2]]]];
	}
}

/**
	Buttons
 */
- (IBAction)one:(id)sender {
	[self addNumber:1];
}
- (IBAction)two:(id)sender {
	[self addNumber:2];
}
- (IBAction)three:(id)sender {
	[self addNumber:3];
}
- (IBAction)four:(id)sender {
	[self addNumber:4];
}
- (IBAction)five:(id)sender {
	[self addNumber:5];
}
- (IBAction)six:(id)sender {
	[self addNumber:6];
}
- (IBAction)seven:(id)sender {
	[self addNumber:7];
}
- (IBAction)eight:(id)sender {
	[self addNumber:8];
}
- (IBAction)nine:(id)sender {
	[self addNumber:9];
}
- (IBAction)zero:(id)sender {
	[self addNumber:0];
}
- (IBAction)remove:(id)sender {
	[self addNumber:-1];
}

- (IBAction)completePrice:(id)sender {
	NSString *output = [consoleLabel text];
	
	output = [output stringByReplacingOccurrencesOfString:@"€ " withString:@""];
	
	[self.delegate didRecieveData:output];
	[self.navigationController popViewControllerAnimated:YES];
	
}

@end
