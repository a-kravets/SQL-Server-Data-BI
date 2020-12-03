/*ЗАДАНИЕ 1.
Создайте скалярную функцию с одним аргументом типа numeric(18,0). Функция должна возвращать текстовую
строку, содержащую число, полученное как аргумент и слово «гигабайт» или «гигабайта».
Например:
для числа 32 – '32 гигабайта’
для числа 128 – '128 гигабайт’
Функция должна обработать все варианты чисел, встречающихся в столбце phones.memory. Для всех прочих чисел
функция должна добавить к нему слово «гб.». Если аргумент будет иметь значение null функция должна возвращать
«-».*/

CREATE FUNCTION memory_f(@num numeric(18, 0))
RETURNS nchar(9)
BEGIN
	IF RIGHT(@num, 1) = 0 OR RIGHT(@num, 1) = 1 OR RIGHT(@num, 1) = 5 OR RIGHT(@num, 1) = 6
		OR RIGHT(@num, 1) = 7 OR RIGHT(@num, 1) = 8 OR RIGHT(@num, 1) = 9 RETURN 'гигабайт'
	IF RIGHT(@num, 1) = 2 OR RIGHT(@num, 1) = 3 OR RIGHT(@num, 1) = 4 RETURN 'гигабайта'
	IF RIGHT(@num, 1) IS NULL RETURN '-'
	RETURN 'гб'
END

SELECT
	a.memory
	,dbo.memory_f(memory)
FROM phones a

/* List of all user-defined functions
FN = SQL scalar function
IF = SQL inline table valued function
TF = SQL table valued function
AF = CLR aggregate function
FS = CLR scalar function
FT = CLR table valued function*/

SELECT
     name AS 'Function Name',
     SCHEMA_NAME(schema_id) AS 'Schema',
     type_desc AS 'Function Type', 
     create_date AS 'Created Date'
FROM
     sys.objects
WHERE
     type in ('FN', 'IF', 'FN', 'AF', 'FS', 'FT');


/*ЗАДАНИЕ 2.
Создайте функцию возвращающую таблицу, которая будет возвращать результат следующего SQL-запроса: выбрать
все столбцы из таблицы clients, оставить только те строки, в которых значение кода мобильного оператора в столбце
client_tlf равно аргументу функции.*/CREATE FUNCTION client_phone(@c_phone int)RETURNS TABLERETURN SELECT	*FROM clientsWHERE LEFT(client_tlf, 5) = @c_phoneSELECT * FROM dbo.client_phone(38067)/*ЗАДАНИЕ 3.
Создайте много операторную функцию с двумя аргументами: начальная дата и конечная дата. Функция должна
возвращать таблицу, состоящую из одного столбца, содержащего все номера недель года, находящиеся в
промежутке от начальной до конечной даты.*/

CREATE FUNCTION period(@begin_date date, @end_date date)
RETURNS @week_num TABLE(week_number tinyint)
BEGIN
	DECLARE @cur_date date
	SET @cur_date = @begin_date
	WHILE DATEDIFF(wk,@cur_date,@end_date) >= 0
		BEGIN
			INSERT INTO @week_num(week_number) VALUES(DATEPART(week, @cur_date))
			SET @cur_date = DATEADD(wk, 1, @cur_date)
		END
RETURN END

SELECT * FROM dbo.period('2007-04-21','2007-09-21')

/*ЗАДАНИЕ 4.
Создайте хранимую процедуру, которая будет увеличивать количество отзывов по заданному phone_id в таблице
phone_comments. Кроме phone_id, входными параметрами функции будут параметры с количеством отзывов
каждого из четырёх типов, которое необходимо будет добавить к содержимому соответствующих столбцов таблицы.
Предусмотрите возможность того, что в столбцах с количеством отзывов может содержаться значение null.*/

CREATE PROCEDURE add_comment @p_phone_id int, @p_negative int, @p_neutral int, @p_positive int, @p_enthusiastic int
AS
UPDATE phone_comment
SET negative = ISNULL(negative, 0) + @p_negative,
 neutral = ISNULL(neutral, 0) + @p_neutral,
 positive = ISNULL(positive, 0) + @p_positive,
 enthusiastic = ISNULL(enthusiastic, 0) + @p_enthusiastic
WHERE phone_id = @p_phone_id

EXEC add_comment 190323,1,0,0,0

/*ЗАДАНИЕ 5.
Создайте триггер, который будет запускаться после добавления новой строки в таблицу phone_comments. Триггер
должен присвоить значение 0 полю добавляемой строки, если оно является null.*/CREATE TRIGGER TR_new_commentON phone_commentAFTER INSERTASUPDATE phone_comment
SET negative = ISNULL(negative, 0),
 neutral = ISNULL(neutral, 0),
 positive = ISNULL(positive, 0),
 enthusiastic = ISNULL(enthusiastic, 0)