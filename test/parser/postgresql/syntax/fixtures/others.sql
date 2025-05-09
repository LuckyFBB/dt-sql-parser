-- ABORT
ABORT WORK;
ABORT TRANSACTION;
ABORT AND NO CHAIN;

-- ANALYZE
ANALYZE VERBOSE table_name ( column_name, column_name2);
ANALYZE VERBOSE;
ANALYZE (VERBOSE false);
ANALYZE (SKIP_LOCKED true);
ANALYZE (BUFFER_USAGE_LIMIT 4);
ANALYZE (SKIP_LOCKED false, SKIP_LOCKED false, BUFFER_USAGE_LIMIT '4KB');
ANALYZE (SKIP_LOCKED false, SKIP_LOCKED false, BUFFER_USAGE_LIMIT '4KB') table_name ( column_name, column_name2);
ANALYZE;

-- BEGIN
BEGIN WORK ISOLATION LEVEL READ UNCOMMITTED
    READ WRITE
    NOT DEFERRABLE;

-- CALL
CALL name (name => value);
CALL name;

-- CHECKPOINT
CHECKPOINT;

-- CLUSTER
CLUSTER VERBOSE table_name USING index_name;
CLUSTER (VERBOSE, VERBOSE TRUE) table_name USING index_name;
CLUSTER VERBOSE;
CLUSTER;

-- CLOSE
CLOSE ALL;
CLOSE name_2;

-- COMMENT
COMMENT ON
ACCESS METHOD object_name IS 'text';
COMMENT ON
AGGREGATE agg_name (agg_type, agg_type2) IS 'text';
COMMENT ON CAST (source_type AS target_type) IS 'text';
COMMENT ON COLLATION object_name IS 'text';
COMMENT ON COLUMN relation_name.column_name IS 'text';
COMMENT ON CONSTRAINT constraint_name ON table_name IS 'text'
COMMENT ON CONSTRAINT constraint_name ON DOMAIN domain_name IS 'text'
COMMENT ON CONVERSION object_name IS 'text';
COMMENT ON CONSTRAINT constraint_name ON table_name IS 'text';
COMMENT ON DATABASE object_name IS 'text';
COMMENT ON DOMAIN object_name IS 'text';
COMMENT ON EXTENSION object_name IS 'text';
COMMENT ON EVENT TRIGGER object_name IS 'text';
COMMENT ON FOREIGN DATA WRAPPER object_name IS 'text';
COMMENT ON FOREIGN TABLE object_name IS 'text';
COMMENT ON FUNCTION function_name ( INOUT argname timestamp) IS 'text';
COMMENT ON INDEX object_name IS 'text';
COMMENT ON LARGE OBJECT 346344 IS 'text';
COMMENT ON MATERIALIZED VIEW object_name IS 'text';
COMMENT ON OPERATOR -(int, NONE) IS 'text';
COMMENT ON OPERATOR CLASS object_name USING index_method IS 'text';
COMMENT ON OPERATOR FAMILY object_name USING index_method IS 'text';
COMMENT ON POLICY policy_name ON table_name IS 'text';
COMMENT ON PROCEDURAL LANGUAGE object_name IS 'text';
COMMENT ON PROCEDURE procedure_name IS 'text';
COMMENT ON PUBLICATION object_name IS 'text';
COMMENT ON ROLE object_name IS 'text';
COMMENT ON ROUTINE routine_name IS 'text';
COMMENT ON RULE rule_name ON table_name IS 'text';
COMMENT ON SCHEMA object_name IS 'text';
COMMENT ON SEQUENCE object_name IS 'text';
COMMENT ON SERVER object_name IS 'text';
COMMENT ON STATISTICS object_name IS 'text';
COMMENT ON SUBSCRIPTION object_name IS 'text';
COMMENT ON TABLE object_name IS 'text';
COMMENT ON TABLESPACE object_name IS 'text';
COMMENT ON TEXT SEARCH CONFIGURATION object_name IS 'text';
COMMENT ON TEXT SEARCH DICTIONARY object_name IS 'text';
COMMENT ON TEXT SEARCH PARSER object_name IS 'text';
COMMENT ON TEXT SEARCH TEMPLATE object_name IS 'text';
COMMENT ON TRIGGER trigger_name ON table_name IS 'text';
COMMENT ON TYPE object_name IS 'text';
COMMENT ON VIEW object_name IS 'text';

