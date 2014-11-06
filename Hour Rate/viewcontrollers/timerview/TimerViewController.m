//
//  TimerViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 28/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "TimerViewController.h"

#import "SIAlertView.h"
#import "EditTaskViewController.h"
#import "ClientListViewController.h"

@interface TimerViewController (){
	int timerCount;
	bool timerRunning;
	bool animationRunning;
	
	NSDate *endDate;
	NSDate *startDate;
	UIActionSheet *sheet;
}


@end

@implementation TimerViewController
@synthesize rotationView, timerLabel, mainTimer, statusLabel, resultsView, timerBtn, resultsRate, resultsTime, resultsTotal, identity, time, rate, mainRate, taskname, project_title, invoiceBtn, type, projectid;

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
	
	[[SIAlertView appearance] setMessageFont:[UIFont systemFontOfSize:13]];
    [[SIAlertView appearance] setTitleColor:[UIColor darkGrayColor]];
    [[SIAlertView appearance] setCornerRadius:12];
    [[SIAlertView appearance] setShadowRadius:20];
	
	timerCount = 0;
	timerRunning = false;
	animationRunning = false;
	
	[timerBtn setTitle:@"Start Timer" forState:UIControlStateNormal];

	if(timerCount == 0){
		timerCount = [time intValue];
	}
	
	if(![type isEqual: @"single"]) self.navigationItem.rightBarButtonItem = nil;
	
	if([taskname isEqual:NULL]) taskname = @"";
		
	[project_title setText:taskname];
		
	timerLabel.text = [NSString stringWithFormat:@"%@", [self formatTime:timerCount]];
	resultsTime.text = [NSString stringWithFormat:@"%@", [self formatTime:timerCount]];
	statusLabel.text = @"Tap here to start";
	
	[mainRate setText:[NSString stringWithFormat:@"€ %1$@ per hour", rate]];
	[resultsRate setText:[NSString stringWithFormat:@"€ %1$@ per hour", rate]];
	[resultsTotal setText:[self calculateTotal:[timerLabel text] :rate]];
	
	
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
	
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
-(void) stopSpinAnimation:(UIView *)view{
	[view.layer removeAnimationForKey:@"rotationAnimation"];
		
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timerClicked:(id)sender {
	
	if(timerRunning == false){
		
		mainTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(increaseTimerCount) userInfo:nil repeats:YES];
		[self resumeLayer:rotationView.layer];
		timerRunning = true;
		statusLabel.text = @"Counting...";
		[resultsView setHidden:TRUE];
		
		NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:~ NSTimeZoneCalendarUnit fromDate:[NSDate date]];
		startDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
				
	}else{
		
		[mainTimer invalidate];
		[self pauseLayer:rotationView.layer];
		timerRunning = false;
		statusLabel.text = @"Paused";
		[resultsView setHidden:FALSE];
		[resultsTime setText:[timerLabel text]];
		
		NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:~ NSTimeZoneCalendarUnit fromDate:[NSDate date]];
		endDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
				
		NSTimeInterval distanceBetweenDates = [endDate timeIntervalSinceDate: startDate];
		NSInteger result = distanceBetweenDates;
		
		NSMutableDictionary *record = [[NSMutableDictionary alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:startDate, endDate, [NSString stringWithFormat:@"%ld", (long)result], identity, nil] forKeys:[[NSMutableArray alloc] initWithObjects:@"start", @"end", @"difference", @"identity", nil]];
		
		NSUserDefaults *prefstemp = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
		
		NSMutableArray *records = [[NSMutableArray alloc] initWithArray:[prefstemp objectForKey:@"timestorage"] copyItems:YES];
		
		if(records == NULL) records = [[NSMutableArray alloc] init];
		
		[records addObject:record];
		
		[prefstemp setObject:records forKey:@"timestorage"];  //set the prev Array for key value "favourites"
		[prefstemp synchronize];
				
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

		[tt2 setValue:[self toSeconds:[timerLabel text]] forKey:@"timer"];
				
		NSMutableArray *tt3 = [[NSMutableArray alloc] initWithArray:[temp objectForKey:@"tasks"] copyItems:TRUE];
		
		[tt3 replaceObjectAtIndex:z withObject:tt2];
		
		[temp setObject:tt3 forKey:@"tasks"];
				
		[newstoragetemp replaceObjectAtIndex:y withObject:temp];
				
		[prefstemp setObject:newstoragetemp forKey:@"storage"];  //set the prev Array for key value "favourites"
		[prefstemp synchronize];
		
		[resultsTotal setText:[self calculateTotal:[timerLabel text] :rate]];
	}
	
}
- (void)increaseTimerCount
{
    timerLabel.text = [NSString stringWithFormat:@"%@", [self formatTime:timerCount++]];
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
		timerValue = timerValue - (hours*3600);
		
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

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
	
}

