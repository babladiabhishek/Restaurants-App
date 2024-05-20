Restaurants App

This application presents a list of restaurants fetched from an API. It includes features to view restaurant details, apply multiple filters, and dynamically update the list based on selected filters.

Features

List of Restaurants: Display a list of restaurants fetched from the API.
Restaurant Details: Tap on a restaurant card to open a detailed view showing the restaurant's status (open or closed).
Filters: Fetch and display filters in a horizontal list. Filters can be selected to refine the list of restaurants based on the tags.
Usage

Restaurant List
The main screen displays a list of restaurants.
Each restaurant card contains basic information about the restaurant.
Restaurant Details
Tap on a restaurant card to open a detailed view.
The detail view displays whether the restaurant is open or closed.
Filters
Filters are fetched from the provided URL and displayed in a horizontal list.
Select filters to refine the restaurant list based on tags.
Multiple filters cannot be selected simultaneously to narrow down the search results.
Implementation Details

Fetching Data: The app fetches restaurant data and filter information from the provided API.
Filter Integration: Filters are implemented using the IDs found in the restaurant response.
Dynamic List Update: Selecting a filter updates the restaurant list to display only those restaurants with the corresponding tags.

Note
Figma Access Token Needs to be Provided In FigmaAPIManager.swift file



