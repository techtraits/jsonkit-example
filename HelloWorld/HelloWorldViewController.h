//
//  HelloWorldViewController.h
//  HelloWorld
//
//  Created by Usman Ismail on 11-06-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloWorldViewController : UIViewController {
    IBOutlet UIButton *button;
    IBOutlet UILabel *label;
    IBOutlet UIView *myView;    
}


@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIView *myView;

@end
