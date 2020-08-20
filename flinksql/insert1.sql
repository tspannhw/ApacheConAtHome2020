insert into krogerprices
select upc,updatedate,itemdescription,brandname,CAST(price as float) as price, UUID() as uuid
from itemprice
where originstore = 'kroger'
