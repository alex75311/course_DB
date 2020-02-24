-- Количество заявок на каждого специалиста
select COUNT(*) as 'Количество заявок', resp.first_name as 'Фамилия', resp.last_name as 'Имя' from incident as inc
join 
responsible as resp
on responsible_id = resp.id 
group by inc.responsible_id;

-- Выборка заявок с наивысшим приоритетом
SELECT * from incident where priority_id = 1;

-- Количество заявок с каждым приоритетом
select COUNT(*) as 'Количество' , priority.title as 'Приоритет' 
from incident 
join
priority
on priority_id = priority.id 
group by priority_id;

-- Отображение пользователю (с id 1) заявок, назначенных на него (не решеных)
create or replace view user_inc (customer, topic, description, create_date, priority)
as select customer.title, topic, description, created_date, priority.title 
FROM incident
join customer on customer_id = customer.id 
join priority on priority_id = priority.id 
where responsible_id = 1 and state_id != 3;

select * FROM user_inc;

-- Отображение неназначенных заявок с высоким приоритетом
create or replace view `high_priority` (customer, topic, description, created_date)
as select customer.title, topic, description, created_date 
from incident
join customer on customer_id = customer.id 
where responsible_id is null and priority_id = 1;

select * from `high_priority`;

-- Удаление решеных заявок старше указанной даты (либо ввести отдельный статус и отправлять их в архив)
drop procedure if exists drop_old_inc
delimiter \\
CREATE PROCEDURE drop_old_inc(IN start_date date)
BEGIN
  delete from incident where state_id = 3 and created_date < start_date;
END \\
delimiter ;

call drop_old_inc('2000-01-01');

-- Триггер проверки типа добавляемого к заявке комментария, если не указан выставляется первый тип (внутренняя заметка)
drop trigger if exists new_msg
delimiter \\
create trigger new_msg before insert on work_details 
for each row
begin
	declare first_type_msg int;
	select id into first_type_msg from type_msg limit 1;
	set new.type_msg_id = coalesce (new.type_msg_id, first_type_msg);
end \\
delimiter ;

-- Триггер не дающий изменять тип комментария к заявке
drop trigger if exists update_msg
delimiter \\
create trigger update_msg before update on work_details 
for each row
begin
	set new.type_msg_id = old.type_msg_id;
end \\
delimiter ;

