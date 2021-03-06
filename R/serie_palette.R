# 1. Palette builder function
#::::::::::::::::::::::::::::::::::::::::::::::

#' Series Palette Generator.
#'
#' This function builds palettes based on popular series and anime from Netflix and others visualmedia. The selection has been subjectively made by the authors.
#'
#'@param name Name of the color palette. Current options are Netflyx and Anime.
#'
#'@param n Number of colors to be used. Each palette includes up to 9 colors for discrete palettes. Any \code{n} can be chosen for continuous palettes.
#'
#'@param type Usage of palette as "continuous" or "discrete". Continuous palettes interpolate the three first colors of the palette to create a gradient. If not specified, function assumes continuous if n>9 and discrete if n<9.
#'
#'@param palette_family list of palettes to use.
#'
#'@return A vector of \code{n} colors
#'
#' @export

serie_palette <- function(name, palette_family = palette_netflyx, n, type = c("discrete", "continuous")) {
  
  pal <- palette_family[name][[1]]
  
  
  if (is.null(pal)){ 
    stop("Palette not found.")
  }
  
  if (missing(n)) { 
    n <- length(pal)
  }
  
  if (missing(type)) {
    if(n > length(pal)){type <- "continuous"}
    else{ type <- "discrete"}
  }
  type <- match.arg(type)
  
  
  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what discrete palette can offer, \n  use as continuous instead.")
  }
  
  
  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal[1:3])(n),

                discrete = pal[c(1:n)],
  )
  structure(out, class = "serie_palette", name = name)
}

#' @export


# 2. Palette Print Function
#::::::::::::::::::::::::::::::::::::::::
#' @importFrom graphics rect par image text
#' @importFrom stats median
#'

print.serie_palette <- function(x, ...) {
  pallength <- length(x)
  latinpar <- par(mar=c(0.25,0.25,0.25,0.25))
  on.exit(par(latinpar))
  
  image(1:pallength, 1,
        as.matrix(1:pallength),
        col = x,
        axes=FALSE)
  
  rect(0, 0.9, pallength + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text(median(1:pallength), 1,
       labels = paste0(attr(x,"name"),", n=",pallength),
       cex = 3, family = "sans")
}

 is.serie_palette <- function(x) {
   inherits(x, "serie_palette")
 }
 
 
 
 # 3. Return function to interpolate a Rseries color palette
 #::::::::::::::::::::::::::::::::::::::::
 #'  palette color interpolate
 #' 
 #' @export 
 
   Rseries_pal <- function(palette        = "Lupin",
                          palette_family = palette_netflyx, 
                          reverse = FALSE, ...) {
   pal <- palette_family[[palette]]
   if (reverse) pal <- rev(pal)
   colorRampPalette(pal,...)
                                                }
 
 
 

 # 4. fill function 
 #::::::::::::::::::::::::::::::::::::::::
 #' function to personalize fill aesthetic
 #' 
 #' @export
 
 scale_fill_rseries <- function(palette_family = palette_netflyx, 
                                palette  =  "Lupin" , 
                                discrete = TRUE, 
                                reverse  = FALSE,
                               ...) {
   # palette_family requires a function no a list of colors 
   # check reorganize the scale function to specify a better function for palettes
   # the output should be a funcion not a list of colors 
   pal <- Rseries_pal(palette = palette ,palette_family = palette_family) #, reverse = reverse
   
   if (discrete) {
     discrete_scale("fill", paste0("serie_palette_", palette), palette = pal, ...)
   } else {
     scale_fill_gradientn(colours = pal(256), ...)
   }
 }
 
 
 # 5. Color function 
 #::::::::::::::::::::::::::::::::::::::::
 #' function to personalize color aesthetic
 #' 
 #' @export
 
 scale_color_rseries <- function(palette_family = palette_netflyx,
                                palette = "Lupin", 
                                discrete = TRUE, 
                                reverse = FALSE,
                                ...) {
   pal <- Rseries_pal(palette = palette ,palette_family = palette_family)
   if (discrete) {
     discrete_scale("colour", paste0("lis_", palette), palette = pal, ...)
   }
   else {
     scale_color_gradientn(colours = pal(256), ...)
   }
 }
 
 
 
 # 6. Show pal function 
 #::::::::::::::::::::::::::::::::::::::::
 #' function to show all the avaliable palettes in a specific family .
 #' 
 #' @export
 
 show_pal <- function(name = "all",palette_family = palette_netflyx,
                      n    = 6    ,rev    = TRUE,...){
    
   name.palette <- deparse(substitute(palette_family))
   if(sum(unique(name %in% names(palette_family))) == 1) {
     list_names <- palette_family[name]
     range_color <- sapply(X = list_names,FUN = function(x){list(x[1:n])})
     
     if(rev == 1){
       list_panel <- rev(range_color) %>%
         map(.f = ~.) %>%
         unikn::seecol(
           pal_names = names(list_names),
           title = paste("Name of specific Rseries colour palettes:",
                         name.palette),
           ...
         )
     }else{
       list_panel <- range_color %>%
         map(.f = ~.) %>%
         unikn::seecol(
           pal_names = names(list_names),
           title = paste("Name of specific Rseries colour palettes:",
                         name.palette),
           ...
         )
     }
     
   } else if (name == "all"){
     list_names <- names(palette_family)
     list_panel <- list_names %>%
       map(.f = ~Rseries_pal(.,reverse = rev,palette_family = palette_family)(n=n)) %>%
       unikn::seecol(
         pal_names = list_names,
         title = paste("Name of specific Rseries colour palettes:",
                       name.palette),
         ...
       )
   } else {
     stop("Color palette is incorrect,please use show_pal() and choose a color")
   }
   
 } 
 