
################# CMAQ data from nc files ###########################################

library(RNetCDF)
library(fields)
library(maptools)
library(rgdal)

setwd ("C:/SATELLITE_STUFF/Donkelaar_1Km/cmaq/") 

#Open data file
Lat_Lon_CMAQ <- "GRIDCRO2D_UK10_060102.nc"           ## for UK  10 km resolution 
CMAQ_2011 <- "UK10_2011_pm_Yavg_v5.0.1_20140519.nc"  ## for UK  10 km resolution
CMAQ_2010 <- "UK10_2010_pm_Yavg_v5.0.1_20140519.nc"  ## units are in ug/m3
CMAQ_2009 <- "UK10_2009_pm_Yavg_v5.0.1_20140224.nc"
GAS_CMAQ_2011 <- "UK10_2011_gas_Yavg_v5.0.1_20140519.nc"            

Lat_Lon <- open.nc(Lat_Lon_CMAQ)
CMAQ_2011_PM25 <- open.nc(CMAQ_2011)
CMAQ_2010_PM25 <- open.nc(CMAQ_2010)
CMAQ_2009_PM25 <- open.nc(CMAQ_2009)
GAS_CMAQ_2011 <- open.nc(GAS_CMAQ_2011)

# Print dataset summary information
# print.nc(fid)

#Read data
PM25_2011 <- read.nc(CMAQ_2011_PM25)
PM25_2010 <- read.nc(CMAQ_2010_PM25)
PM25_2009 <- read.nc(CMAQ_2009_PM25)
Grid <- read.nc(Lat_Lon)
GAS_CMAQ_2011 <- read.nc(GAS_CMAQ_2011)

LAT <- as.matrix(Grid$LAT)  ### get Lat
LON <- as.matrix(Grid$LON)  ### get Lon

PM25_NO3_2011 <-as.matrix(PM25_2011$PM2.5_NO3)  ### get NO3
PM25_NO3_2010 <-as.matrix(PM25_2010$PM2.5_NO3)
PM25_NO3_2009 <-as.matrix(PM25_2009$PM2.5_NO3)

PM25_POC_2011 <-as.matrix(PM25_2011$PM2.5_POC)  ### get POC (primary organic carbon)
PM25_POC_2010 <-as.matrix(PM25_2010$PM2.5_POC)
PM25_POC_2009 <-as.matrix(PM25_2009$PM2.5_POC)

PM25_SO4_2011 <-as.matrix(PM25_2011$PM2.5_SO4)  ### get SO43
PM25_SO4_2010 <-as.matrix(PM25_2010$PM2.5_SO4)
PM25_SO4_2009 <-as.matrix(PM25_2009$PM2.5_SO4)

PM25_SOAA_2011 <-as.matrix(PM25_2011$PM2.5_SOAA)  ### get SOA (anthropogenic)
PM25_SOAA_2010 <-as.matrix(PM25_2010$PM2.5_SOAA)
PM25_SOAA_2009 <-as.matrix(PM25_2009$PM2.5_SOAA)

PM25_2011 <-as.matrix(PM25_2011$PM2.5)  ### get total PM2.5
PM25_2010 <-as.matrix(PM25_2010$PM2.5)
PM25_2009 <-as.matrix(PM25_2009$PM2.5)

CO_2011 <-as.matrix(GAS_CMAQ_2011$CO)     ## units are in ug/m3
NO2_2011 <-as.matrix(GAS_CMAQ_2011$NO2)   
NOX_2011 <-as.matrix(GAS_CMAQ_2011$NOX)    
NO_2011 <-as.matrix(GAS_CMAQ_2011$NO)    
SO2_2011 <-as.matrix(GAS_CMAQ_2011$SO2)    
NH3_2011 <-as.matrix(GAS_CMAQ_2011$NH3)
O3_2011 <-as.matrix(GAS_CMAQ_2011$O3) 
   

#Close file
close.nc(Lat_Lon)
close.nc(CMAQ_2011_PM25)
close.nc(CMAQ_2010_PM25)
close.nc(CMAQ_2009_PM25)
close.nc(GAS_CMAQ_2011) 

################# Map ###########################################################


data(wrld_simpl)
zmin=0.
zmax=7.

# clevs<-c(0,2,4,6,8,10,12,14,16,18,20,50)
clevs<-c(0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,6)
ccols<-c("#5D00FF", "#002EFF","#00B9FF","#00FFB9" ,"#00FF2E",
         "#5DFF00","#E8FF00", "#FF8B00","red", "#FF008B","#E800FF")
# dev.off()
palette(ccols)
par(mfrow=c(1,1))
image.plot(LON,LAT, PM25_NO3_2011, zlim=c(zmin,zmax), breaks=clevs, col=palette(ccols))
plot(wrld_simpl,add=TRUE)

#################################################################################

LAT <- c(LAT)
LON <- c(LON)
PM25_NO3_2011 <- c(PM25_NO3_2011)
PM25_NO3_2010 <- c(PM25_NO3_2010)
PM25_NO3_2009 <- c(PM25_NO3_2009)

PM25_POC_2011 <- c(PM25_POC_2011)
PM25_POC_2010 <- c(PM25_POC_2010)
PM25_POC_2009 <- c(PM25_POC_2009)

