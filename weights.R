prono <- read.table(file="pronostics.txt",header=TRUE,sep=";");
results <- read.table(file="resultats.txt",header=TRUE,sep=";");

names_to_id <- function(names){
    id <- NULL;
    for(i in 1:length(names)){
         id <- c(id,experts$id[experts$expert == names[i]]);  
    }
    return(id);
}

name_experts <- unique(prono$expert);
nb_experts <- length(name_experts);
experts <- data.frame(id=1:nb_experts,expert = name_experts,weights = rep(1, nb_experts),
    nb_match_played = rep(0, nb_experts));
nb_matchs <- dim(results)[1];
eta <- 1/2;
for(match_index in 1:nb_matchs){
    resultat_match <- results$resultat[match_index];
    prono_match <- subset(prono,idmatch==as.character(results$idmatch[match_index]));
    players_name <- prono_match$expert;
    id_playing <- names_to_id(players_name);
    experts$nb_match_played[id_playing] <- experts$nb_match_played[id_playing] + 1;
    loosers_name <- prono_match$expert[prono_match$pronostic!=as.character(resultat_match)];
    id_loosers <- names_to_id(loosers_name);
    if(length(loosers_name)>0){
        experts$weights[id_loosers] <- (1 - eta) * experts$weights[id_loosers];
    }
    cat('\n');
    print(loosers_name);
    print(experts);
}
##weights are ponderated by the amount of prognosticated match
experts$weights <- experts$weights * (experts$nb_match_played / max(experts$nb_match_played));
save(experts,file="experts.rda")

##plot
x11();
barplot(experts$weights,names.arg=experts$expert,
    main=paste("Weights after ",max(experts$nb_match_played)," played matches"),
    ylab="Weights")
dev.copy2pdf(file="experts.pdf");
dev.off();