prono <- read.table(file="oldprono.txt",header=TRUE,sep=";"); 
results <- read.table(file="resultats.txt",header=TRUE,sep=";");

nb_prono <- length(prono$idmatch)
perf_random <- NULL;
perf_deterministic <- NULL;
for(i in 1:nb_prono){
    match_id <- prono$idmatch[i];
   results_match_id <- which(results$idmatch == as.character(match_id));   
    if(length(results_match_id) > 0){
        if(as.character(prono$random_prono[i]) == results$resultat[results_match_id]){
            print("random:")
            perf_random <- c(perf_random,1);
        } else {
            perf_random <- c(perf_random,0);
        }
        if(as.character(prono$deterministic_prono[i]) == results$resultat[results_match_id]){
            print("deterministic:")
            perf_deterministic <- c(perf_deterministic,1);
        } else {
            perf_deterministic <- c(perf_deterministic,0);
        }
    } else {
     print(paste("Error: result of match ",prono$idmatch[i]," unknown",sep=""));
    }
}
print(paste("Perf random algorithm on ",length(perf_random)," matchs",sep=""))
print(sum(perf_random)/length(perf_random)*100);
print(sum(perf_deterministic)/length(perf_deterministic)*100);