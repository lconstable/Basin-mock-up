//
//  ChooseCardViewController.h
//  Basin
//
//  Created by Lucien Constable on 9/30/12.
//
//

#import <UIKit/UIKit.h>

@interface ChooseCardViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *cardData;
    NSString *chosenCard;
}

@property (strong, nonatomic) IBOutlet UITableView *cardTableView;
@property (strong, nonatomic) NSMutableArray *cardData;
@property (strong, nonatomic) NSString *chosenCard;

-(void)popViewRightToLeft;

@end
