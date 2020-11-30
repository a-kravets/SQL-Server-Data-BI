/*ЗАДАНИЕ 1.
Создайте таблицу с именем CRM_SEQUENCE , которая состоит из столбца с названием INCOMING_ID, тип данных
Smallint и столбца с названием OUTGOING_ID, тип данных Smallint*/

CREATE TABLE CRM_SEQUENCE (
			INCOMING_ID Smallint NULL,
			OUTGOING_ID Smallint NULL);

SELECT * FROM CRM_SEQUENCE

/*ЗАДАНИЕ 2.
Вставьте в таблицу CRM _SEQUENCE строку со значениями: INCOMING_ID=1 и OUTGOING_ID=15.
Вставьте в таблицу CRM _SEQUENCE строку со значениями: INCOMING_ID=2 и OUTGOING_ID=16.
Вставьте в таблицу CRM _SEQUENCE строку со значениями: INCOMING_ID=8 и OUTGOING_ID=17*/

INSERT INTO CRM_SEQUENCE (INCOMING_ID, OUTGOING_ID)
VALUES	(1, 15),
		(2, 16),
		(8, 17);

SELECT * FROM CRM_SEQUENCE

/*ЗАДАНИЕ 3.
Измените таблицу CRM _SEQUENCE так, чтобы запретить возможность появления значения NULL в столбцах
INCOMING_ID и OUTGOING_ID*/

ALTER TABLE CRM_SEQUENCE
ALTER COLUMN INCOMING_ID Smallint NOT NULL;

ALTER TABLE CRM_SEQUENCE
ALTER COLUMN OUTGOING_ID Smallint NOT NULL;

/*ЗАДАНИЕ 4.
Добавьте в таблицу CRM _SEQUENCE ограничение PRIMARY KEY по столбцам INCOMING_ID и OUTGOING_ID*/

ALTER TABLE CRM_SEQUENCE
ADD CONSTRAINT PK_id PRIMARY KEY (INCOMING_ID, OUTGOING_ID)


/*ЗАДАНИЕ 5.
Напишите запрос SQL, который связывает таблицу CRM_SEQUENCE с таблицей CRM_CONT_TYPE по столбцам
INCOMING_ID и CONTACT_ID. Добавьте ещё один JOIN, связывающий таблицу CRM_SEQUENCE с таблицей
CRM_CONT_TYPE по столбцам OUTGOING_ID и CONTACT_ID. Задайте связываемым таблицам три разных псевдонима.
Выведите столбцы INCOMING_ID и OUTGOING_ID, а также столбец CONTACT_DESCRIPTOR из первой связанной таблицы
CRM_CONT_TYPE, а также столбец CONTACT_DESCRIPTOR из второй связанной таблицы CRM_CONT_TYPE*/

SELECT
	cs.INCOMING_ID
	,cs.OUTGOING_ID
	,cct.CONTACT_DESCRIPTOR
	,cct2.CONTACT_DESCRIPTOR
FROM CRM_SEQUENCE cs
LEFT JOIN CRM_CONT_TYPE cct ON cs.INCOMING_ID = cct.CONTACT_ID
LEFT JOIN CRM_CONT_TYPE cct2 ON cs.OUTGOING_ID = cct.CONTACT_ID
