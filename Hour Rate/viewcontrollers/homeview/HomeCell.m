//
//  HomeCell.m
//  Hour Rate
//
//  Created by Stephen Kerr on 28/05/2013.
//  Copyright (c) 2013 Xzien. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

@synthesize identity, cellBg, cellLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