-- COMMIT
COMMIT TRANSACTION;
COMMIT WORK;
COMMIT AND NO CHAIN;

-- COMMIT PREPARED
COMMIT PREPARED 'foobar';

-- COPY
COPY table_name ( column_name, column_name2) 
FROM PROGRAM 'command'
WITH ( FORMAT format_name);
COPY (SELECT * FROM td)
    TO STDOUT
    WITH (FORMAT format_name, FREEZE true, DELIMITER 'delimiter_character', NULL 'null_string', DEFAULT 'default_string',
    HEADER boolean, QUOTE 'quote_character',
    ESCAPE 'escape_character',
    FORCE_QUOTE ( column_name),
    FORCE_NOT_NULL ( column_name),
    FORCE_NULL ( column_name, *),
    ON_ERROR error_action,
    ENCODING 'encoding_name',
    LOG_VERBOSITY verbosity);
-- COPY MERGE
COPY MERGE INTO ONLY target_table_name * AS target_alias
USING ONLY source_table_name * ON s.winename = w.winename
WHEN MATCHED AND s.winename = w.winename THEN UPDATE SET column_name = stock + 3
WHEN NOT MATCHED AND stock_delta + stock > 0 THEN INSERT ( column_name) OVERRIDING SYSTEM VALUE VALUES (s.winename)
WHEN MATCHED THEN DELETE RETURNING merge_action(), w.* TO filename 
WITH (FORMAT format_name, FREEZE true, DELIMITER 'delimiter_character', NULL 'null_string', DEFAULT 'default_string',
    HEADER boolean, QUOTE 'quote_character',
    ESCAPE 'escape_character',
    FORCE_QUOTE ( column_name));
-- DEALLOCATE
DEALLOCATE PREPARE name;
DEALLOCATE PREPARE ALL;

-- DECLARE
DECLARE name BINARY INSENSITIVE NO SCROLL CURSOR WITH HOLD FOR
SELECT
    *
FROM
    tb;

DECLARE name CURSOR FOR
SELECT
    *
FROM
    abs;

-- DISCARD
DISCARD TEMPORARY;
DISCARD PLANS;
DISCARD ALL;
DISCARD TEMP;

-- DO
DO LANGUAGE lang_name '$$DECLARE';
DO '$$DECLARE';

-- END
END TRANSACTION;
END WORK;

-- EXECUTE
EXECUTE name ( parameter, parameter2);

-- EXPLAIN
EXPLAIN ( ANALYZE 'true',VERBOSE true,  COSTS TRUE, FORMAT TEXT) SELECT * FROM no_nw;
EXPLAIN ANALYZE VERBOSE SELECT * FROM no_nw;
EXPLAIN SELECT * FROM no_nw;

-- FETCH
FETCH NEXT FROM cursor_name;

-- GRANT 
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER
    ON TABLE table_name, table_name2
    TO GROUP role_name,PUBLIC WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA schema_name, schema_name2 TO PUBLIC;
GRANT SELECT( column_name, column_name2), INSERT( column_name, column_name2), UPDATE( column_name, column_name2), REFERENCES ( column_name, column_name2)
    ON TABLE table_name
    TO GROUP role_name WITH GRANT OPTION;
GRANT ALL PRIVILEGES ( column_name, column_name2) ON table_name TO role_name;
GRANT USAGE, SELECT, UPDATE
    ON SEQUENCE sequence_name 
    TO GROUP role_name, PUBLIC WITH GRANT OPTION;
