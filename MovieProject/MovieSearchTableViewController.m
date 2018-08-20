//
//  MovieSearchTableViewController.m
//  MovieProject
//
//  Created by Samana Tahir on 17/08/2018.
//  Copyright © 2018 Samana Tahir. All rights reserved.
//

#import "MovieSearchTableViewController.h"
#import "MovieSearchTableViewCell.h"
#import "MovieSearchLoadingTableViewCell.h"

@implementation MovieSearchTableViewController

@synthesize searchBar;
@synthesize moviesDataArray;

#pragma mark - Table view data source
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.moviesDataArray count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.moviesDataArray count] == 0){
        static NSString *cellIdentifier = @"MovieSearchLoadingTableViewCell";
        MovieSearchLoadingTableViewCell *cell = (MovieSearchLoadingTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil){
            cell = [[MovieSearchLoadingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.activityIndicator.hidden = YES;
        cell.errorMsgLbl.hidden = NO;
        cell.errorMsgLbl.text = @"No results found for searched term";
        return cell;
    }
    static NSString *cellIdentifier = @"MovieSearchTableViewCell";
    MovieSearchTableViewCell *cell = (MovieSearchTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[MovieSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    MovieMetaData *metaData = self.moviesDataArray[indexPath.row];
    cell.movieTitle.text = metaData.title;
    cell.movieDescription.text = metaData.overview;
    cell.ratingLabel.text = [NSString stringWithFormat:@"%0.2f",metaData.vote_average];
    if(metaData.poster_path.length > 0){
        [self.moviesDataFetcher getImageFromPath:metaData.poster_path withSize:PosterSize_w92 withBlock:^(NSString *imagePath) {
            cell.moviePoster.image = nil; // or cell.poster.image = [UIImage imageNamed:@"placeholder.png"];
            
            
            NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:imagePath] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (data) {
                    UIImage *image = [UIImage imageWithData:data];
                    if (image) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                                cell.moviePoster.image = image;
                        });
                    }
                }
            }];
            [task resume];
        }];
    }else{
        cell.moviePoster.image = [UIImage imageNamed:@"placeholder-small"];
    }
    return cell;
}

#pragma mark - MovieDataFetcherDelegate
-(void) MovieDataFetcher:(MovieDataFetcherList *)dataFetcher didExtractData:(NSArray *)dataArray forPageNo:(int)pageNo withMaxAvailablePages:(int)totalAvailablePages
{
    dispatch_async(dispatch_get_main_queue(), ^{
        isSearching = NO;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.moviesDataArray addObjectsFromArray:dataArray];
        [self.tableView reloadData];
    });
}

#pragma mark - Search Display Controller
-(void) searchForKeyword:(NSString *)keyword
{    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.moviesDataFetcher = [[MovieDataFetcherList alloc] init];
    self.moviesDataFetcher.delegate = self;
    [self.moviesDataFetcher searchTMDBForQuery:keyword withPageNo:1];
}

-(void) clearPreviousSearchResultsAndCalls
{
    self.moviesDataFetcher.delegate = nil;
    self.moviesDataFetcher = nil;
    [self.moviesDataArray removeAllObjects];
    [self.tableView reloadData];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    // Do the search...
    isSearching = YES;
    [self clearPreviousSearchResultsAndCalls];
    if(searchBar.text.length > 0)
    {
        [self performSelector:@selector(searchForKeyword:) withObject:searchBar.text afterDelay:0.25];
    }
    
}
#pragma mark - View Life Cycle
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        isSearching = YES;
        [self clearPreviousSearchResultsAndCalls];
        if(self.searchBar.text.length > 0)
        {
            [self searchForKeyword:self.searchBar.text];
        }
        [self.tableView reloadData];
}
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollsToTop = YES;
    self.tableView.rowHeight = 100;
    self.moviesDataArray = [NSMutableArray array];
}
-(void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end





