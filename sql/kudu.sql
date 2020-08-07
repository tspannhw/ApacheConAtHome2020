  
CREATE TABLE itemprice
(
  upc STRING,
  originstore STRING,
  updatedate STRING,
  longdescription STRING,
  itemdescription STRING,
  brandname STRING,
  displayimage STRING, 
  price STRING,
  msrp STRING,
  tpr STRING,
PRIMARY KEY (upc, originstore, updatedate) ) 
PARTITION BY HASH PARTITIONS 4 
STORED AS KUDU TBLPROPERTIES ('kudu.num_tablet_replicas' = '1');
