
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Req

## Overview

Req’s objective is to paint a comprehensive and historical picture of
the Québec economy. The package provides insight into past and current
trends

of the businesses created in Quebec by constructing a geographical
representation of where and when each business exists (or existed),

as well as details about the business (i.e., what industry the business
is in, how many employees it has, etc.)

## Installation

You can install the latest development version of ‘Req’ with remotes as
follows:

``` r
install.packages("remotes")
remotes::install_github("warint/Req")
```

Then, test your installation with:

## How-To

### Step 1: Getting the business’s industry code

A user needs to first know the corresponding industry code of a certain
business

``` r
Req_industry() # A list of all industries and their respective codes (from the Registraire des Entrprises) will be produced

Req_industry(industry="Boulangeries et pâtisseries") # A list of all businesses in the boulangerie et pâtisserie industry and their respective codes (from the Registraire des Entrprises) will be produced

Req_industry("Boulangeries et pâtisseries") # A list of all businesses in the boulangerie et pâtisserie industry and their respective codes (from the Registraire des Entrprises) will be produced

Req_industry("Boula") # A list of all businesses in an industry that contains the string "Boula" and their respective codes (from the Registraire des Entrprises) will be produced
```

### Step 2: Getting the business’s number of employees code

Next, a user needs to know the possible ranges of the number of
employees and their corresponding codes

``` r
Req_employee() # A list of all possible ranges of number of employees and their respective codes (from the Registraire des Entrprises) will be produced
```

### Step 3: Getting the data

Once the user knows all the arguments, s.he can collect the data in a
very easy way through this function:

``` r
Req_data(industry = 6013  , active = 1, num_employee = "B", creation_date = "2000-01-01" )  # It generates a dataframe with all companies operating in the industry 6013 (Bakeries and pastry shops), which are active, have a number of employees B (between 6 and 10) and were created on or after 2020-01-01.
Req_data() # It generates a data frame of the complete dataset
```

### Cite ‘Req’

If you use the Req package for research, education, policymaking or
other related purposes, please cite the package. Consider making them a
donation to help them pursue the work. Business, social enterprises and
investors interested in using the Social Progress Index should contact
their offices.

To cite the ‘Req’ package in your work:

Warin, T. (2021). “Req: Client for accessing Quebec company registrar.
v0.1.0”

``` r
@article{Warin2021,
author = "Thierry Warin",
title = "{Req: Client for accessing Quebec company registrar}",
year = "2021",
month = "11",
url = "https://figshare.com/articles/software/Req_Client_for_accessing_Quebec_company_registrar/17068694",
doi = "10.6084/m9.figshare.17068694.v1"
}
```

### Acknowledgements

The author would like to thank the Center for Interuniversity Research
and Analysis of Organizations (CIRANO, Montreal) for its support, as
well as Thibault Senegas, Marine Leroi and Jeremy Schneider. The usual
caveats apply.
