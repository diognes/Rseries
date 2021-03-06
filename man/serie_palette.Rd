% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/serie_palette.R
\name{serie_palette}
\alias{serie_palette}
\title{Series Palette Generator.}
\usage{
serie_palette(
  name,
  palette_family = palette_netflyx,
  n,
  type = c("discrete", "continuous")
)
}
\arguments{
\item{name}{Name of the color palette. Current options are Netflyx and Anime.}

\item{palette_family}{list of palettes to use.}

\item{n}{Number of colors to be used. Each palette includes up to 9 colors for discrete palettes. Any \code{n} can be chosen for continuous palettes.}

\item{type}{Usage of palette as "continuous" or "discrete". Continuous palettes interpolate the three first colors of the palette to create a gradient. If not specified, function assumes continuous if n>9 and discrete if n<9.}
}
\value{
A vector of \code{n} colors
}
\description{
This function builds palettes based on popular series and anime from Netflix and others visualmedia. The selection has been subjectively made by the authors.
}
