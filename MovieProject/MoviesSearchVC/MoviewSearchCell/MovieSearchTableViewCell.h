//
//  MovieSearchTableViewCell.h
//  MovieProject
//
//  Created by Samana Tahir on 17/08/2018.
//  Copyright © 2018 Samana Tahir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieSearchTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *moviePoster;
@property (nonatomic, weak) IBOutlet UILabel *movieTitle;
@property (nonatomic, weak) IBOutlet UILabel *movieDescription;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;

@end
