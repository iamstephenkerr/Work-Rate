//
//  ClientListViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 02/06/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "ClientListViewController.h"

#import "AddClientViewController.h"
#import "HomeCell.h"

@interface ClientListViewController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>{
	UIActionSheet *sheet;
	NSMutableArray *storage;
	NSMutableArray *mainstorage;
	NSString *identity;
	NSMutableDictionary *current;
	NSString *curr;
}

@end

@implementation ClientListViewController
@synthesize clientTable, projectId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	storage = [prefs objectForKey:@"clients"];
	[clientTable reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	storage = [prefs objectForKey:@"clients"];
		
	mainstorage = [[NSMutableArray alloc] initWithArray:[prefs objectForKey:@"storage"] copyItems:YES];

	for(int i = 0; i < [mainstorage count]; i++){
		if([[mainstorage objectAtIndex:i] objectForKey:@"identity"] == projectId){
			current = [[NSMutableDictionary alloc] initWithDictionary:[mainstorage objectAtIndex:i]];
		}
	}
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Table declaration
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	//get
	return [storage count];
	
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 89.0;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSString *cellId = @"ClientCell";
	HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil) {
		cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
	}
	
	cell.identity = [[storage objectAtIndex:indexPath.row] objectForKey:@"identity"];
	cell.cellLabel.text = [[storage objectAtIndex:indexPath.row] objectForKey:@"name"];
	
	return cell;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0){
		
		AddClientViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddClient"];
		
		vc.identity = identity;

		[self presentViewController:vc animated:YES completion:nil];
		
	}else if(buttonIndex == 1){
		[self openInvoice:@"simple"];
	}else if(buttonIndex == 2){
		[self openInvoice:@"detailed"];
	}else if(buttonIndex == 3){
		[self deleteProject];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	HomeCell *cell = (HomeCell *)[tableView cellForRowAtIndexPath:indexPath];
	identity = cell.identity;
	
	sheet = [[UIActionSheet alloc] initWithTitle:@""
										delegate:self
							   cancelButtonTitle:@"Cancel"
						  destructiveButtonTitle:nil
							   otherButtonTitles:@"Edit Client", @"Simple Invoice", @"Detailed Invoice", @"Delete Client", nil];
	
	// Show the sheet
	[sheet showInView:self.view];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return UITableViewCellEditingStyleDelete;
}


