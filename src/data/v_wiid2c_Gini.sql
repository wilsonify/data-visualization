CREATE ALGORITHM=UNDEFINED DEFINER=`datendesign`@`localhost` SQL SECURITY DEFINER VIEW `v_wiid2c_gini` AS (select `wiid2c`.`Country3` AS `Country3`,`wiid2c`.`Country` AS `Country`,`wiid2c`.`Year` AS `Year`,avg(`wiid2c`.`Gini`) AS `Gini` from `wiid2c` where (`wiid2c`.`Gini` > 0) group by `wiid2c`.`Country3`,`wiid2c`.`Country`,`wiid2c`.`Year`);