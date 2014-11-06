//
//  TaxViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "TaxViewController.h"

@interface TaxViewController ()

@end

@implementation TaxViewController
@synthesize consoleRat, seq, delegate;

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
	
	if([seq isEqual: NULL]){
		seq = @"";
	}
	
	
	[consoleRat setText:[NSString stringWithFormat:@"%1$@ %%", [NSString stringWithFormat:@"%1$@.%2$@", [seq substringToIndex:[seq length]-1], [seq substringFromIndex:[seq length]-1]]]];
		
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)removeBtn:(id)sender {
	[self addNumber:-1];
}
- (IBAction)zerobtn:(id)sender {
	[self addNumber:0];
}
- (IBAction)onebtn:(id)sender {
	[self addNumber:1];
}
- (IBAction)twobtn:(id)sender {
	[self addNumber:2];
}
- (IBAction)threebtn:(id)sender {
	[self addNumber:3];
}
- (IBAction)fourbtn:(id)sender {
	[self addNumber:4];
}
- (IBAction)fivebtn:(id)sender {
	[self addNumber:5];
}
- (IBAction)sixbtn:(id)sender {
	[self addNumber:6];
}
- (IBAction)sevenbtn:(id)sender {
	[self addNumber:7];
}
- (IBAction)eightbtn:(id)sender {
	[self addNumber:8];
}
- (IBAction)ninebtn:(id)sender {
	[self addNumber:9];
}

-(void)addNumber:(int)input{
	
	if(input == -1){
		seq = [seq substringToIndex:[seq length]-1];
	}else{
		seq = [NSString stringWithFormat:@"%1$@%2$d", seq, input];
	}
		
	while([seq length] < 4){
		seq = [NSString stringWithFormat:@"0%1$@", seq];
	}
	
	if([seq isEqualToString:@""]){
		[consoleRat setText:@"0.0 %%"];
	}else{
		
		if(([[seq substringToIndex:1] isEqualToString:@"0"] && ![[seq substringToIndex:2] isEqualToString:@"0"])){
			seq = [seq substringFromIndex:1];
		}
		
		[consoleRat setText:[NSString stringWithFormat:@"%1$@ %%", [NSString stringWithFormat:@"%1$@.%2$@", [seq substringToIndex:[seq length]-1], [seq substringFromIndex:[seq length]-1]]]];
	}
	
}
- (IBAction)saveBtn:(id)sender {
	
	[self.delegate didRecieveDataTax:seq];
	[self.navigationController popViewControllerAnimated:YES];
	
}

@end
