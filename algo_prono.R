prono <- read.table(file="pronostics.txt",header=TRUE,sep=";");
results <- read.table(file="resultats.txt",header=TRUE,sep=";");
load("experts.rda");

names_to_id <- function(names){
    id <- NULL;
    for(i in 1:length(names)){
        id <- c(id,experts$id[experts$expert == names[i]]);  
    }
    return(id);
}

##List of match to play with
list_prono_match <- unique(prono$idmatch);
nb_prono_match <- length(list_prono_match);
nb_played_match <- length(results$idmatch);
nb_tobeplayed_match <- nb_prono_match - nb_played_match;
list_tobeplayed_match <- list_prono_match[-(1:nb_played_match)]

myprono <- data.frame(idmatch=list_tobeplayed_match,random_prono=rep(NA,nb_tobeplayed_match),
    deterministic_prono=rep(NA,nb_tobeplayed_match));

##Let's play!
for(match_index in 1:nb_tobeplayed_match){
    prono_match <- subset(prono,idmatch==list_tobeplayed_match[match_index]);
    vote_1 <- 0;
    vote_N <- 0;
    vote_2 <- 0;
    for(prono_index in 1:length(prono_match$pronostic)){
        if(prono_match$pronostic[prono_index] == 1){
            vote_1 <- vote_1 + experts$weight[names_to_id(as.character(prono_match$expert[prono_index]))];  
       } else if(prono_match$pronostic[prono_index] == 2){
            vote_2 <- vote_2 + experts$weight[names_to_id(as.character(prono_match$expert[prono_index]))];   
       } else{
            vote_N <- vote_N + experts$weight[names_to_id(as.character(prono_match$expert[prono_index]))];
       }
    }
    weight_distribution <- c(vote_1,vote_N,vote_2) / sum(c(vote_1,vote_N,vote_2));
    myprono$random_prono[match_index] <- sample(c(1,"N",2),1,prob=weight_distribution);
    myprono$deterministic_prono[match_index] <- c(1,"N",2)[c(vote_1,vote_N,vote_2) == max(vote_1,vote_N,vote_2)];
}
print(myprono)
oldprono <- myprono;
write.table(oldprono,file="oldprono.txt",sep=";",row.names=FALSE,col.names=FALSE,append=TRUE);
