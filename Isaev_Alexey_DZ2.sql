/* Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке. */

-- выполнено

/* Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name */

drop database if exists example;
create database example;

drop table if exists example.users;
create table example.users (
  id SERIAL PRIMARY KEY,
  name varchar(255) not null
)

/* Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample. */

drop database if exists sample;
create database sample;

mysqldump example > example.sql
mysql sample < example.sql

/* (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы
 help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы. */

mysqldump  --where="true limit 100" mysql help_keyword > 100_key_words.sql

