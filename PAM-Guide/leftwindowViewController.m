//
//  leftwindowViewController.m
//  PAM-Guide
//
//  Created by Arie on 6/18/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import "leftwindowViewController.h"

@interface leftwindowViewController ()

@end

@implementation leftwindowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pam-iphone5-bg-01-320x568"]];
		
		leftMenu=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, self.view.frame.size.height-300)];
		leftMenu.backgroundColor=[UIColor clearColor];
		leftMenu.separatorColor=[UIColor colorWithRed:0 green:0.314 blue:0.357 alpha:1];
		leftMenu.delegate=self;
		leftMenu.dataSource=self;
		[self.view addSubview:leftMenu];
		
		NSDictionary *dTmp= [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"leftWindow" ofType:@"plist"]];
		self.arrayOriginal=[dTmp valueForKey:@"Object"];
		
		self.arForTable=[[NSMutableArray alloc] init];
		[self.arForTable addObjectsFromArray:self.arrayOriginal];
        // Custom initialization
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arForTable count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UILabel *label_top=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 45)];
	label_top.backgroundColor=[UIColor clearColor];
	label_top.text=@"MENU";
	label_top.textColor=[UIColor whiteColor];
	label_top.textAlignment=NSTextAlignmentCenter;
	label_top.font=[UIFont fontWithName:@"HelveticaNeue" size:30];
	
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    headerView.backgroundColor = [UIColor clearColor];
	
	[headerView addSubview:label_top];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 44;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
	    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
    // Set up the cell...
	NSString *cellValue = [[self.arForTable objectAtIndex:indexPath.row]objectForKey:@"name"];
	cell.textLabel.text=cellValue;
    NSString * myTag;
    myTag = [[self.arForTable objectAtIndex:indexPath.row] objectForKey:@"tag"];
    	//[self jumper:cellValue];
	//[cell.contentRightImage setImage:[UIImage imageNamed:cellValue]];
	UIView *selectionColor = [[UIView alloc] init];
	selectionColor.backgroundColor =[UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1];
    cell.selectedBackgroundView = selectionColor;
	
	
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
	
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	NSString *cellValue = [[self.arForTable objectAtIndex:indexPath.row]objectForKey:@"name"];
		//[self jumper:cell.textLabel.text];
	NSDictionary *d=[self.arForTable objectAtIndex:indexPath.row];
	
	
	
	
	if([d valueForKey:@"Object"]) {
		NSArray *ar=[d valueForKey:@"Object"];
		
		BOOL isAlreadyInserted=NO;
		
		for(NSDictionary *dInner in ar ){
			NSInteger index=[self.arForTable indexOfObjectIdenticalTo:dInner];
			
			isAlreadyInserted=(index>0 && index!=NSIntegerMax);
			if(isAlreadyInserted) break;
			
			
		}
		
		if(isAlreadyInserted) {
			[self miniMizeThisRows:ar];
		} else {
			NSLog(@"123");
			NSUInteger count=indexPath.row+1;
			NSMutableArray *arCells=[NSMutableArray array];
			for(NSDictionary *dInner in ar ) {
				[arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
				
				[self.arForTable insertObject:dInner atIndex:count++];
				
			}
			[tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
			tableView.tag=[arCells objectAtIndex:0];
			
			
		}
	}
	
	
	
	
}
-(void)miniMizeThisRows:(NSArray*)ar{
	NSLog(@"ar-->%@",ar);
	for(NSDictionary *dInner in ar ) {
		NSUInteger indexToRemove=[self.arForTable indexOfObjectIdenticalTo:dInner];
		NSArray *arInner=[dInner valueForKey:@"Objects"];
		if(arInner && [arInner count]>0){
			[self miniMizeThisRows:arInner];
		}
		
		if([self.arForTable indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
			[self.arForTable removeObjectIdenticalTo:dInner];
			[leftMenu deleteRowsAtIndexPaths:[NSArray arrayWithObject:
												   [NSIndexPath indexPathForRow:indexToRemove inSection:0]
												   ]
								 withRowAnimation:UITableViewRowAnimationRight];
		}
	}
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

@end
