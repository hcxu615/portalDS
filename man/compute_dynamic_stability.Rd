% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/analysis-workflow.R
\name{compute_dynamic_stability}
\alias{compute_dynamic_stability}
\alias{build_dynamic_stability_plan}
\title{Dynamic stability analysis for community time series}
\usage{
compute_dynamic_stability(block, results_file = NULL, id_var = NULL,
  max_E = 16, E_list = seq(max_E),
  surrogate_method = "annual_spline", num_surr = 200,
  surr_params = list(), lib_sizes = seq(10, 100, by = 10),
  random_libs = TRUE, num_samples = 100, replace = TRUE,
  RNGseed = 42, silent = TRUE, rescale = TRUE,
  rolling_forecast = FALSE)

build_dynamic_stability_plan(id_var = NULL, max_E = 16,
  E_list = seq(max_E), surrogate_method = "annual_spline",
  num_surr = 200, surr_params = list(), lib_sizes = seq(10, 100, by =
  10), random_libs = TRUE, num_samples = 100, replace = TRUE,
  RNGseed = 42, silent = TRUE, rescale = TRUE,
  rolling_forecast = FALSE)
}
\arguments{
\item{block}{a data.frame containing time series for the community. Each
column is a time series of abundances, and a \code{censusdate} column is used
as the column containing the time value.}

\item{results_file}{the location of the results to be stored on disk.}

\item{id_var}{the name of the index variable of \code{block} that is useful for
labeling the time-varying output, if it exists}

\item{max_E}{largest E to examine using simplex projection; this sets the
default range for \code{E_list}, but any setting for \code{E_list} will override the
value for \code{max_E}}

\item{E_list}{the embedding dimension or range of embedding dimensions to
search over.}

\item{surrogate_method}{which surrogate method to use:
options are "annual_spline" or methods available in
\code{\link[rEDM:make_surrogate_data]{rEDM::make_surrogate_data()}}}

\item{num_surr}{number of surrogates to compute}

\item{surr_params}{a list of named optional arguments to be passed into the
surrogate data function}

\item{lib_sizes}{the vector of library sizes to try}

\item{random_libs}{indicates whether to use randomly sampled libs}

\item{num_samples}{is the number of random samples at each lib size (this 
parameter is ignored if random_libs is FALSE)}

\item{replace}{indicates whether to sample vectors with replacement}

\item{RNGseed}{will set a seed for the random number generator, enabling 
reproducible runs of ccm with randomly generated libraries}

\item{silent}{prevents warning messages from being printed to the R console}

\item{rescale}{A logical, indicating whether to rescale each time series}

\item{rolling_forecast}{A logical, indicating whether to make individual
rolling forecasts for the second half of the time series.}
}
\value{
a list with named components for the individual output objects
XXX
}
\description{
\code{\link[=compute_dynamic_stability]{compute_dynamic_stability()}} runs the full dynamic stability
analysis. The analysis has multiple steps:
\enumerate{
\item{run simplex projection on each time series to identify the optimal
embedding dimension}
\item{generate surrogate time series, assumming that the data have just a
seasonal pattern}
\item{run ccm on each pairwise interaction, including the surrogate data}
\item{identify the significant interactions by comparing the CCM for the
real time series against the calculations for the surrogate data}
\item{run S-map models for each time series, using the appropriate number of
lags, and including the important interacting variables}
\item{extract out the s-map coefficients from the models and assemble
matrices for the system}
\item{perform eigen-decomposition on the s-map coefficient matrices}
\item{perform singular-value-decomposition on the s-map coefficient matrices}
\item{compute volume contraction from the s-map coefficient matrices}
\item{compute total variance from the s-map coefficient matrices}
}

\code{\link[=build_dynamic_stability_plan]{build_dynamic_stability_plan()}} creates a drake plan for the
dynamic stability analysis.
}
