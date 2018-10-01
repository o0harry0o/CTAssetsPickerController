/*
 
 MIT License (MIT)
 
 Copyright (c) 2015 Clement CN Tsang
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "CTPhotosViewController.h"


@implementation CTPhotosViewController

- (void)pickAssets:(id)sender
{
    [self showSelectAlert:^(int selection) {
        if(selection == 0)
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // init picker
                    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                    
                    // set delegate
                    picker.delegate = self;
                    picker.defaultAssetCollection = PHAssetCollectionSubtypeSmartAlbumUserLibrary;
                    // create options for fetching photo only
                    PHFetchOptions *fetchOptions = [PHFetchOptions new];
                    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeImage];
                    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"duration" ascending:NO]];
                    // assign options
                    picker.assetsFetchOptions = fetchOptions;
                    
                    // to present picker as a form sheet in iPad
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        picker.modalPresentationStyle = UIModalPresentationFormSheet;
                    
                    // present picker
                    [self presentViewController:picker animated:YES completion:nil];
                    
                });
            }];
        }
        else if(selection == 1)
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // init picker
                    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                    
                    // set delegate
                    picker.delegate = self;
                    picker.defaultAssetCollection = PHAssetCollectionSubtypeSmartAlbumUserLibrary;
                    // create options for fetching photo only
                    PHFetchOptions *fetchOptions = [PHFetchOptions new];
                    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeVideo];
                    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"duration" ascending:NO]];
                    // assign options
                    picker.assetsFetchOptions = fetchOptions;
                    
                    // to present picker as a form sheet in iPad
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        picker.modalPresentationStyle = UIModalPresentationFormSheet;
                    
                    // present picker
                    [self presentViewController:picker animated:YES completion:nil];
                    
                });
            }];
        }
    } sender:sender];
    
}
#pragma mark Action Sheet
- (void)showSelectAlert:(void (^ __nullable)(int))completion sender:(id)sender
{
    UIView* button = sender;
    if([sender isKindOfClass:[UIBarButtonItem class]])
    {
        button = [sender customView];
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"File Type"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction*  cancelAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              completion(-1);
                                                          }];
    UIAlertAction*  photoAction = [UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             completion(0);
                                                         }];
    UIAlertAction*  videoAction = [UIAlertAction actionWithTitle:@"Video" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            completion(1);
                                                        }];
    

    [alert addAction:photoAction];
    [alert addAction:videoAction];
    [alert addAction:cancelAction];
    alert.popoverPresentationController.sourceView = button;
    [alert.popoverPresentationController setPermittedArrowDirections:UIPopoverArrowDirectionUp];
    alert.popoverPresentationController.sourceRect = CGRectMake(button.bounds.size.width/2, button.bounds.size.height-25, 1.0, 1.0);
    [self presentViewController:alert animated:YES completion:nil];
}
@end