GRANT ALL PRIVILEGES
    ON ALL SEQUENCES IN SCHEMA schema_name
    TO PUBLIC WITH GRANT OPTION;
GRANT CREATE, CONNECT, TEMPORARY, TEMP
    ON DATABASE database_name
    TO GROUP role_name, PUBLIC WITH GRANT OPTION;
GRANT role_name TO role_name;

-- IMPORT FOREIGN SCHEMA
IMPORT FOREIGN SCHEMA remote_schema
    LIMIT TO ( table_name)
    FROM SERVER server_name
    INTO local_schema
    OPTIONS ( option 'value');

-- LISTEN
LISTEN channel;

-- LOAD
LOAD 'filename';

-- LOCK  
LOCK TABLE ONLY name * IN ACCESS SHARE MODE NOWAIT;

-- MOVE
MOVE NEXT FROM cursor_name;

-- MERGE
WITH query_name (id) AS (SELECT id FROM table_expression)
MERGE INTO ONLY target_table_name * AS target_alias
USING ONLY source_table_name * ON s.winename = w.winename
WHEN MATCHED AND s.winename = w.winename THEN UPDATE SET column_name = stock + 3
WHEN NOT MATCHED AND stock_delta + stock > 0 THEN INSERT ( column_name) OVERRIDING SYSTEM VALUE VALUES (s.winename)
WHEN MATCHED THEN DELETE RETURNING merge_action(), w.*;

-- NOTIFY
NOTIFY virtual, 'This is the payload';

-- PREPARE
PREPARE name ( int, numeric) AS INSERT INTO foo VALUES($1, $2, $3, $4);

--PREPARE MERGE
PREPARE fooplan (int, text, bool, numeric) AS
    MERGE INTO ONLY target_table_name * AS target_alias
USING ONLY source_table_name * ON s.winename = w.winename
WHEN MATCHED AND s.winename = w.winename THEN UPDATE SET column_name = stock + 3
WHEN NOT MATCHED AND stock_delta + stock > 0 THEN INSERT ( column_name) OVERRIDING SYSTEM VALUE VALUES (s.winename)
WHEN MATCHED THEN DELETE RETURNING merge_action(), w.*;

-- PREPARE TRANSACTION
PREPARE TRANSACTION 'foobar';

-- REASSIGN OWNED
REASSIGN OWNED BY old_role TO new_role;

-- REFRESH MATERIALIZED VIEW
REFRESH MATERIALIZED VIEW name WITH NO DATA;

-- REINDEX
REINDEX DATABASE CONCURRENTLY dbname;
REINDEX TABLE tbname;
REINDEX INDEX indexname;
REINDEX SYSTEM sysname;

-- RELEASE SAVEPOINT
RELEASE SAVEPOINT savepoint_name;

-- RESET
RESET configuration_parameter;
RESET ALL;

-- REVOKE
REVOKE GRANT OPTION FOR
REFERENCES, CREATE
    ON TABLE table_name
    FROM GROUP role_name, PUBLIC, SESSION_USER
    RESTRICT;
REVOKE ALL PRIVILEGES ON accounts FROM CURRENT_USER;
REVOKE CREATE ON SCHEMA public_name FROM CURRENT_ROLE;

-- ROLLBACK
ROLLBACK TRANSACTION AND NO CHAIN;
ROLLBACK WORK;

-- ROLLBACK PREPARED
ROLLBACK PREPARED 'foobar';

-- ROLLBACK TO SAVEPOINT
ROLLBACK TRANSACTION TO SAVEPOINT savepoint_name;
ROLLBACK WORK TO SAVEPOINT savepoint_name;
ROLLBACK TO savepoint_name;

-- SAVEPOINT
SAVEPOINT savepoint_name;

