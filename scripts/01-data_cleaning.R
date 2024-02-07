#### Preamble ####
# Purpose: Cleans the raw majors and wages data and combines them
# Author: Diana Liu
# Date: 06 February 2024
# Contact: guanzhi.liu@mail.utoronto.ca
# Pre-requisites: downloaded the data

#### Workspace setup ####
#install.packages("tidyverse")
library(tidyverse)

#### Clean data ####
load("Inputs/Raw Data/ACS_Industries_INCWAGE.Rda")
load("Inputs/Raw Data/ACS_Majors_INCWAGE.Rda")

#  Clean Student Data
S<-S[NA_to_F(S$UG)&S$Admit_Year%in%1986:2017&!is.na(S$SID)&NA_to_F(S$Major1!="Limited Status"),]
S$URM<-grepl("Alaska|Black|Chicano|Latino|Hispanic|Puerto",S$Ethnicity)*100
S$Female<-S$Sex=="F" ; S$Female[S$Gender=="U"]<-NA ; S$Gender<-S$Sex
for(m in 1:4) S[NA_to_F(S[,paste0("Major",m)]=="Information Systems Management"),paste0("Major",m)]<-"Technology&Info Management" #Major was renamed over time
S$Grad_Year<-as.integer(S$Grad_Year)

#Categorize majors
S$Count<-1
c<-aggregate(Count~Major1,S,sum)
names(c)[1]<-"Field"
c$Area<-"" ; c$GenArea<-""
for(i1 in 1:7){
  for(i2 in 1:length(Fields_all[[i1]])){
    for(i3 in 1:length(Fields_all[[i1]][[i2]])){
      check<-NA_to_F(tolower(Fields_all[[i1]][[i2]][[i3]])==tolower(c$Field))
      c$Area[check]<-Fields_all[[i1]][[i2]][[1]]
      c$GenArea[check]<-Fields_all[[i1]][[1]][[1]]
    }
  }
}
c<-c[,-2]
for(i in 1:4){
  names(c)<-paste0(c("Major","Area","GenArea"),i)
  S<-merge(S,c,all.x=T)
}

for(v in names(S)[grepl("wage",names(S))]){
  S[NA_to_F(S[,v]>quantile(S[,v],.98,na.rm=T)),v]<-quantile(S[,v],.98,na.rm=T)
  S[NA_to_F(S[,v]<quantile(S[,v],.02,na.rm=T)),v]<-quantile(S[,v],.02,na.rm=T)
  S[,paste0("log",v)]<-log(1+S[,v])
}
S$AllMajors<-apply(S[,c("Major1","Major2","Major3","Major4")],1,function(x){ #Combine majors into string
  x<-x[!is.na(x)&!duplicated(x)]
  return(paste(x[order(x)],collapse=","))
})
S$wage_sum_1314<-apply(S[,c("wage_sum_2013","wage_sum_2014")],1,mean,na.rm=T)
S$wage_sum_0910<-apply(S[,c("wage_sum_2009","wage_sum_2010")],1,mean,na.rm=T)
S$wage_sum_1718<-apply(S[,c("wage_sum_2017","wage_sum_2018")],1,mean,na.rm=T)

#Add NAICS information
n<-read_excel("Inputs/Raw Data/Raw/NAICS_Codes.xlsx")
n<-n[-(1:2),2:3] ; names(n)<-c("NAICS","NAICS_Text") ; n$NAICS_Text<-gsub("T$","",n$NAICS_Text)
n$NAICS<-as.integer(n$NAICS) ; n<-n[!duplicated(n$NAICS)&!is.na(n$NAICS),]
S<-S[,!grepl("NAICS_Text",names(S))]
for(i in c(2017,2018)){
  S[,paste0("NAICS4_",i,"_2")]<-as.integer(floor(S[,paste0("NAICS4_",i)]/(10^(nchar(S[,paste0("NAICS4_",i)])-2))))
  S<-merge(S,n,by.x=paste0("NAICS4_",i,"_2"),by.y="NAICS",all.x=T)}
  
#Wrap up NAICS to ACS industries
c$NAICS4_1718_ACS<-c$NAICS4_1718
for(v in 1:5){
  check<-!c$NAICS4_1718_ACS%in%acsind$INDNAICS
  c$NAICS4_1718_ACS[check]<-gsub(".$","",c$NAICS4_1718_ACS[check])}
for(y in c(2010,2014,2017)){
  temp<-acsind[acsind$Y==y,c(1,3)]
  names(temp)<-c("NAICS4_1718_ACS",paste0("Ind_ACSMedian",y))
  c<-merge(c,temp,all.x=T)
  temp<-acsind_CA[acsind_CA$Y==y,c(1,3)]
  names(temp)<-c("NAICS4_1718_ACS",paste0("Ind_ACSMedian_CA",y))
  c<-merge(c,temp,all.x=T)
  temp<-acsind_NotCA[acsind_NotCA$Y==y,c(1,3)]
  names(temp)<-c("NAICS4_1718_ACS",paste0("Ind_ACSMedian_NotCA",y))
  c<-merge(c,temp,all.x=T)
}
save(c, "Outputs/data/ACS_Data_UCSCEcon.Rda")

load("/cloud/project/outputs/Data/ACS_Data_UCSCEcon_NAICS.Rda")
cleaned_data <- acs
cleaned_data <- select(cleaned_data, YEAR, SEX, AGE, EDUC, DEGFIELD, IND, INCWAGE)
cleaned_data <-
  cleaned_data |>
  rename(DEGREE = DEGFIELD, INDUSTRY = IND, WAGE_INCOME = INCWAGE)

#### Save data ####
save(cleaned_data, file = "/cloud/project/outputs/Data/ACS_Data_UCSCEcon_Cleaned.Rda")

