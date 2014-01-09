//
//  TakePhotoViewController.m
//  Basin
//
//  Created by Lucien Constable on 9/20/12.
//
//

#import "TakePhotoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TakePhotoViewController ()

@end

@implementation TakePhotoViewController
@synthesize cameraButton;
@synthesize receiptSavedLabel;
@synthesize imageView;

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
    
    // set label and button
    receiptSavedLabel.hidden = YES;
    receiptSavedLabel.font = [UIFont fontWithName:@"ProximaNova-Regular" size:17];
    cameraButton.layer.cornerRadius = 10.0f;
    cameraButton.layer.masksToBounds = YES;
    cameraButton.layer.borderColor = [UIColor blackColor].CGColor;
    cameraButton.layer.borderWidth = 1.0;

    UIImage *rawNormalImage = [UIImage imageNamed:@"buttonSelected.png"];
    UIImage *rawHighlightedImage = [UIImage imageNamed:@"buttonNormal70.png"];
    UIImage *rawSelectedImage = [UIImage imageNamed:@"buttonNormal70.png"];
    UIImage *buttonNormalImage = [rawNormalImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 1, 0)];
    UIImage *buttonHighlightedImage = [rawHighlightedImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 1, 0)];
    UIImage *buttonSelectedImage = [rawSelectedImage resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 1, 0)];
    
    [cameraButton setBackgroundImage:buttonNormalImage forState:UIControlStateNormal];
    [cameraButton setBackgroundImage:buttonHighlightedImage forState:UIControlStateHighlighted];
    [cameraButton setBackgroundImage:buttonSelectedImage forState:UIControlStateSelected];
    
    // add drop shadow to top
    CAGradientLayer *topGradient = [CAGradientLayer layer];
    [topGradient setFrame:CGRectMake(0, 0, 320, 4)];
    topGradient.colors = [NSArray arrayWithObjects:
                          (id)[[[UIColor darkGrayColor] colorWithAlphaComponent:0.6f] CGColor],
                          (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3f] CGColor],
                          (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1f] CGColor],
                          (id)[[UIColor clearColor] CGColor],
                          nil];
    [self.view.layer addSublayer:topGradient];
    
    // set the navigationItem's titleView to BasinNavBarIcon.png
//    UIImage *navigationBarImage = [UIImage imageNamed:@"BasinNavBarIcon.png"];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:navigationBarImage];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setCameraButton:nil];
    [self setReceiptSavedLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#warning replace with API to encode receipt, then customize save/retake -- if save, upload to server and pop back to MainViewController
-(IBAction) takePicture:(id) sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentModalViewController:imagePicker animated:YES];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
     // UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    [self.imageView setImage:image];
    
    // hide camera button when there is an image
    if (imageView.image != nil) {
        cameraButton.hidden = YES;
        receiptSavedLabel.hidden = NO;
    }
    
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    [self dismissModalViewControllerAnimated:YES];
}

@end