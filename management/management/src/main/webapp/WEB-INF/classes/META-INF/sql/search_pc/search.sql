select * from base_master
/*BEGIN*/
where 
/*IF itLabel != ""*/
itLabel = /*itLabel*/'802507'
/*END*/
/*IF admini != ""*/
and admini like concat('%',/*admini*/,'%')
/*END*/
/*IF user != ""*/
and user like concat('%',/*user*/,'%')
/*END*/
/*IF lendingDate != null*/
and lendingDate = /*lendingDate*/'802507'
/*END*/
/*IF collectionDay != null*/
and collectionDay = /*collectionDay*/'802507'
/*END*/
/*IF disposalDate != null*/
and disposalDate = /*disposalDate*/'802507'
/*END*/
/*IF mdoelNumber != ""*/
and mdoelNumber like concat('%',/*mdoelNumber*/,'%')
/*END*/
/*IF os != ""*/
and os = /*os*/'802507'
/*END*/
/*IF wirelessLan != ""*/
and wirelessLan = /*wirelessLan*/'802507'
/*END*/
/*IF hddSpace != ""*/
and hddSpace = /*hddSpace*/'802507'
/*END*/
/*IF dataVolume != "" and dataVolume != null*/
and dataVolume = /*dataVolume*/'802507'
/*END*/
/*IF ipAddress != NULL*/
/*IF ipAddress != "else"*/
and ipAddress = /*ipAddress*/'DHCP'
 -- ELSE 
and ipAddress != 'DHCP'
/*END*/
/*END*/
/*END*/