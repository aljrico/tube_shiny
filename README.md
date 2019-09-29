# tubeshiny

<!-- badges: start -->
<!-- badges: end -->

The goal of this package is to present a usable example of a Shiny App conatained in an R package.

## Installation

You can install the released version of this package by simply

``` r
devtools::install_github('aljrico/tubeshiny')
```

## Run the App

The main purpose of this packge is to run a Shiny App, so let's just do it:

``` r
tubeshiny::runApp()
```


# How to use it

The purpose of this App is to explore the data from the Tube of London. In order to do so, the App requires a specificly formatted csv to be loaded. Though the internal functions of the app are designed so accept some degree of flexibility, the user is assumed to be aware of the format required.

Two important details before getting started:

* The app will not start functioning correctly until a well-formated `.csv` is uploaded. The widged to uploaded can be found in the top-left corner of the app.

* The main metric of interest in this data is `Excess`, which is calculated as `Excess Journey Time = Measured Journey Time - Scheduled Journey Time`. This metric can be normalised by checking the box that says `Normalise Excess Value` on the sidebar. Then the metric will be calculated as `Excess Journey Time = Measured Journey Time - Scheduled Journey Time / Scheduled Journey Time`.

## Summary

The first tab of the dashboard, `Summary` offers a quick overview of the main visualisations of interest. The user has still the freedom to filter by `Line` or `Type` and play with the plots as needed.

## Explore

The `Explore` tab is a suggested tool for the user to _explore_ the data provided with more freedom, with the possibility to build custom scatter plots and browse the actual table of data freely.

