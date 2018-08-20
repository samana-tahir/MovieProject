//
//  MovieSearchTableViewController.h
//  MovieProject
//
//  Created by Samana Tahir on 17/08/2018.
//  Copyright © 2018 Samana Tahir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MovieProjectAPI/MovieDataFetcherList.h>
#import <MovieProjectAPI/MovieConstants.h>


@interface MovieSearchTableViewController : UITableViewController<MovieDataFetcherDelegate>
{
    BOOL isSearching;
}

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) MovieDataFetcherList *moviesDataFetcher;
@property (nonatomic, strong) NSMutableArray *moviesDataArray;

@end