PM25_SO4_2011 <- c(PM25_SO4_2011)
PM25_SO4_2010 <- c(PM25_SO4_2010)
PM25_SO4_2009 <- c(PM25_SO4_2009)

PM25_SOAA_2011 <- c(PM25_SOAA_2011)
PM25_SOAA_2010 <- c(PM25_SOAA_2010)
PM25_SOAA_2009 <- c(PM25_SOAA_2009)

PM25_2011 <- c(PM25_2011)
PM25_2010 <- c(PM25_2010)
PM25_2009 <- c(PM25_2009)

CO_2011 <- c(CO_2011)
NO2_2011 <- c(NO2_2011)   
NOX_2011 <- c(NOX_2011)
NO_2011 <- c(NO_2011)
SO2_2011 <- c(SO2_2011)  
NH3_2011 <- c(NH3_2011)
O3_2011 <- c(O3_2011)

CO <- cbind(LAT, LON, CO_2011)
CO <- as.data.frame(CO)
colnames(CO) <- c("Lat", "Lon","CO_2011_CMAQ")
write.csv(CO, file = "CO_CMAQ_2011.csv", row.names=FALSE)


NO2 <- cbind(LAT, LON, NO2_2011)
NO2 <- as.data.frame(NO2)
colnames(NO2) <- c("Lat", "Lon","NO2_2011_CMAQ")

NOX <- cbind(LAT, LON, NOX_2011)
NOX <- as.data.frame(NOX)
colnames(NOX) <- c("Lat", "Lon","NOX_2011_CMAQ")

NO <- cbind(LAT, LON, NO_2011)
NO <- as.data.frame(NO)
colnames(NO) <- c("Lat", "Lon","NO_2011_CMAQ")

SO2 <- cbind(LAT, LON, SO2_2011)
SO2 <- as.data.frame(SO2)
colnames(SO2) <- c("Lat", "Lon","SO2_2011_CMAQ")

NH3 <- cbind(LAT, LON, NH3_2011)
NH3 <- as.data.frame(NH3)
colnames(NH3) <- c("Lat", "Lon","NH3_2011_CMAQ")

O3 <- cbind(LAT, LON, O3_2011)
O3 <- as.data.frame(O3)
colnames(O3) <- c("Lat", "Lon","O3_2011_CMAQ")


###### Make averages fro the years 2009, 2010, 2011 #########################

NO3 <- cbind(LAT, LON,PM25_NO3_2009, PM25_NO3_2010, PM25_NO3_2011)
NO3 <- as.data.frame(NO3)
colnames(NO3) <- c("Lat", "Lon","NO3_2009_CMAQ", "NO3_2010_CMAQ", "NO3_2011_CMAQ")
NO3$NO3_AVG <- rowMeans(NO3[,3:5])
write.csv(NO3, file = "C:/SATELLITE_STUFF/Donkelaar_1Km/cmaq/UK10_2009_2011/PM25_NO3_CMAQ_2009_2011.csv", row.names=FALSE)


SO4 <- cbind(LAT, LON,PM25_SO4_2009, PM25_SO4_2010, PM25_SO4_2011)
SO4 <- as.data.frame(SO4)
colnames(SO4) <- c("Lat", "Lon","SO4_2009_CMAQ", "SO4_2010_CMAQ", "SO4_2011_CMAQ")
SO4$SO4_AVG <- rowMeans(SO4[,3:5])
write.csv(SO4, file = "C:/SATELLITE_STUFF/Donkelaar_1Km/cmaq/UK10_2009_2011/PM25_SO4_CMAQ_2009_2011.csv", row.names=FALSE)


POC <- cbind(LAT, LON,PM25_POC_2009, PM25_POC_2010, PM25_POC_2011)
POC <- as.data.frame(POC)
colnames(POC) <- c("Lat", "Lon","POC_2009_CMAQ", "POC_2010_CMAQ", "POC_2011_CMAQ")
POC$POC_AVG <- rowMeans(POC[,3:5])
write.csv(POC, file = "C:/SATELLITE_STUFF/Donkelaar_1Km/cmaq/UK10_2009_2011/PM25_POC_CMAQ_2009_2011.csv", row.names=FALSE)


SOAA <- cbind(LAT, LON,PM25_SOAA_2009, PM25_SOAA_2010, PM25_SOAA_2011)
SOAA <- as.data.frame(SOAA)
colnames(SOAA) <- c("Lat", "Lon","SOAA_2009_CMAQ", "SOAA_2010_CMAQ", "SOAA_2011_CMAQ")
SOAA$SOAA_AVG <- rowMeans(SOAA[,3:5])
write.csv(SOAA, file = "C:/SATELLITE_STUFF/Donkelaar_1Km/cmaq/UK10_2009_2011/PM25_SOAA_CMAQ_2009_2011.csv", row.names=FALSE)


PM25 <- cbind(LAT, LON,PM25_2009, PM25_2010, PM25_2011)
PM25 <- as.data.frame(PM25)
colnames(PM25) <- c("Lat", "Lon","PM25_2009_CMAQ", "PM25_2010_CMAQ", "PM25_2011_CMAQ")
PM25$PM25_AVG <- rowMeans(PM25[,3:5])
write.csv(PM25, file = "C:/SATELLITE_STUFF/Donkelaar_1Km/cmaq/UK10_2009_2011/PM25_CMAQ_2009_2011.csv", row.names=FALSE)
