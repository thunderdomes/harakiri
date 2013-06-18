//
//  LeftSidebarViewController.m
//  JTRevealSidebarDemo
//
//  Created by James Apple Tang on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SidebarViewController.h"


@implementation SidebarViewController
@synthesize sidebarDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    listOfItems = [[NSMutableArray alloc] init];
    
    NSArray *tradingCentralArray = [NSArray arrayWithObjects:@"LiveTrading", @"Stock Watch", @"Stock Quote", @"Broker Rank", @"Complete Book", @"Charts", @"Research", @"Index", nil];
	NSDictionary *tradingCentralDic = [NSDictionary dictionaryWithObject:tradingCentralArray forKey:@"tradingcentralmenu"];
    
    NSArray *informationArray = [NSArray arrayWithObjects:@"Companies", @"Corporate Action", @"Highlight", nil];
	NSDictionary *informationDic = [NSDictionary dictionaryWithObject:informationArray forKey:@"informationmenu"];
    
    NSArray *aboutArray = [NSArray arrayWithObjects:@"Manual Book", @"Contact Us",nil];
	NSDictionary *aboutDic = [NSDictionary dictionaryWithObject:aboutArray forKey:@"aboutmenu"];
    
    [listOfItems addObject:tradingCentralDic];
    [listOfItems addObject:informationDic];
    [listOfItems addObject:aboutDic];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([self.sidebarDelegate respondsToSelector:@selector(lastSelectedIndexPathForSidebarViewController:)]) {
        NSIndexPath *indexPath = [self.sidebarDelegate lastSelectedIndexPathForSidebarViewController:self];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pam-iphone5-bg-01-320x568.png"]];
        [tempImageView setFrame:self.tableView.frame];
        
        self.tableView.backgroundView = tempImageView;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 return 5;
//    switch (section) {
//        case 0: return 8;
//        case 1: return 3;
//        case 2: return 1;
//        case 3: return 1;
//        case 4: return 1;
//        case 5: return 2;
//       default: return 1;
//    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 1)
    {
   // cell.textLabel.text = [NSString stringWithFormat:@"ViewController%d", indexPath.row];
        NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"tradingcentralmenu"];
        NSString *cellValue = [array objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:@"Eurostile ST Ltd" size:12];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = cellValue;

    } else if(indexPath.section == 1)
    {
        // cell.textLabel.text = [NSString stringWithFormat:@"ViewController%d", indexPath.row];
        NSDictionary *dictionary = [listOfItems objectAtIndex:indexPath.section];
        NSArray *array = [dictionary objectForKey:@"informationmenu"];
        NSString *cellValue = [array objectAtIndex:indexPath.row];
         cell.textLabel.font = [UIFont fontWithName:@"Eurostile ST Ltd" size:12];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = cellValue;
        
    }else if (indexPath.section == 2)
    {
        cell.textLabel.font = [UIFont fontWithName:@"Eurostile ST Ltd" size:12];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = @"Account Setting";
        
    }else if (indexPath.section == 3)
    {
        cell.textLabel.font = [UIFont fontWithName:@"Eurostile ST Ltd" size:12];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = @"Portfolio";
        
    }else if (indexPath.section == 4)
    {
        cell.textLabel.font = [UIFont fontWithName:@"Eurostile ST Ltd" size:12];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = @"Trade";
        
    }
    else if (indexPath.section == 5)
    {
        NSDictionary *dictionary = [listOfItems objectAtIndex:2];
        NSArray *array = [dictionary objectForKey:@"aboutmenu"];
        NSString *cellValue = [array objectAtIndex:indexPath.row];
         cell.textLabel.font = [UIFont fontWithName:@"Eurostile ST Ltd" size:12];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = cellValue;

    }
    else {
         cell.textLabel.font = [UIFont fontWithName:@"Eurostile ST Ltd" size:12];
        cell.textLabel.textColor = [UIColor whiteColor];
        //cell.textLabel.text = @"Logout";
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //return self.title;
   
    if(section == 0)
        return @"MENU";
    else if(section == 1){
        return @"INFORMATION";
    }else if(section == 2){
        return @"MY ACCOUNT";
    }else if(section == 3){
        return @"PORTFOLIO "; //portfolio
    }else if(section == 4){
        return @"TRADE ";//trade
    }else if(section == 5){
        return @"ABOUT";
    }
    else
        return @" ";//logout
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sidebarDelegate) {
        NSObject *object = [NSString stringWithFormat:@"ViewController%d", indexPath.row];
        [self.sidebarDelegate sidebarViewController:self didSelectObject:object atIndexPath:indexPath];
    }
}

@end