-(void)resumeLayer:(CALayer*)layer
{
	if(animationRunning == false){
		[self runSpinAnimationOnView:rotationView duration:1000.0f rotations:0.05f repeat:-10.0f];
		animationRunning = true;
		[timerBtn setTitle:@"Resume Timer" forState:UIControlStateNormal];
	}else{
		CFTimeInterval pausedTime = [layer timeOffset];
		layer.speed = 1.0;
		layer.timeOffset = 0.0;
		layer.beginTime = 0.0;
		CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
		layer.beginTime = timeSincePause;
	}
}
- (IBAction)summaryTimerBtn:(id)sender {
	[resultsView setHidden:TRUE];
	[self timerClicked:self];
}

-(NSString *)toSeconds:(NSString *)input{
	
	int cost = 0;
	
	input = [input stringByReplacingOccurrencesOfString:@":" withString:@""];
	
	cost += [[input substringFromIndex:[input length]-2] intValue];
	
	input = [input substringToIndex:[input length]-2];
	
	cost += 60*[[input substringFromIndex:[input length]-2] intValue];
	
	input = [input substringToIndex:[input length]-2];
	
	cost += 3600*[input doubleValue];

	return [NSString stringWithFormat:@"%1$d", cost];
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
	
	return [NSString stringWithFormat:@"€ %1$@", [[nf stringFromNumber:someNumber] substringFromIndex:1]];
}

- (IBAction)editInfo:(id)sender {
	
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"editView"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        EditTaskViewController *controller = (EditTaskViewController *)navController.topViewController;		
		controller.identity = identity;
		controller.price = rate;
		controller.taskname = taskname;
		controller.delegate = self;
    }else if([segue.identifier isEqualToString:@"clientList"]){
		
		UIViewController* controller = [segue destinationViewController];
		
		ClientListViewController* vc = (ClientListViewController *)controller;
		vc.projectId = projectid;
		
	}
}
-(void)didRecieveData:(NSString *)data{
	
}
-(void)didRecieveTheData:(NSString *)data :(NSString *)data2{
	
	rate = data;
	
	[project_title setText:data2];
	[mainRate setText:[NSString stringWithFormat:@"€ %1$@ per hour", rate]];
	[resultsRate setText:[NSString stringWithFormat:@"€ %1$@ per hour", rate]];
	[resultsTotal setText:[self calculateTotal:[timerLabel text] :rate]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0){
		[self alert1:@"Remove Task": @"" :identity];
	}else if(buttonIndex == 1){
		[self alert1:@"Remove Project" :projectid :@""];
	}
	
}

- (IBAction)removeTask:(id)sender {
	
	NSUserDefaults *prefstemp = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	
	NSMutableArray *storage = [[NSMutableArray alloc] initWithArray:[prefstemp objectForKey:@"storage"] copyItems:YES];
	NSMutableArray *tasks;
	int x = 0;
	for(int i = 0; i < [storage count]; i++){
		if(projectid == [[storage objectAtIndex:i] objectForKey:@"identity"]){
			tasks = [[NSMutableArray alloc] initWithArray:[[storage objectAtIndex:i] objectForKey:@"tasks"] copyItems:YES];
			x = i;
			break;
		}
		
	}
	
	if(![type isEqual: @"single"] && [tasks count] > 1){
		sheet = [[UIActionSheet alloc] initWithTitle:@""
										delegate:self
							   cancelButtonTitle:@"Cancel"
						  destructiveButtonTitle:nil
							   otherButtonTitles:@"Delete Task", @"Delete Project", nil];
	
		// Show the sheet
		[sheet showInView:self.view];
	}else{
		[self alert1:@"Remove Project" : projectid :@""];
	}
}

