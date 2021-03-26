--
-- Скрипт сгенерирован Devart dbForge Studio 2019 for MySQL, Версия 8.2.23.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 26.03.2021 19:08:58
-- Версия сервера: 5.7.25
-- Версия клиента: 4.1
--

-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

--
-- Установка базы данных по умолчанию
--
USE fitness_center;

--
-- Удалить таблицу `gyms`
--
DROP TABLE IF EXISTS gyms;

--
-- Удалить таблицу `workouts`
--
DROP TABLE IF EXISTS workouts;

--
-- Удалить таблицу `coaches`
--
DROP TABLE IF EXISTS coaches;

--
-- Удалить таблицу `customers`
--
DROP TABLE IF EXISTS customers;

--
-- Установка базы данных по умолчанию
--
USE fitness_center;

--
-- Создать таблицу `customers`
--
CREATE TABLE customers (
  id int(11) NOT NULL AUTO_INCREMENT,
  last_name varchar(255) NOT NULL,
  first_name varchar(255) NOT NULL,
  phone varchar(12) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 9,
AVG_ROW_LENGTH = 3276,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Создать таблицу `coaches`
--
CREATE TABLE coaches (
  id int(11) NOT NULL AUTO_INCREMENT,
  last_name varchar(255) NOT NULL,
  first_name varchar(255) NOT NULL,
  age int(2) NOT NULL,
  phone varchar(12) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 5461,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Создать таблицу `workouts`
--
CREATE TABLE workouts (
  id int(11) NOT NULL AUTO_INCREMENT,
  customer_id int(11) NOT NULL,
  coach_id int(11) NOT NULL,
  w_date date NOT NULL DEFAULT '0000-00-00',
  w_time varchar(5) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 3,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

--
-- Создать внешний ключ
--
ALTER TABLE workouts
ADD CONSTRAINT FK_workouts_coaches_id FOREIGN KEY (coach_id)
REFERENCES coaches (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Создать внешний ключ
--
ALTER TABLE workouts
ADD CONSTRAINT FK_workouts_customers_id FOREIGN KEY (customer_id)
REFERENCES customers (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Создать таблицу `gyms`
--
CREATE TABLE gyms (
  id int(11) NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 8192,
CHARACTER SET utf8,
COLLATE utf8_general_ci;

-- 
-- Вывод данных для таблицы customers
--
INSERT INTO customers VALUES
(1, 'Sokolov', 'Andrey', '79377488274'),
(2, 'Petrova', 'Natalia', '79463782746'),
(3, 'Ivanova', 'Maria', '78455367892'),
(4, 'Morgunov', 'Konstantin', '79456356746'),
(5, 'Melkova', 'Ekaterina', '79467366748'),
(8, 'Belov', 'Egor', '79456277847');

-- 
-- Вывод данных для таблицы coaches
--
INSERT INTO coaches VALUES
(1, 'Kiselev', 'Maksim', 30, '79456378271'),
(2, 'Sergeev', 'Nikita', 27, '79351780673'),
(3, 'Nikitina', 'Anna', 27, '79267865145');

-- 
-- Вывод данных для таблицы workouts
--
INSERT INTO workouts VALUES
(1, 1, 1, '2028-03-20', '15:00'),
(2, 8, 2, '2030-03-20', '19:00');

-- 
-- Вывод данных для таблицы gyms
--
INSERT INTO gyms VALUES
(1, 'dance'),
(2, 'fitness'),
(3, 'training');

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;