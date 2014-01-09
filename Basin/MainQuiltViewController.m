//
//  MainQuiltViewController.m
//  Basin
//
//  Created by Lucien Constable on 12/13/12.
//
//

// Credit to TMQuiltView

#import <QuartzCore/QuartzCore.h>
#import "MainQuiltViewController.h"
#import "MainQuiltViewCell.h"
#import "TMQuiltView.h"
#import "WebViewController.h"
#import "UIImageExtras.h"

const NSInteger kNumberOfCells = 1000;

@interface MainQuiltViewController ()

@property (nonatomic, retain) NSArray *images;

@property (nonatomic, retain) NSMutableDictionary *promotions;
@property (nonatomic, retain) NSMutableArray *promoImages;
@property (nonatomic, retain) NSMutableArray *promoStores;
@property (nonatomic, retain) NSMutableArray *promoStrings;
@property (nonatomic, retain) NSMutableArray *promoURLs;

@end

@implementation MainQuiltViewController

@synthesize images = _images;

@synthesize promotions;
@synthesize promoImages;
@synthesize promoStores;
@synthesize promoStrings;
@synthesize promoURLs;

/*
-(void)dealloc 
    [_images release], _images = nil;
    [super dealloc];
}
*/


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.quiltView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"quiltBackground.png"]];
    
    // add drop shadow to top and bottom
    CAGradientLayer *topScrollGradient = [CAGradientLayer layer];
    [topScrollGradient setFrame:CGRectMake(0, 0, 320, 4)];
    topScrollGradient.colors = [NSArray arrayWithObjects:
                                (id)[[[UIColor darkGrayColor] colorWithAlphaComponent:0.6f] CGColor],
                                (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3f] CGColor],
                                (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1f] CGColor],
                                (id)[[UIColor clearColor] CGColor],
                                nil];
    
    [self.view.layer addSublayer:topScrollGradient];
    
    // load data from plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PromotionList"
                                                     ofType:@"plist"];
    NSDictionary *promotionInfo = [NSDictionary dictionaryWithContentsOfFile:path];
    promotions = [promotionInfo objectForKey:@"promotions"];
    
    promoImages = [[NSMutableArray alloc] init];
    promoStores  = [[NSMutableArray alloc] init];
    promoStrings = [[NSMutableArray alloc] init];
    promoURLs = [[NSMutableArray alloc] init];
    
    promoImages = [promotions objectForKey:@"promoImages"];
    promoStores = [promotions objectForKey:@"promoStores"];
    promoStrings = [promotions objectForKey:@"promoStrings"];
    promoURLs = [promotions objectForKey:@"promoURLs"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

#pragma mark - QuiltViewControllerDataSource

- (NSArray *)images {
    
    if (!_images) {

        _images = promoImages;
        
    }
    return _images;
}

- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    return [self.images count];
}

- (MainQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    MainQuiltViewCell *cell = (MainQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
    if (!cell) {
        cell = [[MainQuiltViewCell alloc] initWithReuseIdentifier:@"PhotoCell"];
    }
    
// corresponds to layoutSubviews in MainQuiltViewCell.m
    cell.photoView.image = [self imageAtIndexPath:indexPath];
    //    cell.photoView.image = [[self imageAtIndexPath:indexPath] imageByScalingAndCroppingForSize:CGSizeMake(cell.bounds.size.width, cell.bounds.size.height - 60)];
    
    // load data from plist

    NSString *pString = [promoStrings objectAtIndex:indexPath.row];
    NSString *pStore = [promoStores objectAtIndex:indexPath.row];
    
    cell.titleLabel.numberOfLines = 4;
    cell.titleLabel.text = [[pString stringByAppendingString:@"\n  -"] stringByAppendingString:pStore];
    
    cell.layer.cornerRadius = 5.0;
    cell.layer.masksToBounds = YES;
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = [UIColor grayColor].CGColor;

    return cell;
 
}

#pragma mark - TMQuiltViewDelegate

- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
    return 2;
}

- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath {

    return 60 + [self imageAtIndexPath:indexPath].size.height / [self quiltViewNumberOfColumns:quiltView];

}

- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    WebViewController *destViewController  = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    destViewController.urlText = [promoURLs objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:destViewController animated:YES];

}

@end
