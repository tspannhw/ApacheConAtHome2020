select * from stocks
order by `datetime` desc;


select `datetime`, cast(`high` as float) highStockValue, `symbol`,  cast(`low` as float) lowStockValue, 
 cast(`open` as float) openingStockValue,  cast(`close` as float) closingStockValue
from stocks