-(void)openInvoice:(NSString *)type{
	
	MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
	if ([MFMailComposeViewController canSendMail]) {
		
		
			mailViewController.mailComposeDelegate = self;
			NSDictionary *selected;
			for (int i = 0; i < [storage count]; i++) {
				if([[storage objectAtIndex:i] objectForKey:@"identity"] == identity){
					selected = [[NSDictionary alloc] initWithDictionary:[storage objectAtIndex:i] copyItems:YES];
					break;
				}
			}
			
			NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
			NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithDictionary:[prefs objectForKey:@"userinfo"] copyItems:YES];
			if([user count] < 1){
				NSLog(@"run");
				user = [[NSMutableDictionary alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"User name", [[NSMutableArray alloc] initWithObjects:@"street", @"other", @"city", @"country", @"extra", nil], @"€ Euro", @"21", nil] forKeys:[[NSMutableArray alloc] initWithObjects:@"name", @"address", @"currency", @"tax", nil]];
			}
		NSLog(@"%@", user);
			curr = [user objectForKey:@"currency"];
		NSLog(@"1");
			NSString *section1 = [NSString stringWithFormat:@"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'><html xmlns='http://www.w3.org/1999/xhtml'><head><meta name='viewport' content='width=device-width' /><meta http-equiv='Content-Type' content='text/html; charset=UTF-8' /><title>Invoice</title><style>html,body{margin:0px;padding:0px;}*{font-family:'HelveticaNeue','Helvetica',Helvetica,Arial,sans-serif;}img{max-width:100%%;}.collapse{margin:0;padding:0;}body{-webkit-font-smoothing:antialiased;-webkit-text-size-adjust:none;width:100%%!important;height:100%%;}a{color:#2BA6CB;}.btn{text-decoration:none;color:#FFF;background-color:#666;padding:10px0px;font-weight:bold;margin-right:10px;text-align:center;cursor:pointer;display:inline-block;}p.callout{padding:0px;background-color:#ECF8FF;margin-bottom:15px;}table.social{background-color:#ebebeb;}table.body-wrap{width:100%%;}table.footer-wrap{width:100%%;clear:both!important;}h1,h2,h3,h4,h5,h6{font-family:'HelveticaNeue-Light','HelveticaNeueLight','HelveticaNeue',Helvetica,Arial,'LucidaGrande',sans-serif;line-height:1.1;margin-bottom:15px;color:#000;}h1{font-weight:200;font-size:44px;}h2{font-weight:200;font-size:37px;}h3{font-weight:500;font-size:27px;}h4{font-weight:500;font-size:23px;}h5{font-weight:900;font-size:17px;}h6{font-weight:900;font-size:14px;text-transform:uppercase;color:#444;}.collapse{margin:0!important;}p,ul{margin-bottom:10px;font-weight:normal;font-size:14px;line-height:1.6;}p.lead{font-size:17px;}p.last{margin-bottom:0px;}ulli{margin-left:5px;list-style-position:inside;}.container{margin:auto;display:block!important;max-width:600px!important;margin:0auto!important;clear:both!important;}.content{padding:0px;max-width:600px;margin:0auto;display:block;}table{width:100%%;}.column{width:300px;float:left;}.column-wrap{padding:0!important;margin:0auto;max-width:600px!important;}.columntable{width:100%%;}.social.column{width:280px;min-width:279px;float:left;}.clear{display:block;clear:both;}.head{font-weight: bold;}</style></head><body bgcolor='#FFFFFF'><table class='body-wrap'><tr><td></td><td class='container' bgcolor='#FFFFFF'><div class='content'><table><tr><td><h3>%1$@</h3><table><tr>", [current objectForKey:@"project_name"]];
		
			[mailViewController setSubject:[NSString stringWithFormat:@"%1$@ for %2$@", [current objectForKey:@"project_name"], [selected objectForKey:@"name"]]];
			
			NSString *section2 = [NSString stringWithFormat:@"<td style='text-align:left'><strong>To:</strong></td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td style='text-align:left'>%1$@</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td style='text-align:left'>%2$@</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td style='text-align:left'>%3$@</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td style='text-align:left'>%4$@</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td style='text-align:left'>%5$@</td><td>&nbsp;</td><td>&nbsp;</td></tr></table><hr/><table><thead><td class='head'>Task name</td><td class='head'>Time Worked</td><td class='head'>Rate Per Hour</td><td class='head'>Total</td></thead>", [selected objectForKey:@"name"], [selected objectForKey:@"street"], [selected objectForKey:@"city"], [selected objectForKey:@"country"], [selected objectForKey:@"phone"]];
		

			double total = 0.0;
			
			NSString *section3 = @"";
			for(int i = 0; i < [[current objectForKey:@"tasks"] count]; i++){
				NSDictionary *temp = [[current objectForKey:@"tasks"] objectAtIndex:i];
				
				section3 = [NSString stringWithFormat:@"<tr><td>%1$@</td><td>%2$@</td><td style='text-align:center'>%3$@</td><td> %6$@ %5$@</td></tr> %4$@", [temp objectForKey:@"task_name"], [self formatTime:[[temp objectForKey:@"timer"] intValue]], [temp objectForKey:@"rate"], section3, [self calculateTotal:[self formatTime:[[temp objectForKey:@"timer"] intValue]] :[temp objectForKey:@"rate"]], curr];
				total += [[self calculateTotal:[self formatTime:[[temp objectForKey:@"timer"] intValue]] :[temp objectForKey:@"rate"]] doubleValue];
				
			}
			double grandTotal = ((total/100)*[[user objectForKey:@"tax"] doubleValue])+total;
		NSLog(@"2");	
			NSString *section4 = [NSString stringWithFormat:@"</table><br/><table><tr><td>&nbsp;</td><td style='text-align:right'>Net Total:</td><td style='text-align:right'>%4$@ %1$@</tr><tr><td>&nbsp;</td><td style='text-align:right'>Tax:</td><td style='text-align:right'>%2$@</td></tr><tr><td>&nbsp;</td><td style='text-align:right'>Total:</td><td style='text-align:right'><strong>%4$@ %3$@</strong></td></tr></table><hr/><table>", [self formatCurr:total], [user objectForKey:@"tax"], [self formatCurr:grandTotal], curr];
			
			NSString *section5 = [NSString stringWithFormat:@"<tr><td>%3$@</td><td style='text-align:right'>&nbsp;</td><td style='text-align:right'>%1$@</td></tr><tr><td>%4$@</td><td style='text-align:right'>&nbsp;</td><td style='text-align:right'>%2$@</td></tr><tr><td>%5$@</td><td style='text-align:right'>&nbsp;</td><td style='text-align:right'>&nbsp;</td></tr><tr><td>%6$@</td><td style='text-align:right'>&nbsp;</td><td style='text-align:right'>&nbsp;</td></tr></table><br/><br/></td></tr></table></div></td><td></td></tr></table>", [user objectForKey:@"name"], [[user objectForKey:@"address"] objectAtIndex:4], [[user objectForKey:@"address"] objectAtIndex:0], [[user objectForKey:@"address"] objectAtIndex:1], [[user objectForKey:@"address"] objectAtIndex:2],[[user objectForKey:@"address"] objectAtIndex:3]];
		NSLog(@"3");
		
			NSString *section6 = @"<table class='footer-wrap'><tr><td></td><td class='container'><hr/><small><a href='http://xzien.com'>Created with the Work Rate App</a></small></td><td></td></tr></table></body></html>";
		
		NSString *content = @"";
		if([type isEqual: @"simple"]){
			content = [NSString stringWithFormat:@"%1$@%2$@%3$@%4$@%5$@%6$@", section1, section2, section3, section4, section5, section6];
		
		}else{
			
			
			NSUserDefaults *prefstemp = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
			
			NSMutableArray *records = [[NSMutableArray alloc] initWithArray:[prefstemp objectForKey:@"timestorage"] copyItems:YES];
			
			if(records == NULL) records = [[NSMutableArray alloc] init];

			NSString *section7 = @"";
			section7 = @"";
			for(int x = 0; x < [[current objectForKey:@"tasks"] count]; x++){
				for(int i = 0; i < [records count]; i++){
					
					if([[[current objectForKey:@"tasks"] objectAtIndex:x] objectForKey:@"identity"] == [[records objectAtIndex:i] objectForKey:@"identity"]){
						section7 = [NSString stringWithFormat:@"<tr><td>%4$@</td><td>%2$@</td><td>%3$@</td><td>%5$@</td></tr>%1$@", section7, [[records objectAtIndex:i] objectForKey:@"start"], [[records objectAtIndex:i] objectForKey:@"end"], [[[current objectForKey:@"tasks"] objectAtIndex:x] objectForKey:@"task_name"], [self formatTime:[[[records objectAtIndex:i] objectForKey:@"difference"] intValue]]];
					}
				}
			}
			section7 = [NSString stringWithFormat:@"<h3>Time Worked</h3><table><thead><td class='head'>Task Name</td><td class='head'>Started</td><td class='head'>Ended</td><td class='head'>Work Time</td></thead>%1$@</table>", section7];
			
			
			content = [NSString stringWithFormat:@"%1$@%2$@%3$@%4$@%5$@%6$@%7$@", section1, section2, section3, section4, section5, section7, section6];
		}
			[mailViewController setMessageBody:content isHTML:YES];
		
		
			[self presentViewController:mailViewController animated:YES completion:nil];
	}else {
		
		//NSLog(@"Device is unable to send email in its current state.");
		
	}
	
	
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