- (void)alert1:(NSString *)title :(NSString *)pid :(NSString *)tid
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:@"Removing this cannot be undone, are you sure?"];
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {

                          }];
    [alertView addButtonWithTitle:@"OK"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {

							  if([pid isEqual: @""]){
								  [self removeATask:tid];
							  }else if([tid isEqual: @""]){
								  [self removeAProject:pid];
							  }
        
                          }];
    alertView.titleColor = [UIColor darkGrayColor];
    alertView.cornerRadius = 5;
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView show];
}
-(void) removeATask:(NSString *)ident{

	NSUserDefaults *prefstemp = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	
	NSMutableArray *storage = [[NSMutableArray alloc] initWithArray:[prefstemp objectForKey:@"storage"] copyItems:YES];
	NSMutableArray *tasks;
	int x = 0;
	for(int i = 0; i < [storage count]; i++){
		if(projectid == [[storage objectAtIndex:i] objectForKey:@"identity"]){
			tasks = [[NSMutableArray alloc] initWithArray:[[storage objectAtIndex:i] objectForKey:@"tasks"] copyItems:YES];
			x = i;
			break;
		}
		
	}
	NSMutableArray *newsTasks = [[NSMutableArray alloc] init];
	for(int i = 0; i < [tasks count]; i++){
		if([[tasks objectAtIndex:i] objectForKey:@"identity"] != ident){
			[newsTasks addObject:[tasks objectAtIndex:i]];
		}
	}	
	NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithDictionary:[storage objectAtIndex:x] copyItems:YES];
	[temp setObject:newsTasks forKey:@"tasks"];
	[storage replaceObjectAtIndex:x withObject:temp];
		
	[prefstemp setObject:storage forKey:@"storage"];  //set the prev Array for key value "favourites"
	[prefstemp synchronize];
		
	NSMutableArray *records = [[NSMutableArray alloc] initWithArray:[prefstemp objectForKey:@"timestorage"] copyItems:YES];
	
	NSMutableArray *newrecords = [[NSMutableArray alloc] init];
	for(int i = 0; i < [records count]; i++){
		if([[records objectAtIndex:i] objectForKey:@"identity"] == ident){
			[newrecords removeObjectAtIndex:i];
		}
	}
	
	[prefstemp setObject:newrecords forKey:@"timestorage"];  //set the prev Array for key value "favourites"
	[prefstemp synchronize];
	
	
	[self.navigationController popViewControllerAnimated:YES];
	
}
-(void) removeAProject:(NSString *)ident{
	
	NSUserDefaults *prefstemp = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	
	NSMutableArray *storage = [[NSMutableArray alloc] initWithArray:[prefstemp objectForKey:@"storage"] copyItems:YES];
	
	NSMutableArray *newStore = [[NSMutableArray alloc] init];
	int z = 0;
	for(int i = 0; i < [storage count]; i++){
		if([[storage objectAtIndex:i] objectForKey:@"identity"] != ident){
			[newStore addObject:[storage objectAtIndex:i]];
			z = i;
		}
		
	}
	
	
	NSMutableArray *records = [[NSMutableArray alloc] initWithArray:[prefstemp objectForKey:@"timestorage"] copyItems:YES];
	
	NSMutableArray *newrecords = [[NSMutableArray alloc] initWithArray:records copyItems:YES];
	for(int x = 0; x < [[[storage objectAtIndex:z] objectForKey:@"tasks"] count]; x++){
		for(int i = 0; i < [records count]; i++){
			
			if([[records objectAtIndex:i] objectForKey:@"identity"] == [[[[storage objectAtIndex:z] objectForKey:@"tasks"] objectAtIndex:x] objectForKey:@"identity"]){
								
				[newrecords removeObjectAtIndex:i];
			}
		}
	}
		
	[prefstemp setObject:newrecords forKey:@"timestorage"];  //set the prev Array for key value "favourites"
	[prefstemp synchronize];
	
	[prefstemp setObject:newStore forKey:@"storage"];  //set the prev Array for key value "favourites"
	[prefstemp synchronize];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

@end
