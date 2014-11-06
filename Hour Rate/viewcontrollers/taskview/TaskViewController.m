//
//  TaskViewController.m
//  Hour Rate
//
//  Created by Stephen Kerr on 29/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "TaskViewController.h"
#import "HomeCell.h"

#import "AddTaskViewController.h"
#import "TimerViewController.h"
#import "ClientListViewController.h"

@interface TaskViewController (){
	NSUserDefaults *prefs;
	NSMutableArray *storage;
	NSDictionary *current;
}

@end

@implementation TaskViewController
@synthesize identity, project_name, taskTable;

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
	
	prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	storage = [prefs objectForKey:@"storage"];
	
	for(int i = 0; i < [storage count]; i++){
		
		if([[storage objectAtIndex:i] objectForKey:@"identity"] == identity){
			current = [storage objectAtIndex:i];
		}
		
	}

	[project_name setText:[current objectForKey:@"project_name"]];
	
	project_name.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
	
	prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	storage = [prefs objectForKey:@"storage"];
	
	for(int i = 0; i < [storage count]; i++){
		
		if([[storage objectAtIndex:i] objectForKey:@"identity"] == identity){
			current = [storage objectAtIndex:i];
		}
		
	}
	
	[project_name setText:[current objectForKey:@"project_name"]];
	[self.taskTable reloadData];
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
	return [[current objectForKey:@"tasks"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSString *cellId = @"ProjectCell";
	HomeCell *cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil) {
		cell = [[HomeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
	}
	
	cell.cellLabel.text = [[[current objectForKey:@"tasks"] objectAtIndex:indexPath.row] objectForKey:@"task_name"];
	cell.identity = [[[current objectForKey:@"tasks"] objectAtIndex:indexPath.row] objectForKey:@"identity"];
		
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	TimerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"timerView"];
	
	vc.identity = [[[current objectForKey:@"tasks"] objectAtIndex:indexPath.row] objectForKey:@"identity"];

	vc.time = [[[current objectForKey:@"tasks"] objectAtIndex:indexPath.row] objectForKey:@"timer"];
	vc.rate = [[[current objectForKey:@"tasks"] objectAtIndex:indexPath.row] objectForKey:@"rate"];
	vc.taskname = [[[current objectForKey:@"tasks"] objectAtIndex:indexPath.row] objectForKey:@"task_name"];
	vc.type = @"multiple";
	
	vc.projectid = [current objectForKey:@"identity"];
	
	// Push the view controller and make it animated
	[self.navigationController pushViewController:vc animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"openTasker"]){
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        AddTaskViewController *controller = (AddTaskViewController *)navController.topViewController;
        controller.identity = identity;
    }else if([segue.identifier isEqualToString:@"clientListTask"]){
		
		UIViewController* controller = [segue destinationViewController];
		
		ClientListViewController* vc = (ClientListViewController *)controller;
		vc.projectId = [current objectForKey:@"identity"];
	}
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
	
	NSUserDefaults *prefstemp = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	NSMutableArray *storagetemp = [prefstemp objectForKey:@"storage"];
	
	NSMutableArray *newstoragetemp = [[NSMutableArray alloc] initWithArray:storagetemp copyItems:YES];
	NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
	
	for (int i = 0; i < [storagetemp count]; i++) {
		
		if([[[storagetemp objectAtIndex:i] objectForKey:@"identity"] isEqual:identity]){
			
			temp = [[NSMutableDictionary alloc] initWithDictionary:[storagetemp objectAtIndex:i] copyItems:TRUE];
			[temp setObject:[project_name text] forKey:@"project_name"];
			[newstoragetemp replaceObjectAtIndex:i withObject:temp];
			
			break;
		}
		
	}
	
	[prefstemp setObject:newstoragetemp forKey:@"storage"];  //set the prev Array for key value "favourites"
	[prefstemp synchronize];
	
	
	
    return YES;
}



@end
