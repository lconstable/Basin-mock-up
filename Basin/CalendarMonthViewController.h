//
//  CalendarMonthViewController.h
//  Basin
//
//  Created by Lucien Constable on 3/20/13.
//
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"

@interface CalendarMonthViewController : UIViewController <TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource, UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate> {
	TKCalendarMonthView *calendar;
}

@property (strong, nonatomic) IBOutlet UITableView *markTable;

@property (strong, retain) TKCalendarMonthView *calendar;
@property (strong, retain) NSString *selectedEventString;
@property (strong, retain) NSDate *selectedDate;
@property (strong, retain) NSMutableArray *dateArray;
@property (strong, retain) NSMutableArray *markArray;
@property (strong, retain) NSMutableDictionary *markDictionary;

- (IBAction)plusPressed:(id)sender;
- (IBAction)actionPressed:(id)sender;

@end
