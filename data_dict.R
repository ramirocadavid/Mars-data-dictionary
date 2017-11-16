# Login to Salesforce
library(RForcecom)
username <- "admin@utzmars.org"
password <- "gfutzmars2017**oyCqeCwuJQCCfOBACJKmKOIr8"
session <- rforcecom.login(username, password)

# Get objects list
objects.desc <- rforcecom.getObjectList(session)
library(dplyr)
objects.desc <- select(objects.desc, label, name)
objects.names <- c("Farmer", "Farmer Baseline", "Family members",
                   "Farm", "Smart internal inspection - Reports",
                   "Smart internal inspection - Taro", "Farm Baseline", "Plot",
                   "AO diagnostic", "FDP P&L", "AO Follow Up", "FDP calendar")
objects.desc <- objects.desc[objects.desc$label %in% objects.names, ]

# Download objects metadata
for(i in 1:nrow(objects.desc)) {
      assign("temp", rforcecom.getObjectDescription(session, objects.desc[i, "name"]))
      assign(paste(objects.desc$name[i], sep = ""),
             select(temp, label, type))
      rm(temp)
      write.csv(get(paste(objects.desc$name[i], sep = "")),
                paste(objects.desc$name[i], ".csv", sep = ""))
}