-(void) deleteProject{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	storage = [prefs objectForKey:@"clients"];
	NSMutableArray *newstore = [[NSMutableArray alloc] initWithArray:storage copyItems:YES];
	int i = 0;
	for(; i < [storage count]; i++){
		
		if([[storage objectAtIndex:i] objectForKey:@"identity"] == identity){

			break;
		}
		
	}
	
	[newstore removeObjectAtIndex:i];
	storage = newstore;
	
	[prefs setObject:newstore forKey:@"clients"];  //set the prev Array for key value "favourites"
	[prefs synchronize];
	
	[clientTable reloadData];
	
}

-(NSString *)formatTime:(int)timerValue{
	
	int hours = 0;
	int minutes = 0;
	int seconds = 0;
	
	NSString *hour = @"";
	NSString *minute = @"";
	NSString *second = @"";
	
	if(timerValue > 3599){
		
		hours = timerValue/3600;
		timerValue = timerValue - (hours*360);
		
	}
	
	if(timerValue > 59){
		
		minutes = timerValue/60;
		timerValue = timerValue - (minutes*60);
		
	}
	
	//Hours
	if(hours < 10 && hours > 0){
		hour = [NSString stringWithFormat:@"0%1$d:", hours];
	}else if(hours < 1){
		hour = @"00:";
	}else{
		hour = [NSString stringWithFormat:@"%1$d:", hours];
	}
	
	//Minutes
	if(minutes < 10 && minutes > 0){
		minute = [NSString stringWithFormat:@"0%1$d:", minutes];
	}else if(minutes < 1){
		minute = @"00:";
	}else{
		minute = [NSString stringWithFormat:@"%1$d:", minutes];
	}
	
	seconds = timerValue;
	
	//Seconds
	if(seconds < 10 && seconds > 0){
		second = [NSString stringWithFormat:@"0%1$d", seconds];
	}else if(seconds < 1){
		second = @"00";
	}else{
		second = [NSString stringWithFormat:@"%1$d", seconds];
	}
	
	
	return [NSString stringWithFormat:@"%1$@%2$@%3$@", hour, minute, second];
}

-(NSString *)calculateTotal:(NSString *)intime :(NSString *)inrate{
	
	double cost = 0.00;
	
	intime = [intime stringByReplacingOccurrencesOfString:@":" withString:@""];
	
	cost += ([inrate doubleValue]/3600)*[[intime substringFromIndex:[intime length]-2] doubleValue];
	
	intime = [intime substringToIndex:[intime length]-2];
	
	cost += ([inrate doubleValue]/60)*[[intime substringFromIndex:[intime length]-2] doubleValue];
	
	intime = [intime substringToIndex:[intime length]-2];
	
	cost += [inrate doubleValue]*[[intime substringFromIndex:[intime length]-2] doubleValue];
	
	NSNumber *someNumber = [NSNumber numberWithDouble:cost];
	NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
	[nf setNumberStyle:NSNumberFormatterCurrencyStyle];
	
	return [NSString stringWithFormat:@"%1$@", [[nf stringFromNumber:someNumber] substringFromIndex:1]];
}

-(NSString *)formatCurr:(double)input{
	NSNumber *someNumber = [NSNumber numberWithDouble:input];
	NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
	[nf setNumberStyle:NSNumberFormatterCurrencyStyle];
	
	return [NSString stringWithFormat:@"%1$@", [[nf stringFromNumber:someNumber] substringFromIndex:1]];
}

@end
