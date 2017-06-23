select b.*
from 
	pc_software a
join
	software_master b
on
	a.softwareId = b.softwareId
where
	itLabel = /*itLabel*/'105'