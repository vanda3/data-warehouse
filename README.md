# Taxi Services

## Group project with Rui Andrade: https://github.com/randrade23 
We were given tables containing information regarding taxi services (taxi_services) and taxi stands (taxi_stands).
taxi_services has 1 million and a half service registers. Each register gives us information about where and when each trip starts and ends and which taxi performed that trip. Each taxi stand register contains the stand name and its location. We used CAOP (Carta Administrativa Oficial de Portugal) after converting the data geometric model from 27493 (Datum 73/Modified Portuguese Grid) to 4326 (WGS86) using the command:

shp2pgsql -W "latin1" -s 27493:4326 -g geom -I caop/Cont_Freg_V5.shp public.caop | psql

After pre-processing the data, we built a Data Warehouse which was then use to extract relevant information from the data.

