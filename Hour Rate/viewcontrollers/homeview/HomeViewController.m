//
//  HomeViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 28/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"

#import "TimerViewController.h"
#import "TaskViewController.h"

@interface HomeViewController (){
	NSUserDefaults *prefs;
	NSMutableArray *storage;
}

@end

@implementation HomeViewController
@synthesize projectTable;


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
	
//	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
//	[self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
	
//	UIImage *backButtonImage = [[UIImage imageNamed:@"bg-icon.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//	UIImage *barButtonImage = [[UIImage imageNamed:@"bg-icon.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
//    [[UIBarButtonItem appearance] setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//	
//	[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
//	[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
	
	
//	[self.navigationItem.rightBarButtonItem setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//	[self.navigationItem.leftBarButtonItem setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
	
	NSMutableDictionary *userst = [[NSMutableDictionary alloc] initWithDictionary:[prefs objectForKey:@"userinfo"] copyItems:YES];
	if(![userst objectForKey:@"name"]){
		userst = [[NSMutableDictionary alloc] initWithObjects:[[NSMutableArray alloc] initWithObjects:@"User name", [[NSMutableArray alloc] initWithObjects:@"street", @"other", @"city", @"country", @"phone", nil], @"€", @"21", nil] forKeys:[[NSMutableArray alloc] initWithObjects:@"name", @"address", @"currency", @"tax", nil]];
	}
	
	[prefs setObject:userst forKey:@"userinfo"];  //set the prev Array for key value "favourites"
	[prefs synchronize];
	
	prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	storage = [prefs objectForKey:@"storage"];
	
	//set
	
	if([storage count] < 1){
		
		NSMutableArray *records = [[NSMutableArray alloc] init];
		
		[prefs setObject:records forKey:@"timestorage"];  //set the prev Array for key value "favourites"
		[prefs synchronize];
		
		
		
		NSMutableDictionary *project = [[NSMutableDictionary alloc] initWithObjects:
								 [[NSMutableArray alloc] initWithObjects:@"single", @"Small Project", @"11", [[NSMutableArray alloc] initWithObjects: [[NSMutableDictionary alloc] initWithObjects:
																																				[[NSMutableArray alloc] initWithObjects:@"Small Project", @"001234", @"5.00", @"11", nil] forKeys:
																																				[[NSMutableArray alloc] initWithObjects:@"task_name", @"timer", @"rate", @"identity", nil]], nil], nil] forKeys:
							 [[NSMutableArray alloc] initWithObjects:@"type", @"project_name",  @"identity", @"tasks", nil]];
		
		NSMutableDictionary *project2 = [[NSMutableDictionary alloc] initWithObjects:
								  [[NSMutableArray alloc] initWithObjects:@"multiple", @"Big Project", @"2p", [[NSMutableArray alloc] initWithObjects:
						[[NSMutableDictionary alloc] initWithObjects:	[[NSMutableArray alloc] initWithObjects:@"name", @"000000", @"5.00", @"1", nil]
													forKeys:	[[NSMutableArray alloc] initWithObjects:@"task_name", @"timer", @"rate", @"identity", nil]],
																										
						[[NSMutableDictionary alloc] initWithObjects:	[[NSMutableArray alloc] initWithObjects:@"name2", @"000000", @"15.00", @"2", nil]
													forKeys:	[[NSMutableArray alloc] initWithObjects:@"task_name", @"timer", @"rate", @"identity", nil]],
																										
																										nil],
								   
								   nil]
								forKeys:	[[NSMutableArray alloc] initWithObjects:@"type", @"project_name", @"identity", @"tasks", nil]];
	
	
		storage = [[NSMutableArray alloc] initWithObjects:project, project2, nil];
		[prefs setObject:storage forKey:@"storage"];  //set the prev Array for key value "favourites"
		[prefs synchronize];
		
	}
		
}

-(void)viewDidAppear:(BOOL)animated{
	
	prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	storage = [prefs objectForKey:@"storage"];
		
	[projectTable reloadData];
	
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

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

	NSString *cellId = @"ProjectCell";
	HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil) {
		cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
	}
	
	cell.identity = [[storage objectAtIndex:indexPath.row] objectForKey:@"identity"];
	cell.cellLabel.text = [[storage objectAtIndex:indexPath.row] objectForKey:@"project_name"];
	cell.projectId = [[storage objectAtIndex:indexPath.row] objectForKey:@"identity"];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([[[storage objectAtIndex:indexPath.row] objectForKey:@"type"] isEqual: @"multiple"]){
		
		TaskViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"taskView"];
		vc.identity = [[storage objectAtIndex:indexPath.row] objectForKey:@"identity"];
		// Push the view controller and make it animated
		[self.navigationController pushViewController:vc animated:YES];
		
	}else{
		TimerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"timerView"];
		vc.identity = [[[[storage objectAtIndex:indexPath.row] objectForKey:@"tasks"] objectAtIndex:0] objectForKey:@"identity"];
		
		vc.time = [[[[storage objectAtIndex:indexPath.row] objectForKey:@"tasks"] objectAtIndex:0] objectForKey:@"timer"];
		vc.rate = [[[[storage objectAtIndex:indexPath.row] objectForKey:@"tasks"] objectAtIndex:0] objectForKey:@"rate"];
		vc.taskname = [[[[storage objectAtIndex:indexPath.row] objectForKey:@"tasks"] objectAtIndex:0] objectForKey:@"task_name"];
		vc.type = @"single";
		vc.projectid = [[storage objectAtIndex:indexPath.row] objectForKey:@"identity"];
		
		// Push the view controller and make it animated
		[self.navigationController pushViewController:vc animated:YES];
	}
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
		
	return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

	HomeCell *cell = (HomeCell *)[projectTable cellForRowAtIndexPath:indexPath];
	
	[self deleteProject:cell.identity];
	
}

-(void) deleteProject:(NSString *)identity{
	
	NSUserDefaults *prefstemp = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	NSMutableArray *storagetemp = [prefstemp objectForKey:@"storage"];
	
	NSMutableArray *newStoragetemp = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < [storagetemp count]; i++) {
		
		if(![[[storagetemp objectAtIndex:i] objectForKey:@"identity"] isEqual:identity]){
			[newStoragetemp addObject:[storagetemp objectAtIndex:i]];
		}
		
	}
	
	[prefstemp setObject:newStoragetemp forKey:@"storage"];  //set the prev Array for key value "favourites"
	[prefstemp synchronize];
	
	storage = newStoragetemp;
	
	[projectTable reloadData];
	
}



@end
