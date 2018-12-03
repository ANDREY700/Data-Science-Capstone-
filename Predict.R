
setwd("~/ABRAMOV Andrey/Capstone_project/2018/5. New shiny app/Keyboard_typing_prediction_algorithm")
gram1 <- readRDS('gram1.rds',.GlobalEnv)
gram2 <- readRDS('gram2na.rds',.GlobalEnv)
gram3 <- readRDS('gram3na.rds',.GlobalEnv)


Gram3procedure <- function(x) {
  require(tm)
  # x <- "I like"

  # clean it before proceed
  x <- tolower(x)
  x <- gsub("[[:punct:]]", "", x)
  x <- gsub("+\\d+", "", x)
  x <- gsub("^ *|(?<= ) | *$", "", x, perl=T)
  x <- strsplit(x," ")
  x <- as.data.frame(x)
  len <- nrow(x)
  
  
  if(len >=2) { 
  
      w2 <- gram1[which(gram1$w1==as.character(x[len,1])), ]
      w1 <- gram1[which(gram1$w1==as.character(x[len-1,1])), ]
      
      w3 <- gram3[which(gram3$key1==w1$key), ]      
      w3 <- w3[which(w3$key2==w2$key), ]      
      w3 <- w3[order(-freq),]
      w3_len <- nrow(w3)
      if (w3_len>=1) {
          if (w3_len>5) {
            #j<-1
            output <- c()
            for (j in 1:5) {
                output <- c(output, gram1$w1[ which(gram1$key==w3$key3[j])])
            }
          } else {
            for (j in 1:w3_len) {
              output <- c(output, gram1$w1[ which(gram1$key==w3$key3[j])])
            }
          }
      } else {output <- "-"}
  } else {output <- "-"}
  output
}

Gram2procedure <- function(x) {
  require(tm)
  # x <- "I like"

  # clean it before proceed
  x <- tolower(x)
  x <- gsub("[[:punct:]]", "", x)
  x <- gsub("+\\d+", "", x)
  x <- gsub("^ *|(?<= ) | *$", "", x, perl=T)
  x <- strsplit(x," ")
  x <- as.data.frame(x)
  len <- nrow(x)
  
  
  if(len >=1) { 
    
    w1 <- gram1[which(gram1$w1==as.character(x[len,1])), ]
    
    w3 <- gram2[which(gram2$key1==w1$key), ]      
    w3 <- w3[order(-freq),]
    w3_len <- nrow(w3)
    if (w3_len>=1) {
      if (w3_len>5) {
        #j<-1
        output <- c()
        for (j in 1:5) {
          output <- c(output, gram1$w1[ which(gram1$key==w3$key2[j])])
        }
      } else {
        for (j in 1:w3_len) {
          output <- c(output, gram1$w1[ which(gram1$key==w3$key2[j])])
        }
      }
    } else {output <- "-"}
  } else {output <- "-"}
  output
}

Gram1procedure <- function(x) {
  require(tm)
  # x <- "I bread"
  # clean it before proceed
  x <- tolower(x)
  x <- gsub("[[:punct:]]", "", x)
  x <- gsub("+\\d+", "", x)
  x <- gsub("^ *|(?<= ) | *$", "", x, perl=T)
  x <- strsplit(x," ")
  x <- as.data.frame(x)
  len <- nrow(x)
  
  

    # 3gram search
    w2 <- gram1[which(gram1$w1==as.character(x[len,1])), ]
    w1 <- gram1[which(gram1$w1==as.character(x[len-1,1])), ]
    w3 <- gram3[which(gram3$key1==w1$key), ]      
    w3 <- w3[which(w3$key2==w2$key), ]      
    
    gram3flag <- (nrow(w3)>0)
    
    # 3gram search
    w0 <- gram2[which(gram2$key1==w1$key), ]      
    gram2flag <- (nrow(w0)>0)
    
    if (!gram3flag & !gram2flag) {
          output <- c()
          for (j in 1:5) {
            output <- c(output, gram1$w1[j])
          }
    } else {output <- "-"}

  output
}

Gram_C_procedure <- function(x) {
  require(tm)

  # x <- "I need"
  # clean it before proceed
  x <- tolower(x)
  x <- gsub("[[:punct:]]", "", x)
  x <- gsub("+\\d+", "", x)
  x <- gsub("^ *|(?<= ) | *$", "", x, perl=T)
  x <- strsplit(x," ")
  x <- as.data.frame(x)
  len <- nrow(x)
  
  output <- "-"
  if(len >=2) { 
    
    # 3-gram searching
    w2 <- gram1[which(gram1$w1==as.character(x[len,1])), ]
    w1 <- gram1[which(gram1$w1==as.character(x[len-1,1])), ]
    
    w3 <- gram3[which(gram3$key1==w1$key), ]      
    w3 <- w3[which(w3$key2==w2$key), ]      
    w3 <- w3[order(-freq),]
    w3_len <- nrow(w3)
    
    # 2-gram searching
    ww1 <- gram1[which(gram1$w1==as.character(x[len,1])), ]
    
    ww3 <- gram2[which(gram2$key1==w1$key), ]      
    ww3 <- ww3[order(-freq),]
    ww3_len <- nrow(ww3)
    
    
    # check that all search was successful
    if (w3_len>0 & ww3_len>0) {
            w3_flag <- F
            # j<-3
            # ww3[j]
            #b <- gram2[which(gram2$key2==0), ]
            for (j in 1:nrow(ww3)) {
                a3 <- w3[which(w3$key3==ww3$key2[j]), ]
                if (nrow(a3)>0) {
                  for (k in 1:nrow(a3)) {
                       a3$freq <- gram1$Freq[which(gram1$key==a3$key3[k])]
                  }
                  if (!w3_flag) {
                      w3_c <- a3
                      w3_flag <- T
                  } else {
                    w3_c <- rbind(w3_c, a3)
                  }
                }
            }
            w3_c <- w3_c[order(-freq),]
            
            if (nrow(w3_c)>=1) {
                if (nrow(w3_c)>5) {
                      #j<-1
                      output <- c()
                      for (j in 1:5) {
                          output <- c(output, gram1$w1[ which(gram1$key==w3_c$key3[j])])
                      }
                } else {
                      for (j in 1:nrow(w3_c)) {
                          output <- c(output, gram1$w1[ which(gram1$key==w3_c$key3[j])])
                      }
                }
            } else {output <- "-"}
    } else {output <- "-"}
  }
  
  output
}
