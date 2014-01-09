//
//  TakePhotoViewController.h
//  Basin
//
//  Created by Lucien Constable on 9/20/12.
//
//

#import <UIKit/UIKit.h>

@interface TakePhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
-(IBAction)takePicture:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cameraButton;
@property (strong, nonatomic) IBOutlet UILabel *receiptSavedLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
