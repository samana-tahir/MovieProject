//
//  MovieSearchLoadingTableViewCell.h
//  MovieProject
//
//  Created by Samana Tahir on 17/08/2018.
//  Copyright © 2018 Samana Tahir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieSearchLoadingTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) IBOutlet UILabel *errorMsgLbl;

@end