-- SECURITY LABEL
SECURITY LABEL FOR provider ON  TABLE object_name IS 'label';
SECURITY LABEL FOR provider ON  COLUMN table_name.column_name IS 'label';
SECURITY LABEL FOR provider ON  AGGREGATE agg_name (agg_type, agg_type2) IS 'label';
SECURITY LABEL FOR provider ON  DATABASE object_name IS 'label';
SECURITY LABEL FOR provider ON  DOMAIN object_name IS 'label';
SECURITY LABEL FOR provider ON  EVENT TRIGGER object_name IS 'label';
SECURITY LABEL FOR provider ON  FOREIGN TABLE object_name IS 'label';
SECURITY LABEL FOR provider ON FUNCTION function_name ( VARIADIC arg_name timestamp) IS 'label';
SECURITY LABEL FOR provider ON  LARGE OBJECT 2432 IS 'label';
SECURITY LABEL FOR provider ON  MATERIALIZED VIEW object_name IS 'label';
SECURITY LABEL FOR provider ON PROCEDURAL LANGUAGE object_name IS 'label';
SECURITY LABEL FOR provider ON  ROLE object_name IS 'label';
SECURITY LABEL FOR provider ON  SCHEMA object_name IS 'label';
SECURITY LABEL FOR provider ON  SEQUENCE object_name IS 'label';
SECURITY LABEL FOR provider ON  TABLESPACE object_name IS 'label';
SECURITY LABEL FOR provider ON  TYPE object_name IS 'label';
SECURITY LABEL FOR provider ON  VIEW object_name IS 'label';

-- SET
SET SESSION configuration_parameter TO DEFAULT;
SET LOCAL TIME ZONE LOCAL;

-- SET CONSTRAINTS
SET CONSTRAINTS ALL IMMEDIATE;
SET CONSTRAINTS name1, name2 DEFERRED;

-- SET ROLE
SET SESSION ROLE role_name;
SET LOCAL ROLE NONE;
RESET ROLE;

-- SET SESSION AUTHORIZATION
SET SESSION SESSION AUTHORIZATION user_name;
SET LOCAL SESSION AUTHORIZATION DEFAULT;
RESET SESSION AUTHORIZATION;

-- SET TRANSACTION
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
    READ WRITE
    NOT DEFERRABLE;
SET TRANSACTION SNAPSHOT '000003A1-1';
SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY DEFERRABLE;

-- SHOW
SHOW name;
SHOW ALL;

-- START TRANSACTION
START TRANSACTION ISOLATION LEVEL SERIALIZABLE
    READ WRITE
    NOT DEFERRABLE, ISOLATION LEVEL REPEATABLE READ READ ONLY DEFERRABLE;
START TRANSACTION;

-- TRUNCATE
TRUNCATE TABLE ONLY name
    RESTART IDENTITY CASCADE;
TRUNCATE TABLE ONLY name
   CONTINUE IDENTITY RESTRICT;
TRUNCATE name;

-- UNLISTEN
UNLISTEN *;
UNLISTEN channel;

-- VACUUM
VACUUM ( FULL, FREEZE, VERBOSE, ANALYZE, DISABLE_PAGE_SKIPPING, SKIP_LOCKED, INDEX_CLEANUP, PROCESS_MAIN, PROCESS_TOAST, TRUNCATE, PARALLEL 4,SKIP_DATABASE_STATS, ONLY_DATABASE_STATS, BUFFER_USAGE_LIMIT) table_name (column_name, column_name2);
VACUUM FULL FREEZE VERBOSE  table_name;
VACUUM FULL FREEZE VERBOSE ANALYZE table_name (column_name,column_name2);
VACUUM ANALYZE;
ANALYZE;

-- VALUES
VALUES (1, '3'), (3, 'sdsd')
    ORDER BY sort_expression ASC
    LIMIT 20
    OFFSET 324 ROWS;
VALUES (1, '3'), (3, 'sdsd');

