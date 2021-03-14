
select Spacecraft, [Launch date], [Carrier rocket], Operator, [Mission type]
into SuccessfulMissions from MoonMissions where Outcome = 'Successful';

GO

update SuccessfulMissions set operator = trim(operator); 
select * from SuccessfulMissions;

GO

update SuccessfulMissions 
set Spacecraft = trim(' ' from substring(Spacecraft, 1, charindex('(', Spacecraft) - 1))
where charindex('(', Spacecraft) > 0;

GO

select	Operator, [Mission type], count(operator) as 'Mission Count' from SuccessfulMissions 
group by  Operator, [Mission type] having count(operator) > 1 order by Operator, [Mission type]

GO

select	id, username, [password], firstname, lastname, email, phone, 
		firstname + ' ' + lastname as 'Name',
		case
			when (SUBSTRING(id, 10, 1) % 2 ) = 1 then 'Male'
			else 'Female'
		end as 'Gender'
into NewUsers from users;

GO

select	username, count(username) as 'Number of duplicates' from newusers group by username;

GO

update newusers set username = 'sipe00' where id = '811008-5301'
update newusers set username = 'sipe01' where id = '630303-4894'
update newusers set username = 'sipe02' where id = '580802-4175'
update newusers set username = 'febe00' where id = '880706-3713'
update newusers set username = 'febe01' where id = '890701-1480'

GO

delete from newusers where '19' + left(id, 2) < 1970 and gender = 'Female'

GO

INSERT INTO NewUsers (id, username, [password], firstname, lastname, email, phone, [name], gender)
VALUES ('101010-1939', 
'benjoh', 
'ThRaQDg()?*V;+,/XxX^QB}BuR;j,;NsVLQ`Y.ADL6@zKUeHTE%L`,9)VumX-Bpe^=]_)p+vMrF35hqz_wCQQy.EqpZ?kTS$b^A*', 
'Bengt', 
'Johansson', 
'Bengt.Johansson@gmail.com',
'073-1234567', 
'Bengt Johansson', 
'Male');

GO

select	Gender,
		case
			when Gender = 'Female' then cast(round((avg( datediff(
					month, 
					'19' + left(id,2) + '-' + SUBSTRING(id, 3, 2) + '-' + SUBSTRING(id, 5, 2), 
					getdate())))/12.0, 1) as numeric(19,1))
			else	cast(round((avg( datediff(
					month, 
					'19' + left(id,2) + '-' + SUBSTRING(id, 3, 2) + '-' + SUBSTRING(id, 5, 2), 
					getdate())))/12.0, 1) as numeric(19,1))
		end as 'Average Age'				
from NewUsers group by Gender