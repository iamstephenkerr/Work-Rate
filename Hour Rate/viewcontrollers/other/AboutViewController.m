//
//  AboutViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 31/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)feedback:(id)sender {
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:youremail@whatever.com"]];
	
}
- (IBAction)exportCall:(id)sender {
	sheet = [[UIActionSheet alloc] initWithTitle:@"This will export content to an email."
										delegate:self
							   cancelButtonTitle:@"Cancel"
						  destructiveButtonTitle:nil
							   otherButtonTitles:@"Export as CSV", @"Export as PDF", @"Export as Text", nil];
	
	// Show the sheet
	[sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	NSLog(@"%ld", (long)buttonIndex);
}

@end
