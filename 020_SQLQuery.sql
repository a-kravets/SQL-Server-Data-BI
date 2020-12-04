SELECT 'ANSI_NULLS' AS Parameter, SESSIONPROPERTY ('ANSI_NULLS') AS Value

UNION

SELECT 'Collation' AS Parameter, DatabasePropertyEx(db_name(),'Collation') AS Value

UNION

SELECT 'CONCAT_NULL_YIELDS_NULL' AS Parameter, SESSIONPROPERTY ('CONCAT_NULL_YIELDS_NULL') AS Value

UNION

SELECT 'QUOTED_IDENTIFIER' AS Parameter, SESSIONPROPERTY ('QUOTED_IDENTIFIER') AS Value

UNION

SELECT  'Date format' AS Parameter, (SELECT date_format
FROM  sys.dm_exec_sessions 
WHERE  session_id = @@spid) AS Value

UNION

SELECT 'Language' AS Parameter, @@LANGUAGE AS Value