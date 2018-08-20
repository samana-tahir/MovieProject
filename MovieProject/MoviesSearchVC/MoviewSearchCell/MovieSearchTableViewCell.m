//
//  MovieSearchTableViewCell.m
//  MovieProject
//
//  Created by Samana Tahir on 17/08/2018.
//  Copyright © 2018 Samana Tahir. All rights reserved.
//

#import "MovieSearchTableViewCell.h"

@implementation MovieSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(15, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
    separatorLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:separatorLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
