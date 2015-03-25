#The purpose of this script is to create an input file for processing & unfolding
#map visualization showing the main feeders of Greek airports

#Author: Nikolaos Efstathopoulos

#Date: November 8th, 2014

#initial file
#Date: November 23th, 2014
#Added color coding and weight in relation to 2013 Pax

import numpy as np
import csv as csv

#use the airports.dat file from http://openflights.org/data.html
#the data in this case that are important are airport names (city/IATA/ICAO) and coordinates

csv_file_object1 = csv.reader(open('/Users/nefstath/Documents/airports/airports.csv', 'rb'))

data1=[]                          # Create a variable called 'data1'.
for row in csv_file_object1:      # Run through each row in the csv file,
    data1.append(row)             # adding each row to the data variable
data1 = np.array(data1)              # Then convert from a list to an array

name=data1[0::,1]
print name
city=data1[0::,2]
print city
country=data1[0::,3]
print country
IATA=data1[0::,4]
print IATA
ICAO=data1[0::,5]
print ICAO
latitude=data1[0::,6]
print latitude
longtitude=data1[0::,7]
print longtitude

#use the dataset from https://open-data.europa.eu/en/data/dataset/FHQQVgAiqTpMuGoiMXzg
#the data that we are interested here are the OD pairs and volumes (mainly passengers)

csv_file_object2 = csv.reader(open('/Users/nefstath/Documents/airports/avia_par_el_mod_f.csv', 'rb'))
header = csv_file_object2.next()  # The next() command just skips the
                                # first line which is a header
data2=[]                          # Create a variable called 'data'.
for row in csv_file_object2:      # Run through each row in the csv file,
    data2.append(row)             # adding each row to the data variable
data2 = np.array(data2)              # Then convert from a list to an array

Origin=data2[0::,2]
Destination=data2[0::,4]
print Origin
print Destination
print len(data2)

# number_od_pairs = np.size(data2[0::,8].astype(np.float))
# print number_od_pairs
#fuse the data sets to produce the input for the processing algorithms

prediction_file = csv.writer(open('airports_od_pax.csv', 'wb'))


prediction_file.writerow(["i","O_ICAO", "D_ICAO","O_city","D_city","O_latitude", "O_longtitude", "D_latitude", "D_longtitude", "Pax"])



for i in range(len(data2)):
    for j in range(len(data1)):
#        print i,j
        if data2[i,0]=="PASS":
            pax=data2[i,25]
            if data2[i,2]==data1[j,5]:
#            print i,j,"origin", data1[j,5]
                O_ICAO=data1[j,5]
                O_city=data1[j,2]
                O_country=data1[j,3]
                O_latitude=data1[j,6]
                O_longitude=data1[j,7]
            elif data2[i,4]==data1[j,5]:
#                print i,j, "destination", data1[j,5]
                D_ICAO=data1[j,5]
                D_city=data1[j,2]
                D_country=data1[j,3]
                D_latitude=data1[j,6]
                D_longitude=data1[j,7]
                print i,O_ICAO, D_ICAO,O_city,D_city,pax
                prediction_file.writerow([i,O_ICAO, D_ICAO,O_city,D_city,O_latitude,O_longitude,D_latitude, D_longitude, pax])


#prediction_file.close()
