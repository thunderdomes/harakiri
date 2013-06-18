//
//  leftwindowViewController.h
//  PAM-Guide
//
//  Created by Arie on 6/18/13.
//  Copyright (c) 2013 Dave Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface leftwindowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
	UITableView *leftMenu;
	UIButton *pam_login_Nasabah;
	UIButton *pam_login_mitra;
	
}
@property (nonatomic, retain) NSArray *arrayOriginal;
@property (nonatomic, retain) NSMutableArray *arForTable;
@end
