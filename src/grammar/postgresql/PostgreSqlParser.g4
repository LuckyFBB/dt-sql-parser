/*
 * [The "MIT license"]
 * Copyright (C) 2014 Sam Harwell, Tunnel Vision Laboratories, LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * 1. The above copyright notice and this permission notice shall be included in
 *    all copies or substantial portions of the Software.
 * 2. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 *    DEALINGS IN THE SOFTWARE.
 * 3. Except as contained in this notice, the name of Tunnel Vision
 *    Laboratories, LLC. shall not be used in advertising or otherwise to
 *    promote the sale, use or other dealings in this Software without prior
 *    written authorization from Tunnel Vision Laboratories, LLC.
 */

/**
 * This file is an adaptation of antlr's sql/postgresql/PostgreSQLParser.g4 grammar.
 * Reference: https://github.com/antlr/grammars-v4/blob/master/sql/postgresql/PostgreSQLParser.g4
 */

/**
 * Reference Doc: https://www.postgresql.org/docs/16.1/sql-commands.html
 */

// $antlr-format alignTrailingComments true, columnLimit 150, minEmptyLines 1, maxEmptyLinesToKeep 1, reflowComments false, useTab false
// $antlr-format allowShortRulesOnASingleLine false, allowShortBlocksOnASingleLine true, alignSemicolons hanging, alignColons hanging
// $antlr-format spaceBeforeAssignmentOperators false, keepEmptyLinesAtTheStartOfBlocks true

parser grammar PostgreSqlParser;

options {
    tokenVocab= PostgreSqlLexer;
    caseInsensitive= true;
    superClass=SQLParserBase;
}

@header {
import { SQLParserBase } from '../SQLParserBase';
}

program
    : singleStmt* EOF
    ;

singleStmt
    : stmt SEMI?
    ;

stmt
    : alterEventTrigStmt
    | alterCollationStmt
    | alterDatabaseStmt
    | alterDatabaseSetStmt
    | alterDefaultPrivilegesStmt
    | alterDomainStmt
    | alterEnumStmt
    | alterExtensionStmt
    | alterExtensionContentsStmt
    | alterFdwStmt
    | alterForeignServerStmt
    | alterFunctionStmt
    | alterGroupStmt
    | alterObjectDependsStmt
    | alterObjectSchemaStmt
    | alterOwnerStmt
    | alterOperatorStmt
    | alterTypeStmt
    | alterPolicyStmt
    | alterProcedureStmt
    | alterSeqStmt
    | alterSystemStmt
    | alterTableStmt
    | alterTblSpcStmt
    | alterCompositeTypeStmt
    | alterPublicationStmt
    | alterRoleSetStmt
    | alterRoutineStmt
    | alterRoleStmt
    | alterSubscriptionStmt
    | alterStatsStmt
    | alterSearchConfigurationStmt
    | alterSearchDictionaryStmt
    | alterUserMappingStmt
    | analyzeStmt
    | callStmt
    | checkPointStmt
    | closePortalStmt
    | clusterStmt
    | commentStmt
    | constraintsSetStmt
    | copyStmt
    | createAccessMethodStmt
    | createAsStmt
    | createAssertionStmt
    | createCastStmt
    | createConversionStmt
    | createDomainStmt
    | createExtensionStmt
    | createFdwStmt
    | createForeignServerStmt
    | createForeignTableStmt
    | createFunctionStmt
    | createGroupStmt
    | createMaterializedViewStmt
    | createOperatorClassStmt
    | createOperatorFamilyStmt
    | createPublicationStmt
    | alterOperatorFamilyStmt
    | createPolicyStmt
    | createProceduralLangStmt
    | createSchemaStmt
    | createSeqStmt
    | createStmt
    | createSubscriptionStmt
    | createStatsStmt
    | createTableSpaceStmt
    | createTransformStmt
    | createTrigStmt
    | createEventTrigStmt
    | createRoleStmt
    | createUserStmt
    | createUserMappingStmt
    | createDbStmt
    | dealLocateStmt
    | declareCursorStmt
    | defineStmt
    | deleteStmt
    | discardStmt
    | doStmt
    | dropStmt
    | executeStmt
    | explainStmt
    | fetchStmt
    | grantStmt
    | grantRoleStmt
    | mergeStmt
    | importForeignSchemaStmt
    | indexStmt
    | insertStmt
    | listenStmt
    | refreshMaterializedViewStmt
    | loadStmt
    | lockStmt
    | notifyStmt
    | prepareStmt
    | reassignOwnedStmt
    | reindexStmt
    | removeAggregateStmt
    | removeFuncStmt
    | removeOperatorStmt
    | renameStmt
    | revokeStmt
    | revokeRoleStmt
    | ruleStmt
    | secLabelStmt
    | selectStmt
    | transactionStmt
    | truncateStmt
    | unListenStmt
    | updateStmt
    | vacuumStmt
    | variableResetStmt
    | variableSetStmt
    | variableShowStmt
    | viewStmt
    | MetaCommand EndMetaCommand?
    ;

callStmt
    : KW_CALL func_application
    ;

createRoleStmt
    : KW_CREATE KW_ROLE roleSpec KW_WITH? createOperatorRoleElem*
    ;

alterOperatorRoleElem
    : KW_PASSWORD (stringConst | KW_NULL)
    | (KW_ENCRYPTED | KW_UNENCRYPTED) KW_PASSWORD stringConst
    | KW_INHERIT
    | KW_NOINHERIT
    | KW_CREATEUSER
    | KW_NOCREATEUSER
    | KW_CREATEROLE
    | KW_NOCREATEROLE
    | KW_CREATEDB
    | KW_NOCREATEDB
    | KW_SUPERUSER
    | KW_NOSUPERUSER
    | KW_LOGIN
    | KW_NOLOGIN
    | KW_REPLICATION
    | KW_NOREPLICATION
    | KW_BYPASSRLS
    | KW_NOBYPASSRLS
    | KW_CONNECTION KW_LIMIT signedConst
    | KW_VALID KW_UNTIL stringConst
    | KW_IN (KW_ROLE | KW_GROUP) name_list
    | (KW_ROLE | KW_USER) role_list
    | KW_ADMIN name_list
    | identifier
    ;

createOperatorRoleElem
    : alterOperatorRoleElem
    | KW_SYSID Integral
    | (KW_ADMIN | KW_ROLE) role_list
    | KW_IN (KW_ROLE | KW_GROUP) role_list
    ;

createUserStmt
    : KW_CREATE KW_USER roleSpec KW_WITH? createOperatorRoleElem*
    ;

alterRoleStmt
    : KW_ALTER (KW_ROLE | KW_USER) roleSpec KW_WITH? alterOperatorRoleElem*
    ;

alterRoleSetStmt
    : KW_ALTER (KW_ROLE | KW_USER) (KW_ALL | roleSpec) KW_IN KW_DATABASE database_name setOrResetClause
    ;

alterRoutineStmt
    : KW_ALTER KW_ROUTINE routine_name func_args? alter_routine_clause
    ;

alter_routine_clause
    : routine_action (routine_action)* KW_RESTRICT?
    | KW_RENAME KW_TO routine_name_create
    | KW_OWNER KW_TO roleSpec
    | KW_SET KW_SCHEMA schema_name_create
    | KW_NO? KW_DEPENDS KW_ON KW_EXTENSION colId
    ;

routine_action
    : KW_IMMUTABLE
    | KW_STABLE
    | KW_VOLATILE
    | KW_NOT? KW_LEAKPROOF
    | (KW_EXTERNAL? KW_SECURITY KW_INVOKER | KW_EXTERNAL? KW_SECURITY KW_DEFINER)
    | KW_PARALLEL (KW_UNSAFE | KW_RESTRICTED | KW_SAFE)
    | KW_COST colLabel
    | KW_ROWS colId
    | KW_SET colId (KW_TO | EQUAL) (colId | KW_DEFAULT)
    | KW_SET colId KW_FROM KW_CURRENT
    | KW_RESET (colId | KW_ALL)
    ;

createGroupStmt
    : KW_CREATE KW_GROUP roleSpec KW_WITH? createOperatorRoleElem*
    ;

alterGroupStmt
    : KW_ALTER KW_GROUP roleSpec (KW_ADD | KW_DROP) KW_USER role_list
    ;

createSchemaStmt
    : KW_CREATE KW_SCHEMA opt_if_not_exists? (
        schema_name_create? KW_AUTHORIZATION roleSpec
        | schema_name_create
    ) schema_stmt*
    ;

schema_name_create
    : any_name # schemaNameCreate
    ;

schema_stmt
    : createStmt
    | indexStmt
    | createSeqStmt
    | createTrigStmt
    | grantStmt
    | viewStmt
    ;

variableSetStmt
    : KW_SET (KW_LOCAL | KW_SESSION)? set_rest
    ;

set_rest
    : KW_TRANSACTION transaction_mode_list
    | KW_SESSION KW_CHARACTERISTICS KW_AS KW_TRANSACTION transaction_mode_list
    | set_rest_more
    ;

generic_set
    : (KW_ALL | var_name) (KW_TO | EQUAL)? (KW_DEFAULT | var_list)?
    ;

set_rest_more
    : KW_TIME KW_ZONE zone_value
    | KW_CATALOG stringConst
    | KW_SCHEMA schema_name
    | KW_NAMES (stringConst | KW_DEFAULT)?
    | KW_ROLE nonReservedWordOrStringConst
    | KW_SESSION KW_AUTHORIZATION nonReservedWordOrStringConst
    | KW_XML KW_OPTION document_or_content
    | KW_TRANSACTION KW_SNAPSHOT stringConst
    | var_name KW_FROM KW_CURRENT
    | generic_set
    ;

var_name
    : colId (DOT colId)*
    ;

var_list
    : var_value (COMMA var_value)*
    ;

var_value
    : opt_boolean_or_string
    | numericOnly
    ;

iso_level
    : KW_READ (KW_UNCOMMITTED | KW_COMMITTED)
    | KW_REPEATABLE KW_READ
    | KW_SERIALIZABLE
    ;

opt_boolean_or_string_column
    : KW_TRUE
    | KW_FALSE
    | KW_ON
    | column_name
    | type_func_name_keyword
    | stringConst
    ;

opt_boolean_or_string
    : KW_TRUE
    | KW_FALSE
    | KW_ON
    | nonReservedWordOrStringConst
    ;

zone_value
    : stringConst
    | KW_DEFAULT
    | identifier
    | KW_INTERVAL stringConst opt_interval?
    | KW_INTERVAL opt_float stringConst
    | numericOnly
    | KW_LOCAL
    ;

nonReservedWordOrStringConst
    : nonReservedWord
    | stringConst
    ;

variableResetStmt
    : KW_RESET reset_rest
    ;

reset_rest
    : KW_TIME KW_ZONE
    | KW_TRANSACTION KW_ISOLATION KW_LEVEL
    | KW_SESSION KW_AUTHORIZATION
    | KW_ALL
    | var_name
    ;

setOrResetClause
    : KW_SET set_rest
    | variableResetStmt
    ;

functionSetOrResetClause
    : KW_SET set_rest_more
    | variableResetStmt
    ;

variableShowStmt
    : KW_SHOW (
        var_name
        | KW_TIME KW_ZONE
        | KW_TRANSACTION KW_ISOLATION KW_LEVEL
        | KW_SESSION KW_AUTHORIZATION
        | KW_ALL
    )
    ;

constraintsSetStmt
    : KW_SET KW_CONSTRAINTS (KW_ALL | qualified_name_list) (KW_DEFERRED | KW_IMMEDIATE)
    ;

checkPointStmt
    : KW_CHECKPOINT
    ;

discardStmt
    : KW_DISCARD (KW_ALL | KW_TEMP | KW_TEMPORARY | KW_PLANS | KW_SEQUENCES)
    ;

alterTableStmt
    : KW_ALTER KW_TABLE opt_if_exists? relation_expr (alter_table_cmds | partition_cmd)
    | KW_ALTER KW_TABLE KW_ALL KW_IN optTableSpace (KW_OWNED KW_BY role_list)? KW_SET KW_TABLESPACE tablespace_name_create KW_NOWAIT?
    | KW_ALTER KW_TABLE opt_if_exists? table_name index_partition_cmd (
        KW_FOR KW_VALUES partition_bound_spec
        | KW_DEFAULT
    )
    | KW_ALTER KW_TABLE opt_if_exists? table_name KW_DETACH KW_PARTITION qualified_name (
        KW_CONCURRENTLY
        | KW_FINALIZE
    )?
    | KW_ALTER KW_INDEX opt_if_exists? qualified_name (alter_table_cmds | index_partition_cmd)
    | KW_ALTER KW_INDEX KW_ALL KW_IN optTableSpace (KW_OWNED KW_BY role_list)? KW_SET optTableSpace KW_NOWAIT?
    | KW_ALTER KW_SEQUENCE opt_if_exists? qualified_name alter_table_cmds
    | KW_ALTER KW_MATERIALIZED? KW_VIEW opt_if_exists? view_name alter_table_cmds
    | KW_ALTER KW_MATERIALIZED KW_VIEW KW_ALL KW_IN optTableSpace (KW_OWNED KW_BY role_list)? KW_SET KW_TABLESPACE tablespace_name_create KW_NOWAIT?
    | KW_ALTER KW_FOREIGN KW_TABLE opt_if_exists? relation_expr alter_table_cmds
    ;

alter_table_cmds
    : alter_table_cmd (COMMA alter_table_cmd)*
    ;

partition_bound_spec
    : KW_IN execute_param_clause
    | KW_FROM partition_bound_clause KW_TO partition_bound_clause
    | KW_WITH partition_with_clause
    ;

partition_bound_clause
    : OPEN_PAREN partition_bound_choose (COMMA partition_bound_choose)* CLOSE_PAREN
    ;

partition_bound_choose
    : execute_param_clause
    | KW_MINVALUE
    | KW_MAXVALUE
    ;

partition_with_clause
    : OPEN_PAREN KW_MODULUS numericOnly COMMA KW_REMAINDER numericOnly CLOSE_PAREN
    ;

partition_cmd
    : index_partition_cmd partitionBoundSpec
    | KW_DETACH KW_PARTITION qualified_name
    ;

index_partition_cmd
    : KW_ATTACH KW_PARTITION qualified_name
    ;

alter_table_cmd
    : KW_ADD (KW_CONSTRAINT colId)? constraintElem
    | KW_ALTER KW_CONSTRAINT colId constraintAttributeElem*
    | KW_VALIDATE KW_CONSTRAINT colId
    | KW_DROP KW_CONSTRAINT opt_if_exists? colId opt_drop_behavior?
    | KW_SET KW_WITHOUT (KW_OIDS | KW_CLUSTER)
    | KW_CLUSTER KW_ON colId
    | KW_SET (KW_LOGGED | KW_UNLOGGED)
    | KW_ENABLE (KW_REPLICA | KW_ALWAYS)? KW_TRIGGER
    | KW_DISABLE KW_TRIGGER (KW_ALL | KW_USER | colId)
    | KW_ENABLE (KW_ALWAYS | KW_REPLICA) KW_RULE colId
    | KW_DISABLE KW_RULE colId
    | KW_NO? KW_INHERIT qualified_name
    | KW_OF any_name
    | KW_NOT KW_OF
    | KW_OWNER KW_TO roleSpec
    | KW_SET KW_TABLESPACE tablespace_name_create
    | KW_REPLICA KW_IDENTITY (KW_NOTHING | KW_FULL | KW_DEFAULT | existingIndex)
    | (KW_ENABLE | KW_DISABLE | (KW_NO? KW_FORCE)) KW_ROW KW_LEVEL KW_SECURITY
    | KW_DROP KW_COLUMN? opt_if_exists? column_name opt_drop_behavior?
    | KW_ADD KW_COLUMN? opt_if_not_exists? column_def
    | KW_ALTER KW_COLUMN? column_name (alter_column_default | alter_generic_options)
    | KW_ALTER KW_COLUMN? column_name (KW_DROP | KW_SET) KW_NOT KW_NULL
    | KW_ALTER KW_COLUMN? column_name KW_DROP KW_EXPRESSION opt_if_exists?
    | KW_ALTER KW_COLUMN? column_name KW_SET KW_STATISTICS signedConst
    | (KW_ALTER KW_COLUMN? column_name)? (KW_SET | KW_RESET) relOptions
    | KW_ALTER KW_COLUMN? column_name KW_SET KW_STORAGE colId
    | KW_ALTER KW_COLUMN? column_name KW_ADD KW_GENERATED generated_when KW_AS KW_IDENTITY (
        OPEN_PAREN seqOptElem+ CLOSE_PAREN
    )?
    | KW_ALTER KW_COLUMN? column_name (
        KW_RESTART (KW_WITH? numericOnly)?
        | KW_SET (seqOptElem | KW_GENERATED generated_when)
    )+
    | KW_ALTER KW_COLUMN? column_name KW_DROP KW_IDENTITY opt_if_exists?
    | KW_ALTER KW_COLUMN? column_name (KW_SET KW_DATA)? KW_TYPE typename opt_collate_clause? (
        KW_USING expression
    )?
    | alter_generic_options
    ;

alter_column_default
    : KW_SET KW_DEFAULT expression
    | KW_DROP KW_DEFAULT
    ;

opt_drop_behavior
    : KW_CASCADE
    | KW_RESTRICT
    ;

opt_collate_clause
    : KW_COLLATE any_name
    ;

relOptions
    : OPEN_PAREN relOptionElem (COMMA relOptionElem)* CLOSE_PAREN
    ;

optRelOptions
    : KW_WITH relOptions
    ;

relOptionElem
    : colLabel (EQUAL def_arg | DOT def_elem)?
    ;

partitionBoundSpec
    : KW_FOR KW_VALUES KW_WITH OPEN_PAREN KW_MODULUS Integral COMMA KW_REMAINDER Integral CLOSE_PAREN
    | KW_FOR KW_VALUES KW_IN execute_param_clause
    | KW_FOR KW_VALUES KW_FROM execute_param_clause KW_TO execute_param_clause
    | KW_DEFAULT
    ;

alterCompositeTypeStmt
    : KW_ALTER KW_TYPE any_name alter_type_cmd (COMMA alter_type_cmd)*
    ;

alter_type_cmd
    : KW_ADD KW_ATTRIBUTE tableFuncElement opt_drop_behavior?
    | KW_DROP KW_ATTRIBUTE opt_if_exists? colId opt_drop_behavior?
    | KW_ALTER KW_ATTRIBUTE colId (KW_SET KW_DATA)? KW_TYPE typename opt_collate_clause? opt_drop_behavior?
    ;

closePortalStmt
    : KW_CLOSE (colId | KW_ALL)
    ;

copyStmt
    : KW_COPY KW_BINARY? table_name opt_column_list? (KW_FROM | KW_TO) KW_PROGRAM? (
        stringConst
        | KW_STDIN
        | KW_STDOUT
    ) (KW_USING? KW_DELIMITERS stringConst)? KW_WITH? copy_options where_clause?
    | KW_COPY OPEN_PAREN preParableStmt CLOSE_PAREN KW_TO KW_PROGRAM? (
        stringConst
        | KW_STDIN
        | KW_STDOUT
    ) KW_WITH? copy_options
    ;

copy_options
    : (
        KW_BINARY
        | KW_FREEZE
        | (KW_NULL | KW_DELIMITER | KW_ESCAPE | KW_QUOTE) KW_AS? stringConst
        | KW_CSV
        | KW_HEADER
        | KW_FORCE KW_QUOTE (column_list | STAR)
        | KW_FORCE KW_NOT? KW_NULL column_list
        | KW_ENCODING stringConst
    )*
    | OPEN_PAREN copy_generic_opt_elem (COMMA copy_generic_opt_elem)* CLOSE_PAREN
    ;

copy_generic_opt_elem
    : colLabel (
        opt_boolean_or_string
        | numericOnly
        | STAR
        | OPEN_PAREN opt_boolean_or_string_column (COMMA opt_boolean_or_string_column)* CLOSE_PAREN
    )?
    ;

createStmt
    : KW_CREATE optTemp? KW_TABLE opt_if_not_exists? table_name_create (
        OPEN_PAREN tableElementList? CLOSE_PAREN optInherit? partitionSpec? table_access_method_clause? optWith? onCommitOption? optTableSpace?
        | KW_OF any_name optTypedTableElEmentList? partitionSpec? table_access_method_clause? optWith? onCommitOption? optTableSpace?
        | KW_PARTITION KW_OF qualified_name optTypedTableElEmentList? partitionBoundSpec partitionSpec? table_access_method_clause? optWith?
            onCommitOption? optTableSpace?
    ) # columnCreateTable
    ;

optTemp
    : KW_TEMPORARY
    | KW_TEMP
    | (KW_LOCAL | KW_GLOBAL) (KW_TEMPORARY | KW_TEMP)
    | KW_UNLOGGED
    ;

optTypedTableElEmentList
    : OPEN_PAREN typedTableElement (COMMA typedTableElement)* CLOSE_PAREN
    ;

tableElementList
    : tableElement (COMMA tableElement)*
    ;

tableElement
    : (KW_CONSTRAINT colId)? constraintElem
    | column_def
    | KW_LIKE qualified_name ((KW_INCLUDING | KW_EXCLUDING) tableLikeOption)*
    ;

typedTableElement
    : column_name_create (KW_WITH KW_OPTIONS)? colConstraint*
    | (KW_CONSTRAINT colId)? constraintElem
    ;

column_def
    : column_name_create colType=typename create_generic_options? (
        KW_STORAGE (KW_PLAIN | KW_EXTERNAL | KW_EXTENDED | KW_MAIN | KW_DEFAULT | colId)
    )? (KW_COMPRESSION colId)? (opt_collate_clause)? (KW_WITH KW_OPTIONS)? colConstraint*
    ;

colConstraint
    : (KW_CONSTRAINT colId)? colConstraintElem (KW_NOT? KW_DEFERRABLE)? (
        KW_INITIALLY (KW_DEFERRED | KW_IMMEDIATE)
    )?
    ;

colConstraintElem
    : KW_NOT? KW_NULL
    | KW_UNIQUE opt_definition? optConstableSpace?
    | KW_UNIQUE (KW_NULLS KW_NOT? KW_DISTINCT)? (
        (KW_INCLUDE index_params)? with_clause? optConstableSpace?
    )
    | KW_PRIMARY KW_KEY opt_definition? optConstableSpace?
    | KW_CHECK OPEN_PAREN expression CLOSE_PAREN (KW_NO KW_INHERIT)?
    | KW_DEFAULT primaryExpression
    | KW_GENERATED generated_when KW_AS (
        KW_IDENTITY (OPEN_PAREN seqOptElem+ CLOSE_PAREN)?
        | OPEN_PAREN expression CLOSE_PAREN KW_STORED
    )
    | KW_REFERENCES qualified_name opt_column_list? key_match? key_actions?
    | opt_collate_clause
    ;

generated_when
    : KW_ALWAYS
    | KW_BY KW_DEFAULT
    ;

tableLikeOption
    : KW_COMMENTS
    | KW_CONSTRAINTS
    | KW_DEFAULTS
    | KW_IDENTITY
    | KW_GENERATED
    | KW_INDEXES
    | KW_STATISTICS
    | KW_STORAGE
    | KW_ALL
    ;

constraintElem
    : KW_CHECK OPEN_PAREN expression CLOSE_PAREN constraintAttributeElem*
    | (KW_UNIQUE | ( KW_PRIMARY KW_KEY)) (
        opt_column_list opt_c_include? opt_definition? optConstableSpace? constraintAttributeElem*
        | existingIndex constraintAttributeElem*
    )
    | KW_EXCLUDE table_access_method_clause? OPEN_PAREN exclusionConstraintElem (
        COMMA exclusionConstraintElem
    )* CLOSE_PAREN opt_c_include? opt_definition? optConstableSpace? (
        KW_WHERE OPEN_PAREN expression CLOSE_PAREN
    )? constraintAttributeElem*
    | KW_FOREIGN KW_KEY opt_column_list KW_REFERENCES qualified_name opt_column_list? key_match? key_actions? constraintAttributeElem*
    ;

opt_column_list
    : OPEN_PAREN column_list CLOSE_PAREN
    ;

opt_column_list_create
    : OPEN_PAREN column_name_create (COMMA column_name_create)* CLOSE_PAREN
    ;

column_list
    : column_name (COMMA column_name)*
    ;

opt_c_include
    : KW_INCLUDE opt_column_list
    ;

key_match
    : KW_MATCH (KW_FULL | KW_PARTIAL | KW_SIMPLE)
    ;

exclusionConstraintElem
    : index_elem KW_WITH (any_operator | KW_OPERATOR OPEN_PAREN any_operator CLOSE_PAREN)
    ;

key_actions
    : key_update key_delete?
    | key_delete key_update?
    ;

key_update
    : KW_ON KW_UPDATE key_action
    ;

key_delete
    : KW_ON KW_DELETE key_action
    ;

key_action
    : KW_NO KW_ACTION
    | KW_RESTRICT
    | KW_CASCADE
    | KW_SET (KW_NULL | KW_DEFAULT) column_list?
    ;

optInherit
    : KW_INHERITS OPEN_PAREN qualified_name_list CLOSE_PAREN
    ;

partitionSpec
    : KW_PARTITION KW_BY colId OPEN_PAREN part_elem (COMMA part_elem)* CLOSE_PAREN
    ;

part_elem
    : (column_name | func_expr_windowless | (OPEN_PAREN expression CLOSE_PAREN)) opt_collate_clause? any_name?
    ;

table_access_method_clause
    : KW_USING colId
    ;

optWith
    : KW_WITH relOptions
    | (KW_WITHOUT | KW_WITH) KW_OIDS
    ;

onCommitOption
    : KW_ON KW_COMMIT (KW_DROP | KW_DELETE KW_ROWS | KW_PRESERVE KW_ROWS)
    ;

optTableSpace
    : KW_TABLESPACE tablespace_name
    ;

optConstableSpace
    : KW_USING KW_INDEX optTableSpace
    ;

existingIndex
    : KW_USING KW_INDEX colId
    ;

createStatsStmt
    : KW_CREATE KW_STATISTICS (opt_if_not_exists? any_name)? opt_column_list? KW_ON (
        column_expr (COMMA column_expr)*
        | expr_list
    ) from_clause
    ;

alterStatsStmt
    : KW_ALTER KW_STATISTICS opt_if_exists? any_name KW_SET KW_STATISTICS signedConst
    ;

createAsStmt
    : KW_CREATE optTemp? KW_TABLE opt_if_not_exists? create_as_target KW_AS selectStmt opt_with_data? # queryCreateTable
    ;

create_as_target
    : table_name_create opt_column_list_create? table_access_method_clause? optWith? onCommitOption? optTableSpace?
    ;

opt_with_data
    : KW_WITH (KW_DATA | KW_NO KW_DATA)
    ;

createMaterializedViewStmt
    : KW_CREATE KW_UNLOGGED? KW_MATERIALIZED KW_VIEW opt_if_not_exists? view_name_create opt_column_list_create? table_access_method_clause?
        optRelOptions? optTableSpace? KW_AS selectStmt opt_with_data? # createMaterializedView
    ;

refreshMaterializedViewStmt
    : KW_REFRESH KW_MATERIALIZED KW_VIEW KW_CONCURRENTLY? view_name opt_with_data?
    ;

createSeqStmt
    : KW_CREATE optTemp? KW_SEQUENCE opt_if_not_exists? qualified_name (seqOptElem+)?
    ;

alterSeqStmt
    : KW_ALTER KW_SEQUENCE opt_if_exists? qualified_name seqOptElem+
    ;

seqOptElem
    : KW_AS simpleTypeName
    | KW_CACHE numericOnly?
    | KW_INCREMENT KW_BY? numericOnly
    | (KW_MAXVALUE | KW_MINVALUE) numericOnly
    | KW_NO (KW_MAXVALUE | KW_MINVALUE | KW_CYCLE)
    | KW_OWNED KW_BY column_name
    | KW_SEQUENCE KW_NAME any_name
    | KW_START KW_WITH? numericOnly
    | KW_RESTART KW_WITH? numericOnly?
    ;

numericOnly
    : (PLUS | MINUS)? Numeric
    | signedConst
    ;

createProceduralLangStmt
    : KW_CREATE opt_or_replace? KW_TRUSTED? KW_PROCEDURAL? KW_LANGUAGE colId (
        KW_HANDLER any_name (KW_INLINE any_name)? (KW_VALIDATOR any_name | KW_NO KW_VALIDATOR)?
    )?
    ;

createTableSpaceStmt
    : KW_CREATE optTableSpace (KW_OWNER roleSpec)? KW_LOCATION stringConst optRelOptions?
    ;

createExtensionStmt
    : KW_CREATE KW_EXTENSION opt_if_not_exists? colId KW_WITH? (
        KW_SCHEMA schema_name
        | (KW_VERSION | KW_FROM) nonReservedWordOrStringConst
        | KW_CASCADE
    )*
    ;

alterExtensionStmt
    : KW_ALTER KW_EXTENSION colId KW_UPDATE (KW_TO nonReservedWordOrStringConst)*
    ;

alterExtensionContentsStmt
    : KW_ALTER KW_EXTENSION colId (KW_ADD | KW_DROP) (
        KW_TRANSFORM KW_FOR typename KW_LANGUAGE colId
        | KW_ROUTINE routineWithArgTypes
        | KW_PROCEDURE procedureWithArgTypes
        | KW_OPERATOR (KW_CLASS | KW_FAMILY) any_name table_access_method_clause
        | KW_OPERATOR operatorWithArgTypes
        | KW_FUNCTION functionWithArgTypes
        | (KW_DOMAIN | KW_TYPE) typename
        | KW_CAST OPEN_PAREN typename KW_AS typename CLOSE_PAREN
        | KW_AGGREGATE aggregateWithArgTypes
        | object_type_name
        | object_type_any_name
    )
    ;

createFdwStmt
    : KW_CREATE KW_FOREIGN KW_DATA KW_WRAPPER colId (fdw_option+)? create_generic_options?
    ;

fdw_option
    : (KW_HANDLER | KW_VALIDATOR) any_name?
    | KW_NO (KW_HANDLER | KW_VALIDATOR)
    ;

alterFdwStmt
    : KW_ALTER KW_FOREIGN KW_DATA KW_WRAPPER colId (
        (fdw_option+)? alter_generic_options
        | fdw_option+
    )
    ;

create_generic_options
    : KW_OPTIONS OPEN_PAREN generic_option_elem (COMMA generic_option_elem)* CLOSE_PAREN
    ;

alter_generic_options
    : KW_OPTIONS OPEN_PAREN alter_generic_option_elem (COMMA alter_generic_option_elem)* CLOSE_PAREN
    ;

alter_generic_option_elem
    : (KW_SET | KW_ADD | KW_DROP) generic_option_elem
    ;

generic_option_elem
    : colLabel stringConst
    ;

createForeignServerStmt
    : KW_CREATE KW_SERVER opt_if_not_exists? colId (KW_TYPE stringConst)? foreign_server_version? KW_FOREIGN KW_DATA KW_WRAPPER colId
        create_generic_options?
    ;

foreign_server_version
    : KW_VERSION (stringConst | KW_NULL)
    ;

alterForeignServerStmt
    : KW_ALTER KW_SERVER colId (
        alter_generic_options
        | foreign_server_version alter_generic_options?
    )
    ;

createForeignTableStmt
    : KW_CREATE KW_FOREIGN KW_TABLE opt_if_not_exists? table_name_create OPEN_PAREN tableElementList? CLOSE_PAREN optInherit? KW_SERVER colId
        create_generic_options? # createForeignTable
    | KW_CREATE KW_FOREIGN KW_TABLE opt_if_not_exists? table_name_create KW_PARTITION KW_OF table_name optTypedTableElEmentList? partitionBoundSpec
        KW_SERVER colId create_generic_options? # createPartitionForeignTable
    ;

importForeignSchemaStmt
    : KW_IMPORT KW_FOREIGN KW_SCHEMA schema_name (
        (KW_LIMIT KW_TO | KW_EXCEPT) OPEN_PAREN relation_expr_list CLOSE_PAREN
    )? KW_FROM KW_SERVER colId KW_INTO colId create_generic_options?
    ;

createUserMappingStmt
    : KW_CREATE KW_USER KW_MAPPING opt_if_not_exists? KW_FOR (roleSpec | KW_USER) KW_SERVER colId create_generic_options?
    ;

alterUserMappingStmt
    : KW_ALTER KW_USER KW_MAPPING KW_FOR (roleSpec | KW_USER) KW_SERVER colId alter_generic_options
    ;

createPolicyStmt
    : KW_CREATE KW_POLICY colId KW_ON qualified_name (
        KW_AS (KW_PERMISSIVE | KW_RESTRICTIVE | identifier)
    )? (KW_FOR (KW_ALL | KW_SELECT | KW_INSERT | KW_UPDATE | KW_DELETE))? (KW_TO role_list)? rowSecurityOptionalExpr? rowSecurityOptionalWithCheck?
    ;

alterPolicyStmt
    : KW_ALTER KW_POLICY colId KW_ON qualified_name (KW_TO role_list)? rowSecurityOptionalExpr? rowSecurityOptionalWithCheck?
    ;

alterProcedureStmt
    : KW_ALTER KW_PROCEDURE procedure_name func_args? (
        procedure_action (procedure_action)* KW_RESTRICT?
        | KW_RENAME KW_TO procedure_name_create
        | KW_OWNER KW_TO roleSpec
        | KW_SET KW_SCHEMA schema_name_create
        | KW_NO? KW_DEPENDS KW_ON KW_EXTENSION colId
    )
    ;

procedure_action
    : (KW_EXTERNAL? KW_SECURITY KW_INVOKER | KW_EXTERNAL? KW_SECURITY KW_DEFINER)
    | KW_SET colId (KW_TO | STAR) (colId | KW_DEFAULT)
    | KW_SET colId KW_FROM KW_CURRENT
    | KW_RESET (colId | KW_ALL)
    ;

rowSecurityOptionalExpr
    : KW_USING OPEN_PAREN expression CLOSE_PAREN
    ;

rowSecurityOptionalWithCheck
    : KW_WITH KW_CHECK OPEN_PAREN expression CLOSE_PAREN
    ;

createAccessMethodStmt
    : KW_CREATE KW_ACCESS KW_METHOD colId KW_TYPE (KW_INDEX | KW_TABLE) KW_HANDLER any_name
    ;

createTrigStmt
    : KW_CREATE opt_or_replace? KW_TRIGGER colId triggerActionTime triggerEvents KW_ON table_name (
        KW_REFERENCING ((KW_NEW | KW_OLD) (KW_TABLE | KW_ROW) KW_AS? colId)+
    )? (KW_FOR KW_EACH? (KW_ROW | KW_STATEMENT))? triggerWhen? KW_EXECUTE function_or_procedure OPEN_PAREN triggerFuncArgs CLOSE_PAREN
    | KW_CREATE opt_or_replace? KW_CONSTRAINT? KW_TRIGGER colId triggerActionTime triggerEvents KW_ON table_name (
        KW_FROM qualified_name
    )? constraintAttributeElem* (KW_FOR KW_EACH? (KW_ROW | KW_STATEMENT))? triggerWhen? KW_EXECUTE function_or_procedure OPEN_PAREN triggerFuncArgs
        CLOSE_PAREN
    ;

triggerActionTime
    : KW_BEFORE
    | KW_AFTER
    | KW_INSTEAD KW_OF
    ;

triggerEvents
    : triggerOneEvent (KW_OR triggerOneEvent)*
    ;

triggerOneEvent
    : KW_INSERT
    | KW_DELETE
    | KW_UPDATE (KW_OF column_list)?
    | KW_TRUNCATE
    ;

triggerWhen
    : KW_WHEN OPEN_PAREN expression CLOSE_PAREN
    ;

function_or_procedure
    : KW_FUNCTION function_name
    | KW_PROCEDURE procedure_name
    ;

triggerFuncArgs
    : (triggerFuncArg |) (COMMA triggerFuncArg)*
    ;

triggerFuncArg
    : Integral
    | Numeric
    | stringConst
    | colLabel
    ;

constraintAttributeElem
    : KW_NOT? KW_DEFERRABLE
    | KW_INITIALLY (KW_IMMEDIATE | KW_DEFERRED)
    | KW_NOT KW_VALID
    | KW_NO KW_INHERIT
    ;

createEventTrigStmt
    : KW_CREATE KW_EVENT KW_TRIGGER colId KW_ON colLabel (
        KW_WHEN event_trigger_when_item (KW_AND event_trigger_when_item)*
    )? KW_EXECUTE function_or_procedure OPEN_PAREN CLOSE_PAREN
    ;

event_trigger_when_item
    : colId KW_IN OPEN_PAREN stringConst (notify_payload)* CLOSE_PAREN
    ;

alterEventTrigStmt
    : KW_ALTER KW_EVENT KW_TRIGGER colId (KW_ENABLE (KW_REPLICA | KW_ALWAYS)? | KW_DISABLE)
    ;

createAssertionStmt
    : KW_CREATE KW_ASSERTION any_name KW_CHECK OPEN_PAREN expression CLOSE_PAREN constraintAttributeElem*
    ;

defineStmt
    : KW_CREATE opt_or_replace? KW_AGGREGATE function_name (
        (aggregate_args definition)
        | OPEN_PAREN old_aggregate_elem (COMMA old_aggregate_elem)* CLOSE_PAREN
    )
    | KW_CREATE KW_OPERATOR any_operator definition
    | KW_CREATE KW_TYPE any_name KW_AS (
        OPEN_PAREN tableFuncElementList? CLOSE_PAREN
        | KW_ENUM OPEN_PAREN (stringConst (notify_payload)*)? CLOSE_PAREN
    )
    | KW_CREATE KW_TYPE any_name ((KW_AS KW_RANGE)? definition)?
    | KW_CREATE KW_TEXT KW_SEARCH (KW_PARSER | KW_DICTIONARY | KW_TEMPLATE | KW_CONFIGURATION) any_name definition
    | KW_CREATE KW_COLLATION opt_if_not_exists? any_name (definition | (KW_FROM any_name))
    ;

definition
    : OPEN_PAREN def_elem (COMMA def_elem)* CLOSE_PAREN
    ;

def_elem
    : colLabel (EQUAL def_arg)?
    ;

def_arg
    : func_type
    | reserved_keyword
    | qual_all_op
    | numericOnly
    | stringConst
    | KW_NONE
    ;

old_aggregate_elem
    : identifier EQUAL def_arg
    ;

alterEnumStmt
    : KW_ALTER KW_TYPE any_name KW_ADD KW_VALUE opt_if_not_exists? stringConst (
        (KW_BEFORE | KW_AFTER) stringConst
    )?
    | KW_ALTER KW_TYPE any_name KW_RENAME KW_VALUE stringConst KW_TO stringConst
    ;

opt_if_not_exists
    : KW_IF KW_NOT KW_EXISTS
    ;

createOperatorClassStmt
    : KW_CREATE KW_OPERATOR KW_CLASS any_name KW_DEFAULT? KW_FOR KW_TYPE typename table_access_method_clause (
        KW_FAMILY any_name
    )? KW_AS opClassItem (COMMA opClassItem)*
    ;

opClassItem
    : KW_OPERATOR Integral any_operator operatorArgTypes? (
        KW_FOR (KW_SEARCH | (KW_ORDER KW_BY any_name))
    )? KW_RECHECK?
    | KW_FUNCTION Integral prep_type_clause? functionWithArgTypes
    | KW_STORAGE typename
    ;

createOperatorFamilyStmt
    : KW_CREATE KW_OPERATOR KW_FAMILY any_name table_access_method_clause
    ;

alterOperatorFamilyStmt
    : KW_ALTER KW_OPERATOR KW_FAMILY any_name table_access_method_clause (
        KW_ADD opClassItem (COMMA opClassItem)*
        | KW_DROP opClassDrop (COMMA opClassDrop)*
    )
    ;

opClassDrop
    : (KW_OPERATOR | KW_FUNCTION) Integral prep_type_clause
    ;

reassignOwnedStmt
    : KW_REASSIGN KW_OWNED KW_BY role_list KW_TO roleSpec
    ;

dropStmt
    : KW_DROP (
        KW_SEQUENCE
        | KW_INDEX
        | KW_COLLATION
        | KW_CONVERSION
        | KW_STATISTICS
        | KW_PUBLICATION
        | KW_SERVER
        | KW_ACCESS KW_METHOD
        | KW_EVENT KW_TRIGGER
        | KW_EXTENSION
        | KW_PROCEDURAL? KW_LANGUAGE
        | KW_FOREIGN KW_DATA KW_WRAPPER
        | KW_TEXT KW_SEARCH (KW_PARSER | KW_DICTIONARY | KW_TEMPLATE | KW_CONFIGURATION)
    ) opt_if_exists? name_list opt_drop_behavior?
    | KW_DROP KW_MATERIALIZED? KW_VIEW opt_if_exists? view_name (COMMA view_name)* opt_drop_behavior?
    | KW_DROP KW_FOREIGN? KW_TABLE opt_if_exists? table_name_list opt_drop_behavior?
    | KW_DROP KW_SCHEMA opt_if_exists? schema_name_list opt_drop_behavior?
    | KW_DROP (KW_POLICY | KW_RULE | KW_TRIGGER) opt_if_exists? colId KW_ON any_name opt_drop_behavior?
    | KW_DROP (KW_TYPE | KW_DOMAIN) opt_if_exists? typename (COMMA typename)* opt_drop_behavior?
    | KW_DROP KW_INDEX KW_CONCURRENTLY opt_if_exists? any_name_list opt_drop_behavior?
    | KW_DROP KW_CAST opt_if_exists? OPEN_PAREN typename KW_AS typename CLOSE_PAREN opt_drop_behavior?
    | KW_DROP KW_OPERATOR (KW_CLASS | KW_FAMILY) opt_if_exists? any_name table_access_method_clause opt_drop_behavior?
    | KW_DROP KW_OWNED KW_BY role_list opt_drop_behavior?
    | KW_DROP KW_SUBSCRIPTION opt_if_exists? colId opt_drop_behavior?
    | KW_DROP KW_TABLESPACE opt_if_exists? tablespace_name
    | KW_DROP KW_TRANSFORM opt_if_exists? KW_FOR typename KW_LANGUAGE colId opt_drop_behavior?
    | KW_DROP (KW_ROLE | KW_USER | KW_GROUP) opt_if_exists? role_list
    | KW_DROP KW_USER KW_MAPPING opt_if_exists? KW_FOR (roleSpec | KW_USER) KW_SERVER colId
    | KW_DROP KW_DATABASE opt_if_exists? database_name (
        KW_WITH? (OPEN_PAREN KW_FORCE (COMMA KW_FORCE)* CLOSE_PAREN)
    )?
    ;

object_type_any_name
    : KW_FOREIGN? KW_TABLE table_name
    | KW_MATERIALIZED? KW_VIEW view_name
    | (KW_INDEX | KW_COLLATION | KW_CONVERSION | KW_STATISTICS | KW_SEQUENCE) any_name
    | KW_TEXT KW_SEARCH (KW_PARSER | KW_DICTIONARY | KW_TEMPLATE | KW_CONFIGURATION) any_name
    ;

object_type_name
    : (
        KW_EVENT KW_TRIGGER
        | KW_ACCESS KW_METHOD
        | KW_EXTENSION
        | KW_PUBLICATION
        | KW_SERVER
        | KW_ROLE
        | KW_SUBSCRIPTION
        | KW_FOREIGN KW_DATA KW_WRAPPER
        | KW_PROCEDURAL? KW_LANGUAGE
    ) colId
    | KW_SCHEMA schema_name
    | KW_DATABASE database_name
    | optTableSpace
    ;

any_name_list
    : any_name (COMMA any_name)*
    ;

any_name
    : colId attrs?
    ;

attrs
    : (DOT colLabel)+
    ;

truncateStmt
    : KW_TRUNCATE KW_TABLE? truncate_table (COMMA truncate_table)* (
        (KW_CONTINUE | KW_RESTART) KW_IDENTITY
    )? opt_drop_behavior?
    ;

truncate_table
    : KW_ONLY? table_name STAR?
    ;

commentStmt
    : KW_COMMENT KW_ON (
        object_type_any_name
        | object_type_name
        | KW_COLUMN (colId attrs?) DOT column_name
        | (KW_TYPE | KW_DOMAIN) typename
        | KW_AGGREGATE aggregateWithArgTypes
        | KW_FUNCTION functionWithArgTypes
        | KW_OPERATOR operatorWithArgTypes
        | KW_CONSTRAINT colId KW_ON (table_name | (KW_DOMAIN? any_name))
        | (KW_POLICY | KW_RULE | KW_TRIGGER) colId KW_ON any_name
        | KW_PROCEDURE procedureWithArgTypes
        | KW_ROUTINE routineWithArgTypes
        | KW_TRANSFORM KW_FOR typename KW_LANGUAGE colId
        | KW_OPERATOR (KW_CLASS | KW_FAMILY) any_name table_access_method_clause
        | KW_LARGE KW_OBJECT numericOnly
        | KW_CAST OPEN_PAREN typename KW_AS typename CLOSE_PAREN
    ) KW_IS (stringConst | KW_NULL)
    ;

secLabelStmt
    : KW_SECURITY KW_LABEL (KW_FOR nonReservedWordOrStringConst)? KW_ON (
        (KW_TYPE | KW_DOMAIN) typename
        | KW_AGGREGATE aggregateWithArgTypes
        | KW_COLUMN column_name
        | KW_FUNCTION functionWithArgTypes
        | KW_LARGE KW_OBJECT numericOnly
        | KW_PROCEDURE procedureWithArgTypes
        | KW_ROUTINE routineWithArgTypes
        | object_type_any_name
        | object_type_name
    ) KW_IS (stringConst | KW_NULL)
    ;

fetchStmt
    : (KW_FETCH | KW_MOVE) fetch_args
    ;

fetch_args
    : (KW_NEXT | KW_PRIOR | KW_FIRST | KW_LAST)? from_in? colId
    | (KW_ABSOLUTE | KW_RELATIVE)? signedConst from_in? colId
    | KW_FORWARD signedConst? from_in? colId
    | KW_FORWARD? KW_ALL from_in? colId
    | KW_BACKWARD (KW_ALL? | signedConst) from_in? colId
    ;

from_in
    : KW_FROM
    | KW_IN
    ;

grantStmt
    : KW_GRANT privileges KW_ON privilege_target KW_TO grantee_list (KW_WITH KW_GRANT KW_OPTION)?
    ;

revokeStmt
    : KW_REVOKE (KW_GRANT KW_OPTION KW_FOR)? privileges KW_ON privilege_target KW_FROM grantee_list opt_drop_behavior?
    ;

privileges
    : privilege (COMMA privilege)*
    | KW_ALL KW_PRIVILEGES? (opt_column_list)?
    | beforePrivilegeSelect (COMMA beforePrivilegeSelect)*
    ;

beforePrivilegeSelect
    : KW_SELECT
    | KW_INSERT
    | KW_UPDATE
    | KW_DELETE
    | KW_TRUNCATE
    | KW_PEFERENCES
    | KW_TRIGGER
    | KW_USAGE
    | KW_CREATE
    | KW_CONNECT
    | KW_TEMPORARY
    | KW_TEMP
    | KW_EXECUTE
    ;

privilege
    : (KW_SELECT | KW_REFERENCES | KW_CREATE | colId) opt_column_list?
    ;

privilege_target
    : KW_TABLE table_name_list
    | KW_SEQUENCE? qualified_name_list
    | (KW_FOREIGN (KW_DATA KW_WRAPPER | KW_SERVER) | KW_LANGUAGE) name_list
    | KW_FUNCTION functionWithArgTypesList
    | KW_PROCEDURE procedureWithArgTypesList
    | KW_ROUTINE routineWithArgTypesList
    | KW_DATABASE database_nameList
    | (KW_DOMAIN | KW_TYPE) any_name_list
    | KW_LARGE KW_OBJECT numericOnly (COMMA numericOnly)*
    | KW_SCHEMA schema_name_list
    | KW_TABLESPACE tablespace_name_list
    | KW_ALL (KW_TABLES | KW_SEQUENCES | KW_FUNCTIONS | KW_PROCEDURES | KW_ROUTINES) KW_IN KW_SCHEMA schema_name_list
    ;

grantee_list
    : (KW_GROUP? roleSpec) (COMMA (KW_GROUP? roleSpec))*
    ;

grantRoleStmt
    : KW_GRANT privilege (COMMA privilege)* KW_TO role_list (KW_WITH KW_ADMIN KW_OPTION)? (
        KW_GRANTED KW_BY roleSpec
    )?
    ;

revokeRoleStmt
    : KW_REVOKE (KW_ADMIN KW_OPTION KW_FOR)? privilege (COMMA privilege)* KW_FROM role_list (
        KW_GRANTED KW_BY roleSpec
    )? opt_drop_behavior?
    ;

alterDefaultPrivilegesStmt
    : KW_ALTER KW_DEFAULT KW_PRIVILEGES (
        KW_IN KW_SCHEMA schema_name_list
        | KW_FOR (KW_ROLE | KW_USER) role_list
    )* defaclaction
    ;

defaclaction
    : KW_GRANT privileges KW_ON defacl_privilege_target KW_TO grantee_list (
        KW_WITH KW_GRANT KW_OPTION
    )?
    | KW_REVOKE (KW_GRANT KW_OPTION KW_FOR)? privileges KW_ON defacl_privilege_target KW_FROM grantee_list opt_drop_behavior?
    ;

defacl_privilege_target
    : KW_TABLES
    | KW_FUNCTIONS
    | KW_ROUTINES
    | KW_SEQUENCES
    | KW_TYPES
    | KW_SCHEMAS
    ;

//create index

indexStmt
    : KW_CREATE KW_UNIQUE? KW_INDEX KW_CONCURRENTLY? opt_if_not_exists? colId? KW_ON relation_expr table_access_method_clause? index_params (
        KW_INCLUDE index_params
    )? (KW_NULLS KW_NOT? KW_DISTINCT)? optRelOptions? optTableSpace? where_clause?
    ;

index_params
    : OPEN_PAREN index_elem (COMMA index_elem)* CLOSE_PAREN
    ;

index_elem
    : (column_name | func_expr_windowless | OPEN_PAREN expression CLOSE_PAREN) opt_collate_clause? (
        any_name?
        | any_name relOptions
    ) (KW_ASC | KW_DESC)? (KW_NULLS (KW_FIRST | KW_LAST))?
    ;

createFunctionStmt
    : KW_CREATE opt_or_replace? (
        KW_FUNCTION function_name_create
        | KW_PROCEDURE procedure_name_create
    ) (OPEN_PAREN (func_arg_with_default (COMMA func_arg_with_default)*)? CLOSE_PAREN) (
        KW_RETURNS (
            func_type
            | KW_TABLE (OPEN_PAREN table_func_column (COMMA table_func_column)* CLOSE_PAREN)
        )
    )? create_func_opt_item+ (KW_WITH OPEN_PAREN name_list CLOSE_PAREN)?
    ;

opt_or_replace
    : KW_OR KW_REPLACE
    ;

func_args
    : OPEN_PAREN func_args_list? CLOSE_PAREN
    ;

func_args_list
    : func_arg (COMMA func_arg)*
    ;

routineWithArgTypesList
    : routineWithArgTypes (COMMA routineWithArgTypes)*
    ;

routineWithArgTypes
    : routine_name func_args
    | type_func_name_keyword
    | qualified_name
    ;

procedureWithArgTypesList
    : procedureWithArgTypes (COMMA procedureWithArgTypes)*
    ;

procedureWithArgTypes
    : procedure_name func_args
    | type_func_name_keyword
    | qualified_name
    ;

functionWithArgTypesList
    : functionWithArgTypes (COMMA functionWithArgTypes)*
    ;

functionWithArgTypes
    : function_name func_args
    | type_func_name_keyword
    | qualified_name
    ;

func_arg
    : (arg_class type_function_name? | type_function_name arg_class?)? func_type
    ;

arg_class
    : KW_IN KW_OUT?
    | KW_OUT
    | KW_INOUT
    | KW_VARIADIC
    ;

func_type
    : typename
    | KW_SETOF? type_function_name attrs PERCENT KW_TYPE
    ;

func_arg_with_default
    : func_arg ((KW_DEFAULT | EQUAL) expression)?
    ;

aggregate_args
    : OPEN_PAREN (STAR | func_args_list? (KW_ORDER KW_BY func_args_list)?) CLOSE_PAREN
    ;

aggregateWithArgTypes
    : function_name aggregate_args
    ;

common_func_opt_item
    : (KW_RETURNS KW_NULL | KW_CALLED) KW_ON KW_NULL KW_INPUT
    | KW_STRICT
    | KW_IMMUTABLE
    | KW_STABLE
    | KW_VOLATILE
    | KW_EXTERNAL? KW_SECURITY (KW_DEFINER | KW_INVOKER)
    | KW_LEAKPROOF
    | KW_NOT KW_LEAKPROOF
    | (KW_COST | KW_ROWS) numericOnly
    | KW_SUPPORT any_name
    | KW_SET set_rest_more
    | variableResetStmt
    | KW_PARALLEL colId
    ;

create_func_opt_item
    : KW_AS stringConst notify_payload
    | KW_LANGUAGE nonReservedWordOrStringConst
    | KW_TRANSFORM KW_FOR KW_TYPE typename (COMMA KW_FOR KW_TYPE typename)*
    | KW_WINDOW
    | KW_SET colId (KW_TO colId | EQUAL colId | KW_FROM KW_CURRENT)
    | KW_AS colId
    | stmt
    | common_func_opt_item
    | colId
    ;

//https://www.postgresql.org/docs/9.1/sql-createfunction.html

//    | KW_AS 'definition'

//    | KW_AS 'obj_file', 'link_symbol'

opt_definition
    : KW_WITH definition
    ;

table_func_column
    : column_name func_type
    ;

alterFunctionStmt
    : KW_ALTER (
        KW_FUNCTION functionWithArgTypes
        | KW_PROCEDURE procedureWithArgTypes
        | KW_ROUTINE routineWithArgTypes
    ) common_func_opt_item+ KW_RESTRICT?
    ;

removeFuncStmt
    : KW_DROP (
        KW_FUNCTION opt_if_exists? functionWithArgTypesList
        | KW_PROCEDURE opt_if_exists? procedureWithArgTypesList
        | KW_ROUTINE opt_if_exists? routineWithArgTypesList
    ) opt_drop_behavior?
    ;

removeAggregateStmt
    : KW_DROP KW_AGGREGATE opt_if_exists? (aggregateWithArgTypes (COMMA aggregateWithArgTypes)*) opt_drop_behavior?
    ;

removeOperatorStmt
    : KW_DROP KW_OPERATOR opt_if_exists? (operatorWithArgTypes (COMMA operatorWithArgTypes)*) opt_drop_behavior?
    ;

operatorArgTypes
    : OPEN_PAREN (typename (COMMA typename)? | KW_NONE COMMA typename | typename COMMA KW_NONE) CLOSE_PAREN
    ;

any_operator
    : (colId DOT)* all_op
    ;

operatorWithArgTypes
    : any_operator operatorArgTypes
    ;

doStmt
    : KW_DO (stringConst | KW_LANGUAGE nonReservedWordOrStringConst)+
    ;

createCastStmt
    : KW_CREATE KW_CAST OPEN_PAREN typename KW_AS typename CLOSE_PAREN (
        (KW_WITHOUT KW_FUNCTION (KW_AS (KW_ASSIGNMENT | KW_IMPLICIT))?)
        | (
            KW_WITH (KW_FUNCTION functionWithArgTypes | KW_INOUT) (
                KW_AS (KW_ASSIGNMENT | KW_IMPLICIT)
            )?
        )
    )
    ;

opt_if_exists
    : KW_IF KW_EXISTS
    ;

createTransformStmt
    : KW_CREATE opt_or_replace? KW_TRANSFORM KW_FOR typename KW_LANGUAGE colId OPEN_PAREN (
        KW_FROM sql_with_function (COMMA KW_TO sql_with_function)?
        | KW_TO sql_with_function (COMMA KW_FROM sql_with_function)?
    ) CLOSE_PAREN
    ;

sql_with_function
    : KW_SQL KW_WITH KW_FUNCTION functionWithArgTypes
    ;

reindexStmt
    : KW_REINDEX (OPEN_PAREN KW_VERBOSE (COMMA KW_VERBOSE)* CLOSE_PAREN)? (
        (
            KW_INDEX KW_CONCURRENTLY? qualified_name
            | KW_TABLE KW_CONCURRENTLY? table_name
            | KW_SCHEMA KW_CONCURRENTLY? schema_name
            | KW_SYSTEM KW_CONCURRENTLY? colId
            | KW_DATABASE KW_CONCURRENTLY? database_name
        )
    )
    ;

alterTblSpcStmt
    : KW_ALTER optTableSpace (KW_SET | KW_RESET) relOptions
    ;

renameStmt
    : KW_ALTER (KW_AGGREGATE aggregateWithArgTypes | KW_ROUTINE routineWithArgTypes) KW_RENAME KW_TO colId
    | KW_ALTER KW_DATABASE database_name KW_RENAME KW_TO database_name_create
    | KW_ALTER (KW_DOMAIN | KW_STATISTICS | KW_TYPE | KW_CONVERSION | KW_COLLATION) any_name KW_RENAME KW_TO colId
    | KW_ALTER KW_FUNCTION functionWithArgTypes KW_RENAME KW_TO function_name_create
    | KW_ALTER KW_OPERATOR (KW_CLASS | KW_FAMILY) any_name table_access_method_clause KW_RENAME KW_TO colId
    | KW_ALTER KW_PROCEDURE procedureWithArgTypes KW_RENAME KW_TO procedure_name_create
    | KW_ALTER KW_SCHEMA schema_name KW_RENAME KW_TO schema_name_create
    | KW_ALTER (KW_SEQUENCE | KW_INDEX) opt_if_exists? qualified_name KW_RENAME KW_TO colId
    | KW_ALTER KW_MATERIALIZED? KW_VIEW opt_if_exists? view_name KW_RENAME KW_TO view_name_create
    | KW_ALTER KW_FOREIGN? KW_TABLE opt_if_exists? relation_expr KW_RENAME KW_TO table_name_create
    | KW_ALTER (
        KW_FOREIGN? KW_TABLE opt_if_exists? relation_expr KW_RENAME KW_COLUMN?
        | KW_MATERIALIZED? KW_VIEW opt_if_exists? view_name KW_RENAME KW_COLUMN?
    ) column_name KW_TO column_name_create
    | KW_ALTER (KW_TABLE opt_if_exists? relation_expr | KW_DOMAIN any_name) KW_RENAME KW_CONSTRAINT colId KW_TO colId
    | KW_ALTER ((KW_POLICY opt_if_exists?) | KW_RULE | KW_TRIGGER) colId KW_ON qualified_name KW_RENAME KW_TO colId
    | KW_ALTER (
        KW_FOREIGN KW_DATA KW_WRAPPER
        | KW_PROCEDURAL? KW_LANGUAGE
        | KW_PUBLICATION
        | KW_SERVER
        | KW_SUBSCRIPTION
        | KW_EVENT KW_TRIGGER
    ) colId KW_RENAME KW_TO colId
    | KW_ALTER (KW_USER | KW_ROLE | KW_GROUP) roleSpec KW_RENAME KW_TO roleSpec
    | KW_ALTER optTableSpace KW_RENAME KW_TO tablespace_name_create
    | KW_ALTER KW_TEXT KW_SEARCH (KW_PARSER | KW_DICTIONARY | KW_TEMPLATE | KW_CONFIGURATION) any_name KW_RENAME KW_TO colId
    | KW_ALTER KW_TYPE any_name KW_RENAME KW_ATTRIBUTE colId KW_TO colId opt_drop_behavior?
    ;

alterObjectDependsStmt
    : KW_ALTER (
        KW_FUNCTION functionWithArgTypes
        | KW_PROCEDURE procedureWithArgTypes
        | KW_ROUTINE routineWithArgTypes
        | KW_TRIGGER colId KW_ON qualified_name
        | KW_MATERIALIZED KW_VIEW view_name
        | KW_INDEX qualified_name
    ) KW_NO? KW_DEPENDS KW_ON KW_EXTENSION colId
    ;

alterObjectSchemaStmt
    : KW_ALTER (
        KW_AGGREGATE aggregateWithArgTypes
        | KW_EXTENSION colId
        | KW_FUNCTION functionWithArgTypes
        | KW_OPERATOR operatorWithArgTypes
        | KW_OPERATOR (KW_CLASS | KW_FAMILY) any_name table_access_method_clause
        | KW_PROCEDURE procedureWithArgTypes
        | KW_ROUTINE routineWithArgTypes
        | KW_SEQUENCE opt_if_exists? qualified_name
        | KW_MATERIALIZED? KW_VIEW opt_if_exists? view_name
        | KW_FOREIGN? KW_TABLE opt_if_exists? relation_expr
    ) KW_SET KW_SCHEMA schema_name
    | KW_ALTER (
        KW_TEXT KW_SEARCH (KW_PARSER | KW_DICTIONARY | KW_TEMPLATE | KW_CONFIGURATION)
        | KW_COLLATION
        | KW_CONVERSION
        | KW_DOMAIN
        | KW_STATISTICS
        | KW_TYPE
    ) any_name KW_SET KW_SCHEMA schema_name
    ;

alterOperatorStmt
    : KW_ALTER KW_OPERATOR operatorWithArgTypes KW_SET operator_def_list
    ;

operator_def_list
    : OPEN_PAREN operator_def_elem (COMMA operator_def_elem)* CLOSE_PAREN
    ;

operator_def_elem
    : colLabel EQUAL (
        KW_NONE
        | func_type
        | reserved_keyword
        | qual_all_op
        | numericOnly
        | stringConst
    )
    ;

alterTypeStmt
    : KW_ALTER KW_TYPE any_name KW_SET operator_def_list
    ;

alterOwnerStmt
    : KW_ALTER KW_OPERATOR (KW_CLASS | KW_FAMILY) any_name table_access_method_clause KW_OWNER KW_TO roleSpec
    | KW_ALTER (
        KW_AGGREGATE aggregateWithArgTypes
        | KW_DATABASE database_name
        | KW_FUNCTION functionWithArgTypes
        | KW_PROCEDURAL? KW_LANGUAGE colId
        | KW_LARGE KW_OBJECT numericOnly
        | KW_LARGE KW_OBJECT numericOnly
        | KW_OPERATOR operatorWithArgTypes
        | KW_PROCEDURE procedureWithArgTypes
        | KW_ROUTINE routineWithArgTypes
        | KW_SCHEMA schema_name
        | optTableSpace
    ) KW_OWNER KW_TO roleSpec
    | KW_ALTER (
        KW_TEXT KW_SEARCH (KW_DICTIONARY | KW_CONFIGURATION)
        | KW_COLLATION
        | KW_CONVERSION
        | KW_DOMAIN
        | KW_TYPE
        | KW_STATISTICS
    ) any_name KW_OWNER KW_TO roleSpec
    | KW_ALTER (
        KW_SERVER
        | (KW_FOREIGN KW_DATA KW_WRAPPER)
        | (KW_EVENT KW_TRIGGER)
        | KW_PUBLICATION
        | KW_SUBSCRIPTION
    ) colId KW_OWNER KW_TO roleSpec
    ;

createPublicationStmt
    : KW_CREATE KW_PUBLICATION colId (KW_FOR KW_TABLE relation_expr_list | KW_FOR KW_ALL KW_TABLES)? opt_definition?
    ;

alterPublicationStmt
    : KW_ALTER KW_PUBLICATION colId (
        (KW_OWNER KW_TO roleSpec)
        | (KW_SET definition)
        | (KW_RENAME KW_TO colId)
        | (KW_ADD | KW_SET | KW_DROP) publication_relation_expr (COMMA publication_relation_expr)*
    )
    ;

createSubscriptionStmt
    : KW_CREATE KW_SUBSCRIPTION colId KW_CONNECTION stringConst KW_PUBLICATION (
        colLabel (COMMA colLabel)*
    ) opt_definition?
    ;

alterSubscriptionStmt
    : KW_ALTER KW_SUBSCRIPTION colId KW_SET definition
    | KW_ALTER KW_SUBSCRIPTION colId KW_CONNECTION stringConst
    | KW_ALTER KW_SUBSCRIPTION colId KW_REFRESH KW_PUBLICATION opt_definition?
    | KW_ALTER KW_SUBSCRIPTION colId (KW_SET | KW_ADD | KW_DROP) KW_PUBLICATION (
        colLabel (COMMA colLabel)*
    ) opt_definition?
    | KW_ALTER KW_SUBSCRIPTION colId (KW_ENABLE | KW_DISABLE)
    | KW_ALTER KW_SUBSCRIPTION colId KW_SKIP OPEN_PAREN old_aggregate_elem CLOSE_PAREN
    | KW_ALTER KW_SUBSCRIPTION colId KW_OWNER KW_TO roleSpec
    ;

ruleStmt
    : KW_CREATE opt_or_replace? KW_RULE colId KW_AS KW_ON (
        KW_SELECT
        | KW_UPDATE
        | KW_DELETE
        | KW_INSERT
    ) KW_TO qualified_name where_clause? KW_DO (KW_INSTEAD | KW_ALSO)? (
        KW_NOTHING
        | ruleActionStmt
        | OPEN_PAREN (ruleActionStmt? (SEMI ruleActionStmt?)*) CLOSE_PAREN
    )
    ;

ruleActionStmt
    : selectStmt
    | insertStmt
    | updateStmt
    | deleteStmt
    | notifyStmt
    ;

notifyStmt
    : KW_NOTIFY colId notify_payload?
    ;

notify_payload
    : COMMA stringConst
    ;

listenStmt
    : KW_LISTEN colId
    ;

unListenStmt
    : KW_UNLISTEN (colId | STAR)
    ;

transactionStmt
    : KW_BEGIN opt_transaction? transaction_mode_list?
    | KW_START KW_TRANSACTION transaction_mode_list?
    | KW_SAVEPOINT colId
    | KW_RELEASE KW_SAVEPOINT? colId
    | KW_PREPARE KW_TRANSACTION stringConst
    | (KW_COMMIT | KW_ROLLBACK) KW_PREPARED stringConst
    | (KW_ABORT | KW_END | KW_COMMIT | KW_ROLLBACK) opt_transaction? (KW_AND KW_NO? KW_CHAIN)?
    | KW_ROLLBACK opt_transaction? KW_TO KW_SAVEPOINT? colId
    ;

opt_transaction
    : KW_WORK
    | KW_TRANSACTION
    ;

transaction_mode_item
    : KW_ISOLATION KW_LEVEL iso_level
    | KW_READ (KW_ONLY | KW_WRITE)
    | KW_NOT? KW_DEFERRABLE
    ;

transaction_mode_list
    : transaction_mode_item (COMMA? transaction_mode_item)*
    ;

viewStmt
    : KW_CREATE (KW_OR KW_REPLACE)? optTemp? (
        KW_VIEW view_name_create opt_column_list_create? optRelOptions?
        | KW_RECURSIVE KW_VIEW view_name_create opt_column_list optRelOptions?
    ) KW_AS selectStmt (KW_WITH (KW_CASCADED | KW_LOCAL)? KW_CHECK KW_OPTION)? # createView
    ;

loadStmt
    : KW_LOAD stringConst
    ;

createDbStmt
    : KW_CREATE KW_DATABASE database_name_create KW_WITH? (create_db_opt_item+)? # createDatabase
    ;

create_db_opt_item
    : (
        KW_CONNECTION KW_LIMIT
        | KW_ENCODING
        | KW_LOCATION
        | KW_OWNER
        | KW_TABLESPACE
        | KW_TEMPLATE
        | identifier
    ) EQUAL? (signedConst | opt_boolean_or_string | KW_DEFAULT)
    ;

alterDatabaseStmt
    : KW_ALTER KW_DATABASE database_name (
        (KW_SET KW_TABLESPACE tablespace_name_create)?
        | (KW_WITH? create_db_opt_item+)?
    )
    ;

alterDatabaseSetStmt
    : KW_ALTER KW_DATABASE database_name setOrResetClause?
    ;

alterCollationStmt
    : KW_ALTER KW_COLLATION any_name KW_REFRESH KW_VERSION
    ;

alterSystemStmt
    : KW_ALTER KW_SYSTEM (KW_SET | KW_RESET) generic_set
    ;

createDomainStmt
    : KW_CREATE KW_DOMAIN any_name KW_AS? typename colConstraint*
    ;

alterDomainStmt
    : KW_ALTER KW_DOMAIN any_name (
        alter_column_default
        | (KW_DROP | KW_SET) KW_NOT KW_NULL
        | KW_ADD (KW_CONSTRAINT colId)? constraintElem
        | KW_DROP KW_CONSTRAINT opt_if_exists? colId opt_drop_behavior?
        | KW_VALIDATE KW_CONSTRAINT colId
    )
    ;

alterSearchDictionaryStmt
    : KW_ALTER KW_TEXT KW_SEARCH KW_DICTIONARY any_name definition
    ;

alterSearchConfigurationStmt
    : KW_ALTER KW_TEXT KW_SEARCH KW_CONFIGURATION any_name (KW_ADD | KW_ALTER) KW_MAPPING KW_FOR name_list KW_WITH any_name_list
    | KW_ALTER KW_TEXT KW_SEARCH KW_CONFIGURATION any_name KW_ALTER KW_MAPPING (KW_FOR name_list)? KW_REPLACE any_name KW_WITH any_name
    | KW_ALTER KW_TEXT KW_SEARCH KW_CONFIGURATION any_name KW_DROP KW_MAPPING opt_if_exists? KW_FOR name_list
    ;

createConversionStmt
    : KW_CREATE KW_DEFAULT? KW_CONVERSION any_name KW_FOR stringConst KW_TO stringConst KW_FROM any_name
    ;

clusterStmt
    : KW_CLUSTER opt_verbose? (table_name table_access_method_clause?)?
    | KW_CLUSTER OPEN_PAREN opt_verbose (COMMA opt_verbose)* CLOSE_PAREN table_name table_access_method_clause?
    ;

vacuumStmt
    : KW_VACUUM ((KW_FULL? KW_FREEZE? opt_verbose? analyze_keyword?) | (explain_option_list)?) vacuum_relation_list?
    ;

analyzeStmt
    : analyze_keyword (
        opt_verbose?
        | OPEN_PAREN analyze_option_elem (COMMA analyze_option_elem)* CLOSE_PAREN
    ) vacuum_relation_list?
    ;

analyze_keyword
    : KW_ANALYZE
    | KW_ANALYSE
    ;

vac_analyze_option_elem
    : (nonReservedWord | analyze_keyword) (opt_boolean_or_string | numericOnly)?
    ;

analyze_option_elem
    : (KW_SKIP_LOCKED | KW_VERBOSE) (KW_FALSE | KW_TRUE)?
    | KW_BUFFER_USAGE_LIMIT (numericOnly | stringConst)
    ; // support on v12+

opt_verbose
    : KW_VERBOSE (KW_FALSE | KW_TRUE)?
    ;

vacuum_relation
    : table_name opt_column_list?
    ;

vacuum_relation_list
    : vacuum_relation (COMMA vacuum_relation)*
    ;

explainStmt
    : KW_EXPLAIN (explain_option_list | KW_VERBOSE? | (analyze_keyword opt_verbose?)?) explainableStmt
    ;

explainableStmt
    : selectStmt
    | insertStmt
    | updateStmt
    | deleteStmt
    | declareCursorStmt
    | createAsStmt
    | createMaterializedViewStmt
    | refreshMaterializedViewStmt
    | executeStmt
    ;

explain_option_list
    : OPEN_PAREN vac_analyze_option_elem (COMMA vac_analyze_option_elem)* CLOSE_PAREN
    ;

prepareStmt
    : KW_PREPARE colId prep_type_clause? KW_AS preParableStmt
    ;

prep_type_clause
    : OPEN_PAREN typename (COMMA typename)* CLOSE_PAREN
    ;

preParableStmt
    : selectStmt
    | insertStmt
    | updateStmt
    | deleteStmt
    ;

executeStmt
    : KW_EXECUTE colId execute_param_clause?
    | KW_CREATE optTemp? KW_TABLE opt_if_not_exists? create_as_target KW_AS KW_EXECUTE colId execute_param_clause? opt_with_data?
    ;

execute_param_clause
    : OPEN_PAREN expr_list CLOSE_PAREN
    ;

dealLocateStmt
    : KW_DEALLOCATE KW_PREPARE? (colId | KW_ALL)
    ;

insertStmt
    : with_clause? KW_INSERT KW_INTO table_name (KW_AS colId)? insert_rest (
        KW_ON KW_CONFLICT (index_params where_clause? | KW_ON KW_CONSTRAINT colId)? KW_DO (
            KW_UPDATE KW_SET set_clause_list where_clause?
            | KW_NOTHING
        )
    )? returning_clause? # insertStatement
    ;

insert_rest
    : (OPEN_PAREN insert_column_list CLOSE_PAREN)? (KW_OVERRIDING (KW_USER | KW_SYSTEM) KW_VALUE)? (
        default_values_or_values
        | selectStmt
    )
    ;

insert_column_list
    : insert_column_item (COMMA insert_column_item)*
    ;

insert_column_item
    : column_name opt_indirection
    ;

returning_clause
    : KW_RETURNING target_list
    ;

deleteStmt
    : with_clause? KW_DELETE KW_FROM relation_expr_opt_alias (KW_USING from_list)? where_or_current_clause? returning_clause?
    ;

lockStmt
    : KW_LOCK KW_TABLE? relation_expr_list (
        KW_IN (
            (KW_ACCESS | KW_ROW) (KW_SHARE | KW_EXCLUSIVE)
            | KW_SHARE (KW_UPDATE KW_EXCLUSIVE | KW_ROW KW_EXCLUSIVE)?
            | KW_EXCLUSIVE
        ) KW_MODE
    )? KW_NOWAIT?
    ;

updateStmt
    : with_clause? KW_UPDATE relation_expr_opt_alias KW_SET set_clause_list from_clause? where_or_current_clause? returning_clause?
    ;

set_clause_list
    : set_clause (COMMA set_clause)*
    ;

set_clause
    : insert_column_item EQUAL expression
    | OPEN_PAREN insert_column_list CLOSE_PAREN EQUAL (
        KW_ROW? expression
        | OPEN_PAREN select_clause CLOSE_PAREN
    )
    ;

declareCursorStmt
    : KW_DECLARE colId (((KW_NO? KW_SCROLL) | KW_BINARY | KW_INSENSITIVE)*) KW_CURSOR (
        (KW_WITH | KW_WITHOUT) KW_HOLD
    )? KW_FOR selectStmt
    ;

/*
 TODO: why select_with_parens alternative is needed at all? i guess it because original byson
 grammar can choose selectStmt(2)->select_with_parens on only OPEN_PARENT/SELECT kewords at the
 begining of statement; (select * from tab); parse can go through selectStmt(
 )->select_no_parens(1)->select_clause(2)->select_with_parens(1)->select_no_parens(1)->select_clause(1)->simple_select
 instead of
 selectStmt(1)->select_no_parens(1)->select_clause(2)->select_with_parens(1)->select_no_parens(1)->select_clause(1)->simple_select
 all standard tests passed on both variants
 */

selectStmt
    : select_no_parens   # selectStatement
    | select_with_parens # selectStatement
    ;

select_with_parens
    : OPEN_PAREN (select_no_parens | select_with_parens) CLOSE_PAREN
    ;

select_no_parens
    : with_clause? select_clause sort_clause? (
        for_locking_clause select_limit?
        | select_limit for_locking_clause?
    )?
    ;

select_clause
    : simple_select
    | select_with_parens
    ;

simple_select
    : (
        KW_SELECT (KW_ALL? into_clause? | distinct_clause?) sql_expression
        | values_clause
        | KW_TABLE relation_expr
        | select_with_parens set_operator_with_all_or_distinct (simple_select | select_with_parens)
    ) (set_operator_with_all_or_distinct ( simple_select | select_with_parens))*
    ;

set_operator_with_all_or_distinct
    : (KW_UNION | KW_INTERSECT | KW_EXCEPT) (KW_ALL | KW_DISTINCT)?
    ;

with_clause
    : KW_WITH KW_RECURSIVE? (common_table_expr (COMMA common_table_expr)*)
    ;

common_table_expr
    : colId opt_column_list? KW_AS (KW_NOT? KW_MATERIALIZED)? OPEN_PAREN preParableStmt CLOSE_PAREN search_clause? cycle_clause?
    ;

search_clause
    : KW_SEARCH (KW_BREADTH | KW_DEPTH) KW_FIRST KW_BY column_list KW_SET column_name
    ;

cycle_clause
    : KW_CYCLE column_list KW_SET column_name (KW_TO colId KW_DEFAULT colId)? KW_USING column_name
    ;

into_clause
    : KW_INTO (KW_STRICT? optTempTableName | expr_list)
    ;

optTempTableName
    : (KW_LOCAL | KW_GLOBAL)? (KW_TEMPORARY | KW_TEMP) KW_TABLE? table_name_create
    | KW_UNLOGGED? KW_TABLE? table_name_create
    ;

distinct_clause
    : KW_DISTINCT (KW_ON execute_param_clause)?
    ;

sort_clause
    : KW_ORDER KW_BY sortBy (COMMA sortBy)*
    ;

sortBy
    : column_expr_no_paren (KW_USING qual_all_op | (KW_ASC | KW_DESC))? (
        KW_NULLS (KW_FIRST | KW_LAST)
    )?
    ;

select_limit
    : // https://www.postgresql.org/docs/16/sql-select.html#SQL-LIMIT
    offset_clause fetch_clause?
    | (limit_clause | fetch_clause) offset_clause?
    ;

limit_clause
    : KW_LIMIT (expression | KW_ALL) (COMMA expression)?
    ;

fetch_clause
    : KW_FETCH (KW_FIRST | KW_NEXT) (
        select_fetch_first_value? (KW_ROW | KW_ROWS) (KW_ONLY | KW_WITH KW_TIES)
    )
    ;

offset_clause
    : KW_OFFSET (select_fetch_first_value (KW_ROW | KW_ROWS) | expression)
    ;

select_fetch_first_value
    : (PLUS | MINUS) (Integral | Numeric)
    | primaryExpression
    ;

group_clause
    : KW_GROUP KW_BY (KW_ALL | KW_DISTINCT)? group_by_list
    ;

group_by_list
    : group_by_item (COMMA group_by_item)*
    ;

group_by_item
    : column_expr_no_paren
    | OPEN_PAREN CLOSE_PAREN
    | (KW_CUBE | KW_ROLLUP)? OPEN_PAREN (column_expr_no_paren (COMMA column_expr_no_paren)*) CLOSE_PAREN
    | KW_GROUPING KW_SETS OPEN_PAREN group_by_list CLOSE_PAREN
    ;

for_locking_clause
    : (
        KW_FOR ((KW_NO KW_KEY)? KW_UPDATE | KW_KEY? KW_SHARE) (KW_OF qualified_name_list)? (
            KW_NOWAIT
            | KW_SKIP KW_LOCKED
        )?
    )+
    | KW_FOR KW_READ KW_ONLY
    ;

values_clause
    : KW_VALUES execute_param_clause (COMMA execute_param_clause)*
    ;

from_clause
    : KW_FROM from_list
    ;

from_list
    : table_ref (COMMA table_ref)*
    ;

table_ref
    : (
        (relation_expr | (KW_ONLY? view_name STAR? column_list? where_clause?)) alias_clause? tableSampleClause?
        | KW_LATERAL? (
            xmlTable alias_clause?
            | func_table func_alias_clause?
            | select_with_parens alias_clause?
        )
        | OPEN_PAREN table_ref (
            KW_CROSS KW_JOIN table_ref
            | KW_NATURAL join_type? KW_JOIN table_ref
            | join_type? KW_JOIN table_ref join_qual
        )? CLOSE_PAREN alias_clause?
    ) (
        KW_CROSS KW_JOIN table_ref
        | KW_NATURAL join_type? KW_JOIN table_ref
        | join_type? KW_JOIN table_ref join_qual
    )*
    ;

alias_clause
    : KW_AS? alias=colId (OPEN_PAREN name_list CLOSE_PAREN)?
    ;

func_alias_clause
    : alias_clause
    | (KW_AS alias=colId? | alias=colId) OPEN_PAREN tableFuncElementList CLOSE_PAREN
    ;

join_type
    : (KW_FULL | KW_LEFT | KW_RIGHT | KW_INNER) KW_OUTER?
    ;

join_qual
    : KW_USING opt_column_list
    | KW_ON expression
    ;

relation_expr
    : truncate_table
    | KW_ONLY ( table_name | OPEN_PAREN table_name CLOSE_PAREN)
    | KW_IN KW_SCHEMA (schema_name | KW_CURRENT_SCHEMA)
    ;

publication_relation_expr
    : KW_TABLE truncate_table (opt_column_list)? where_clause?
    | KW_TABLE KW_ONLY ( table_name | OPEN_PAREN table_name CLOSE_PAREN)
    | KW_TABLES KW_IN KW_SCHEMA (schema_name | KW_CURRENT_SCHEMA)
    ;

relation_expr_list
    : relation_expr (COMMA relation_expr)*
    ;

relation_expr_opt_alias
    : relation_expr (KW_AS? colId)?
    ;

tableSampleClause
    : KW_TABLESAMPLE function_name execute_param_clause (
        KW_REPEATABLE OPEN_PAREN expression CLOSE_PAREN
    )?
    ;

func_table
    : (
        func_expr_windowless
        | (KW_ROWS KW_FROM OPEN_PAREN rowsFromItem (COMMA rowsFromItem)* CLOSE_PAREN)
    ) (KW_WITH KW_ORDINALITY)?
    ;

rowsFromItem
    : func_expr_windowless (KW_AS OPEN_PAREN tableFuncElementList CLOSE_PAREN)?
    ;

where_clause
    : KW_WHERE column_expr_no_paren
    ;

where_or_current_clause
    : KW_WHERE (KW_CURRENT KW_OF colId | expression)
    ;

tableFuncElementList
    : tableFuncElement (COMMA tableFuncElement)*
    ;

tableFuncElement
    : colId typename opt_collate_clause?
    ;

xmlTable
    : KW_XMLTABLE OPEN_PAREN (
        (KW_XMLNAMESPACES OPEN_PAREN xml_namespace_el (COMMA xml_namespace_el)* CLOSE_PAREN COMMA)? primaryExpression xmlExistsArgument KW_COLUMNS
            xmlTableColumnEl (COMMA xmlTableColumnEl)*
    ) CLOSE_PAREN
    ;

xmlTableColumnEl
    : colId (
        typename (((KW_DEFAULT | identifier) expression | KW_NOT? KW_NULL)+)?
        | KW_FOR KW_ORDINALITY
    )
    ;

xml_namespace_el
    : primaryExpression KW_AS colLabel
    | KW_DEFAULT primaryExpression
    ;

typename
    : KW_SETOF? simpleTypeName (
        ((OPEN_BRACKET Integral? CLOSE_BRACKET)*)
        | KW_ARRAY (OPEN_BRACKET Integral CLOSE_BRACKET)?
    )
    | qualified_name PERCENT (KW_ROWTYPE | KW_TYPE)
    ;

simpleTypeName
    : type_function_name attrs? execute_param_clause?
    | constTypeName
    | KW_INTERVAL ( opt_interval? | opt_float)
    ;

constTypeName
    : numeric
    | bit
    | character
    | constDatetime
    ;

numeric
    : KW_INT
    | KW_INTEGER
    | KW_SMALLINT
    | KW_BIGINT
    | KW_REAL
    | KW_FLOAT opt_float?
    | KW_DOUBLE KW_PRECISION
    | (KW_DECIMAL | KW_DEC | KW_NUMERIC) execute_param_clause?
    | KW_BOOLEAN
    ;

opt_float
    : OPEN_PAREN Integral CLOSE_PAREN
    ;

bit
    : KW_BIT KW_VARYING? execute_param_clause?
    ;

character
    : (
        (KW_CHARACTER | KW_CHAR | KW_NCHAR) KW_VARYING?
        | KW_VARCHAR
        | KW_NATIONAL (KW_CHARACTER | KW_CHAR) KW_VARYING?
    ) (opt_float)?
    ;

constDatetime
    : (KW_TIMESTAMP | KW_TIME) (opt_float)? ((KW_WITH | KW_WITHOUT) KW_TIME KW_ZONE)?
    ;

opt_interval
    : KW_MONTH
    | interval_second
    | KW_YEAR (KW_TO KW_MONTH)?
    | KW_DAY (KW_TO (KW_HOUR | KW_MINUTE | interval_second))?
    | KW_HOUR (KW_TO (KW_MINUTE | interval_second))?
    | KW_MINUTE (KW_TO interval_second)?
    ;

interval_second
    : KW_SECOND (opt_float)?
    ;

//precendence accroding to Table 4.2. Operator Precedence (highest to lowest)

//https://www.postgresql.org/docs/12/sql-syntax-lexical.html#SQL-PRECEDENCE

/*
 original version of a_expr, for info a_expr: primaryExpression //:: left PostgreSQL-style typecast | a_expr
 TYPECAST typename -- 1 | a_expr KW_COLLATE any_name -- 2 | a_expr AT TIME ZONE a_expr-- 3 //right
 unary plus, unary minus | (PLUS| MINUS) a_expr -- 4 //left exponentiation | a_expr CARET a_expr --
 5 //left multiplication, division, modulo | a_expr (STAR | SLASH | PERCENT) a_expr -- 6 //left
 addition, subtraction | a_expr (PLUS | MINUS) a_expr -- 7 //left all other native and user-defined
 operators | a_expr qual_op a_expr -- 8 | qual_op a_expr -- 9 //range containment, set membership,
 string matching BETWEEN IN LIKE ILIKE SIMILAR | a_expr NOT? (LIKE|ILIKE|SIMILAR TO|(BETWEEN
 SYMMETRIC?)) a_expr opt_escape? -- 10 //< > = <= >= <> comparison operators | a_expr (LT | GT |
 EQUAL | LESS_EQUALS | GREATER_EQUALS | NOT_EQUALS) a_expr -- 11 //IS ISNULL NOTNULL IS TRUE, IS
 FALSE, IS NULL, IS KW_DISTINCT FROM, etc | a_expr IS NOT? ( NULL_P |TRUE_P |FALSE_P |UNKNOWN |KW_DISTINCT
 KW_FROM a_expr |OF OPEN_PAREN type_name_list CLOSE_PAREN |DOCUMENT_P |unicode_normal_form? NORMALIZED ) --
 12 | a_expr (ISNULL|NOTNULL) -- 13 | row OVERLAPS row -- 14 //NOT right logical negation | NOT
 a_expr -- 15 //AND left logical conjunction | a_expr AND a_expr -- 16 //OR left logical disjunction
 | a_expr OR a_expr -- 17 | a_expr (LESS_LESS|GREATER_GREATER) a_expr -- 18 | a_expr qual_op -- 19 |
 a_expr NOT? IN_P in_expr -- 20 | a_expr subquery_Op sub_type (select_with_parens|OPEN_PAREN a_expr
 CLOSE_PAREN) -- 21 | UNIQUE select_with_parens -- 22 | KW_DEFAULT -- 23 ;
 */

comparisonOperator
    : LT
    | GT
    | EQUAL
    | LESS_EQUALS
    | GREATER_EQUALS
    | NOT_EQUALS
    ;

expression
    : booleanExpression
    ;

booleanExpression
    : valueExpression predicate[$valueExpression.ctx]?                  # predicated
    | KW_NOT booleanExpression                                          # logicalNot
    | left= booleanExpression operator= KW_AND right= booleanExpression # logicalBinary
    | left= booleanExpression operator= KW_OR right= booleanExpression  # logicalBinary
    ;

predicate[antlr.ParserRuleContext value]
    : comparisonOperator right= valueExpression # comparison
    | comparisonOperator subquery_Op sub_type (
        select_with_parens
        | OPEN_PAREN expression CLOSE_PAREN
    )                                                                         # quantifiedComparison
    | KW_NOT? KW_BETWEEN lower= valueExpression KW_AND upper= valueExpression # between
    | KW_NOT? KW_IN OPEN_PAREN expression (COMMA expression)* CLOSE_PAREN     # inList
    | KW_NOT? KW_IN select_with_parens                                        # inSubquery
    | KW_NOT? (KW_LIKE | KW_ILIKE | KW_SIMILAR KW_TO | KW_BETWEEN KW_SYMMETRIC?) pattern= valueExpression (
        KW_ESCAPE escape= valueExpression
    )?                                                         # like
    | KW_IS KW_NOT? KW_NULL                                    # nullPredicate
    | KW_IS KW_NOT? KW_DISTINCT KW_FROM right= valueExpression # distinctFrom
    ;

valueExpression
    : primaryExpression                                                               # valueExpressionDefault
    | valueExpression KW_AT KW_TIME KW_ZONE expression                                # atTimeZone
    | operator= (MINUS | PLUS) valueExpression                                        # arithmeticUnary
    | left= valueExpression operator= (STAR | SLASH | PERCENT) right= valueExpression # arithmeticBinary
    | left= valueExpression operator= (PLUS | MINUS) right= valueExpression           # arithmeticBinary
    | left= valueExpression CARET right= valueExpression                              # concatenation
    ;

primaryExpression
    : (KW_EXISTS | KW_UNIQUE) select_with_parens
    | KW_ARRAY (select_with_parens | array_expr)
    | PARAM opt_indirection
    | KW_GROUPING execute_param_clause
    | Integral
    | Numeric
    | BinaryStringConstant
    | HexadecimalStringConstant
    | function_name (stringConst | OPEN_PAREN func_arg_list sort_clause? CLOSE_PAREN stringConst)
    | constTypeName? stringConst
    | KW_INTERVAL ( stringConst opt_interval? | opt_float stringConst)
    | KW_TRUE
    | KW_FALSE
    | KW_NULL
    | PLSQLVARIABLENAME
    | OPEN_PAREN a_expr_in_parens= expression CLOSE_PAREN opt_indirection
    | KW_CASE expression? when_clause+ (KW_ELSE expression)? KW_END
    | func_expr
    | select_with_parens indirection?
    | explicit_row
    | OPEN_PAREN expression COMMA expr_list CLOSE_PAREN
    | row KW_OVERLAPS row
    | qualified_name
    | primaryExpression TYPECAST typename
    | (PLUS | MINUS) primaryExpression
    | primaryExpression qual_op primaryExpression?
    | primaryExpression mathop primaryExpression
    | qual_op primaryExpression
    | primaryExpression KW_IS KW_NOT? (
        KW_DISTINCT KW_FROM primaryExpression
        | KW_OF prep_type_clause
        | KW_DOCUMENT
    )
    ;

func_application
    : function_name OPEN_PAREN (
        func_arg_list (COMMA KW_VARIADIC func_arg_expr)? sort_clause?
        | KW_VARIADIC func_arg_expr sort_clause?
        | (KW_ALL | KW_DISTINCT) func_arg_list sort_clause?
        | STAR
    )? CLOSE_PAREN
    ;

func_expr
    : func_application (KW_WITHIN KW_GROUP OPEN_PAREN sort_clause CLOSE_PAREN)? (
        KW_FILTER OPEN_PAREN KW_WHERE expression CLOSE_PAREN
    )? (KW_OVER (window_specification | colId))?
    | func_expr_common_subexpr
    ;

func_expr_windowless
    : func_application
    | func_expr_common_subexpr
    ;

func_expr_common_subexpr
    : KW_COLLATION KW_FOR OPEN_PAREN expression CLOSE_PAREN
    | KW_CURRENT_DATE
    | (KW_CURRENT_TIME | KW_CURRENT_TIMESTAMP | KW_LOCALTIME | KW_LOCALTIMESTAMP) (opt_float)?
    | KW_CURRENT_ROLE
    | KW_CURRENT_USER
    | KW_SESSION_USER
    | KW_USER
    | KW_CURRENT_CATALOG
    | KW_CURRENT_SCHEMA
    | (KW_CAST | KW_TREAT) OPEN_PAREN expression KW_AS typename CLOSE_PAREN
    | KW_EXTRACT OPEN_PAREN (extract_arg KW_FROM expression)? CLOSE_PAREN
    | KW_NORMALIZE OPEN_PAREN expression (COMMA unicode_normal_form)? CLOSE_PAREN
    | KW_OVERLAY OPEN_PAREN (
        expression KW_PLACING expression KW_FROM expression (KW_FOR expression)?
    ) CLOSE_PAREN
    | KW_POSITION OPEN_PAREN (primaryExpression KW_IN primaryExpression)? CLOSE_PAREN
    | KW_SUBSTRING OPEN_PAREN substr_list? CLOSE_PAREN
    | KW_TRIM OPEN_PAREN (KW_BOTH | KW_LEADING | KW_TRAILING)? ((expression? KW_FROM)? expr_list) CLOSE_PAREN
    | KW_NULLIF OPEN_PAREN expression COMMA expression CLOSE_PAREN
    | (KW_COALESCE | KW_GREATEST | KW_LEAST | KW_XMLCONCAT) execute_param_clause
    | KW_XMLELEMENT OPEN_PAREN KW_NAME colLabel (
        COMMA ((KW_XMLATTRIBUTES OPEN_PAREN xml_attribute_list CLOSE_PAREN) | expr_list)
    )? CLOSE_PAREN
    | KW_XMLEXISTS OPEN_PAREN primaryExpression xmlExistsArgument CLOSE_PAREN
    | KW_XMLFOREST OPEN_PAREN xml_attribute_list CLOSE_PAREN
    | KW_XMLPARSE OPEN_PAREN document_or_content expression (
        (KW_PRESERVE | KW_STRIP) KW_WHITESPACE
    )? CLOSE_PAREN
    | KW_XMLPI OPEN_PAREN KW_NAME colLabel (COMMA expression)? CLOSE_PAREN
    | KW_XMLROOT OPEN_PAREN KW_XML expression COMMA KW_VERSION (( KW_NO KW_VALUE) | expression) (
        COMMA KW_STANDALONE ((KW_NO? KW_VALUE) | KW_YES)
    )? CLOSE_PAREN
    | KW_XMLSERIALIZE OPEN_PAREN document_or_content expression KW_AS simpleTypeName CLOSE_PAREN
    ;

xml_attribute_list
    : xml_attribute_el (COMMA xml_attribute_el)*
    ;

xml_attribute_el
    : expression (KW_AS colLabel)?
    ;

document_or_content
    : KW_DOCUMENT
    | KW_CONTENT
    ;

xmlExistsArgument
    : KW_PASSING xml_passing_mech? primaryExpression xml_passing_mech?
    ;

xml_passing_mech
    : KW_BY (KW_REF | KW_VALUE)
    ;

window_clause
    : KW_WINDOW window_definition (COMMA window_definition)*
    ;

window_definition
    : colId KW_AS window_specification
    ;

over_clause
    : KW_OVER (window_specification | colId)
    ;

window_specification
    : OPEN_PAREN colId? (KW_PARTITION KW_BY expr_list)? sort_clause? opt_frame_clause? CLOSE_PAREN
    ;

opt_frame_clause
    : (KW_RANGE | KW_ROWS | KW_GROUPS) ((KW_BETWEEN frame_bound KW_AND)? frame_bound) (
        KW_EXCLUDE (KW_CURRENT KW_ROW | KW_GROUP | KW_TIES | KW_NO KW_OTHERS)
    )?
    ;

frame_bound
    : (KW_UNBOUNDED | expression) (KW_PRECEDING | KW_FOLLOWING)
    | KW_CURRENT KW_ROW
    ;

row
    : explicit_row
    | OPEN_PAREN expr_list COMMA expression CLOSE_PAREN
    ;

explicit_row
    : KW_ROW OPEN_PAREN expr_list? CLOSE_PAREN
    ;

sub_type
    : KW_ANY
    | KW_SOME
    | KW_ALL
    ;

all_op
    : Operator
    | mathop
    ;

mathop
    : PLUS
    | MINUS
    | STAR
    | SLASH
    | PERCENT
    | CARET
    | LT
    | GT
    | EQUAL
    | LESS_EQUALS
    | GREATER_EQUALS
    | NOT_EQUALS
    ;

qual_op
    : Operator
    | KW_OPERATOR OPEN_PAREN any_operator CLOSE_PAREN
    ;

qual_all_op
    : all_op
    | KW_OPERATOR OPEN_PAREN any_operator CLOSE_PAREN
    ;

subquery_Op
    : qual_all_op
    | KW_NOT? (KW_LIKE | KW_ILIKE)
    ;

expr_list
    : expression (COMMA expression)*
    ;

column_expr
    : (OPEN_PAREN expression CLOSE_PAREN)
    | column_name
    ;

column_expr_no_paren
    : expression
    | column_name
    ;

func_arg_list
    : func_arg_expr (COMMA func_arg_expr)*
    ;

func_arg_expr
    : column_name
    | expression
    | type_function_name ((COLON_EQUALS | EQUALS_GREATER) expression)?
    ;

array_expr
    : OPEN_BRACKET (expr_list | (array_expr (COMMA array_expr)*))? CLOSE_BRACKET
    ;

extract_arg
    : identifier
    | KW_YEAR
    | KW_MONTH
    | KW_DAY
    | KW_HOUR
    | KW_MINUTE
    | KW_SECOND
    | stringConst
    ;

unicode_normal_form
    : KW_NFC
    | KW_NFD
    | KW_NFKC
    | KW_NFKD
    ;

substr_list
    : expression KW_FROM expression (KW_FOR expression)?
    | expression KW_FOR expression (KW_FROM expression)?
    | expression KW_SIMILAR expression KW_ESCAPE expression
    | expr_list
    ;

when_clause
    : KW_WHEN expression KW_THEN expression
    ;

indirection_el
    : DOT (colLabel | STAR)
    | OPEN_BRACKET (expression | expression? COLON expression?) CLOSE_BRACKET
    ;

indirection
    : indirection_el+
    ;

opt_indirection
    : indirection_el*
    ;

target_list
    : target_el (COMMA target_el)*
    ;

target_el
    : column_expr_no_paren (KW_AS colLabel | identifier |) # target_label
    | STAR                                                 # target_star
    ;

qualified_name_list
    : qualified_name (COMMA qualified_name)*
    ;

table_name_list
    : table_name (COMMA table_name)*
    ;

schema_name_list
    : schema_name (COMMA schema_name)*
    ;

database_nameList
    : database_name (COMMA database_name)*
    ;

tablespace_name_create
    : qualified_name # tablespaceNameCreate
    ;

tablespace_name
    : qualified_name # tablespaceName
    ;

table_name_create
    : qualified_name # tableNameCreate
    ;

table_name
    : qualified_name # tableName
    ;

view_name_create
    : qualified_name # viewNameCreate
    ;

view_name
    : any_name # viewName
    ;

qualified_name
    : colId indirection?
    ;

tablespace_name_list
    : tablespace_name (COMMA tablespace_name)*
    ;

name_list
    : colId (COMMA colId)*
    ;

database_name_create
    : any_name # databaseNameCreate
    ;

database_name
    : any_name # databaseName
    ;

schema_name
    : any_name # schemaName
    ;

routine_name_create
    : colId # routineNameCreate
    ;

routine_name
    : colId # routineName
    ;

procedure_name
    : type_function_name # procedureName
    | colId indirection  # procedureName
    ;

procedure_name_create
    : type_function_name # procedureNameCreate
    | colId indirection  # procedureNameCreate
    ;

column_name
    : colId opt_indirection      # columnName
    | {this.shouldMatchEmpty()}? # columnNameMatch
    ;

column_name_create
    : colId # columnNameCreate
    ;

function_name_create
    : type_function_name # functionNameCreate
    | colId indirection  # functionNameCreate
    ;

function_name
    : type_function_name # functionName
    | colId indirection  # functionName
    ;

stringConst
    : anysconst (KW_UESCAPE anysconst)?
    ;

anysconst
    : StringConstant
    | UnicodeEscapeStringConstant
    | BeginDollarStringConstant DollarText* EndDollarStringConstant
    | EscapeStringConstant
    ;

signedConst
    : (PLUS | MINUS)? Integral
    ;

roleSpec
    : nonReservedWord
    | KW_CURRENT_USER
    | KW_CURRENT_ROLE
    | KW_SESSION_USER
    | KW_PUBLIC
    ;

role_list
    : roleSpec (COMMA roleSpec)*
    ;

colId
    : identifier
    | col_name_keyword
    ;

type_function_name
    : identifier
    | type_func_name_keyword
    ;

nonReservedWord
    : identifier
    | col_name_keyword
    | type_func_name_keyword
    ;

colLabel
    : identifier
    | col_name_keyword
    | type_func_name_keyword
    | reserved_keyword
    ;

identifier
    : Identifier (KW_UESCAPE anysconst)?
    | stringConst
    | QuotedIdentifier
    | UnicodeQuotedIdentifier
    | PLSQLVARIABLENAME
    | PLSQLIDENTIFIER
    | unreserved_keyword
    ;

unreserved_keyword
    : KW_ABORT
    | KW_ABSOLUTE
    | KW_ACCESS
    | KW_ACTION
    | KW_ADD
    | KW_ADMIN
    | KW_AFTER
    | KW_AGGREGATE
    | KW_ALSO
    | KW_ALTER
    | KW_ALWAYS
    | KW_ASSERTION
    | KW_ASSIGNMENT
    | KW_AT
    | KW_ATTACH
    | KW_ATTRIBUTE
    | KW_BACKWARD
    | KW_BEFORE
    | KW_BEGIN
    | KW_BUFFER_USAGE_LIMIT
    | KW_BY
    | KW_CACHE
    | KW_CALL
    | KW_CALLED
    | KW_CASCADE
    | KW_CASCADED
    | KW_CATALOG
    | KW_CHAIN
    | KW_CHARACTERISTICS
    | KW_CHECKPOINT
    | KW_CLASS
    | KW_CLOSE
    | KW_CLUSTER
    | KW_COLUMNS
    | KW_COMMENT
    | KW_COMMENTS
    | KW_COMMIT
    | KW_COMMITTED
    | KW_CONFIGURATION
    | KW_CONFLICT
    | KW_CONNECTION
    | KW_CONSTRAINTS
    | KW_CONTENT
    | KW_CONTINUE
    | KW_CONVERSION
    | KW_COPY
    | KW_COST
    | KW_CSV
    | KW_CUBE
    | KW_CURRENT
    | KW_CURSOR
    | KW_CYCLE
    | KW_DATA
    | KW_DATABASE
    | KW_DAY
    | KW_DEALLOCATE
    | KW_DECLARE
    | KW_DEFAULTS
    | KW_DEFERRED
    | KW_DEFINER
    | KW_DELETE
    | KW_DELIMITER
    | KW_DELIMITERS
    | KW_DEPENDS
    | KW_DETACH
    | KW_DICTIONARY
    | KW_DISABLE
    | KW_DISCARD
    | KW_DOCUMENT
    | KW_DOMAIN
    | KW_DOUBLE
    | KW_DROP
    | KW_EACH
    | KW_ENABLE
    | KW_ENCODING
    | KW_ENCRYPTED
    | KW_ENUM
    | KW_ESCAPE
    | KW_EVENT
    | KW_EXCLUDE
    | KW_EXCLUDING
    | KW_EXCLUSIVE
    | KW_EXECUTE
    | KW_EXPLAIN
    | KW_EXPRESSION
    | KW_EXTENSION
    | KW_EXTERNAL
    | KW_FAMILY
    | KW_FILTER
    | KW_FIRST
    | KW_FOLLOWING
    | KW_FORCE
    | KW_FORWARD
    | KW_FUNCTION
    | KW_FUNCTIONS
    | KW_GENERATED
    | KW_GLOBAL
    | KW_GRANTED
    | KW_GROUPS
    | KW_HANDLER
    | KW_HEADER
    | KW_HOLD
    | KW_HOUR
    | KW_IDENTITY
    | KW_IF
    | KW_IMMEDIATE
    | KW_IMMUTABLE
    | KW_IMPLICIT
    | KW_IMPORT
    | KW_INCLUDE
    | KW_INCLUDING
    | KW_INCREMENT
    | KW_INDEX
    | KW_INDEXES
    | KW_INHERIT
    | KW_INHERITS
    | KW_INLINE
    | KW_INPUT
    | KW_INSENSITIVE
    | KW_INSERT
    | KW_INSTEAD
    | KW_INVOKER
    | KW_ISOLATION
    | KW_KEY
    | KW_LABEL
    | KW_LANGUAGE
    | KW_LARGE
    | KW_LAST
    | KW_LEAKPROOF
    | KW_LEVEL
    | KW_LISTEN
    | KW_LOAD
    | KW_LOCAL
    | KW_LOCATION
    | KW_LOCK
    | KW_LOCKED
    | KW_LOGGED
    | KW_MAPPING
    | KW_MATCH
    | KW_MATERIALIZED
    | KW_MAXVALUE
    | KW_METHOD
    | KW_MINUTE
    | KW_MINVALUE
    | KW_MODE
    | KW_MONTH
    | KW_MOVE
    | KW_NAME
    | KW_NAMES
    | KW_NEW
    | KW_NEXT
    | KW_NFC
    | KW_NFD
    | KW_NFKC
    | KW_NFKD
    | KW_NO
    | KW_NORMALIZED
    | KW_NOTHING
    | KW_NOTIFY
    | KW_NOWAIT
    | KW_NULLS
    | KW_OBJECT
    | KW_OF
    | KW_OFF
    | KW_OIDS
    | KW_OLD
    | KW_OPERATOR
    | KW_OPTION
    | KW_OPTIONS
    | KW_ORDINALITY
    | KW_OTHERS
    | KW_OVER
    | KW_OVERRIDING
    | KW_OWNED
    | KW_OWNER
    | KW_PARALLEL
    | KW_PARSER
    | KW_PARTIAL
    | KW_PARTITION
    | KW_PASSING
    | KW_PASSWORD
    | KW_PLANS
    | KW_POLICY
    | KW_PRECEDING
    | KW_PREPARE
    | KW_PREPARED
    | KW_PRESERVE
    | KW_PRIOR
    | KW_PRIVILEGES
    | KW_PROCEDURAL
    | KW_PROCEDURE
    | KW_PROCEDURES
    | KW_PROGRAM
    | KW_PUBLICATION
    | KW_QUOTE
    | KW_RANGE
    | KW_READ
    | KW_REASSIGN
    | KW_RECHECK
    | KW_RECURSIVE
    | KW_REF
    | KW_REFERENCING
    | KW_REFRESH
    | KW_REINDEX
    | KW_RELATIVE
    | KW_RELEASE
    | KW_RENAME
    | KW_REPEATABLE
    | KW_REPLACE
    | KW_REPLICA
    | KW_RESET
    | KW_RESTART
    | KW_RESTRICT
    | KW_RETURNS
    | KW_REVOKE
    | KW_ROLE
    | KW_ROLLBACK
    | KW_ROLLUP
    | KW_ROUTINE
    | KW_ROUTINES
    | KW_ROWS
    | KW_RULE
    | KW_SAVEPOINT
    | KW_SCHEMA
    | KW_SCHEMAS
    | KW_SCROLL
    | KW_SEARCH
    | KW_SECOND
    | KW_SECURITY
    | KW_SEQUENCE
    | KW_SEQUENCES
    | KW_SERIALIZABLE
    | KW_SERVER
    | KW_SESSION
    | KW_SET
    | KW_SETS
    | KW_SHARE
    | KW_SHOW
    | KW_SIMPLE
    | KW_SKIP
    | KW_SKIP_LOCKED
    | KW_SNAPSHOT
    | KW_SQL
    | KW_STABLE
    | KW_STANDALONE
    | KW_START
    | KW_STATEMENT
    | KW_STATISTICS
    | KW_STDIN
    | KW_STDOUT
    | KW_STORAGE
    | KW_STORED
    | KW_STRICT
    | KW_STRIP
    | KW_SUBSCRIPTION
    | KW_SUPPORT
    | KW_SYSID
    | KW_SYSTEM
    | KW_TABLES
    | KW_TABLESPACE
    | KW_TEMP
    | KW_TEMPLATE
    | KW_TEMPORARY
    | KW_TEXT
    | KW_TIES
    | KW_TRANSACTION
    | KW_TRANSFORM
    | KW_TRIGGER
    | KW_TRUNCATE
    | KW_TRUSTED
    | KW_TYPE
    | KW_TYPES
    | KW_UESCAPE
    | KW_UNBOUNDED
    | KW_UNCOMMITTED
    | KW_UNENCRYPTED
    | KW_UNKNOWN
    | KW_UNLISTEN
    | KW_UNLOGGED
    | KW_UNTIL
    | KW_UPDATE
    | KW_VACUUM
    | KW_VALID
    | KW_VALIDATE
    | KW_VALIDATOR
    | KW_VALUE
    | KW_VARYING
    | KW_VERSION
    | KW_VIEW
    | KW_VIEWS
    | KW_VOLATILE
    | KW_WHITESPACE
    | KW_WITHIN
    | KW_WITHOUT
    | KW_WORK
    | KW_WRAPPER
    | KW_WRITE
    | KW_XML
    | KW_YEAR
    | KW_YES
    | KW_ZONE
    | KW_ALIAS
    | KW_ASSERT
    | KW_CONSTANT
    | KW_DEBUG
    | KW_DEFAULT
    | KW_DIAGNOSTICS
    | KW_DUMP
    | KW_ELSIF
    | KW_ERROR
    | KW_EXCEPTION
    | KW_EXIT
    | KW_GET
    | KW_INFO
    | KW_IS
    | KW_LOG
    | KW_NOTICE
    | KW_OPEN
    | KW_PUBLIC
    | KW_PERFORM
    | KW_PRINT_STRICT_PARAMS
    | KW_QUERY
    | KW_RAISE
    | KW_RETURN
    | KW_REVERSE
    | KW_ROWTYPE
    | KW_SLICE
    | KW_SQLSTATE
    | KW_STACKED
    | KW_USE_COLUMN
    | KW_USE_VARIABLE
    | KW_VARIABLE_CONFLICT
    | KW_WARNING
    | KW_OUTER
    ;

col_name_keyword
    : KW_BETWEEN
    | KW_BIGINT
    | bit
    | KW_BOOLEAN
    | KW_CHAR
    | character
    | KW_COALESCE
    | KW_DEC
    | KW_DECIMAL
    | KW_EXISTS
    | KW_EXTRACT
    | KW_FLOAT
    | KW_GREATEST
    | KW_GROUPING
    | KW_INOUT
    | KW_INT
    | KW_INTEGER
    | KW_INTERVAL
    | KW_LEAST
    | KW_NATIONAL
    | KW_NCHAR
    | KW_NONE
    | KW_NORMALIZE
    | KW_NULLIF
    | numeric
    | KW_OUT
    | KW_OVERLAY
    | KW_POSITION
    | KW_PRECISION
    | KW_REAL
    | KW_ROW
    | KW_SETOF
    | KW_SMALLINT
    | KW_SUBSTRING
    | KW_TIME
    | KW_TIMESTAMP
    | KW_TREAT
    | KW_TRIM
    | KW_VALUES
    | KW_VARCHAR
    | KW_XMLATTRIBUTES
    | KW_XMLCONCAT
    | KW_XMLELEMENT
    | KW_XMLEXISTS
    | KW_XMLFOREST
    | KW_XMLNAMESPACES
    | KW_XMLPARSE
    | KW_XMLPI
    | KW_XMLROOT
    | KW_XMLSERIALIZE
    | KW_XMLTABLE
    ;

type_func_name_keyword
    : KW_AUTHORIZATION
    | KW_BINARY
    | KW_COLLATION
    | KW_CONCURRENTLY
    | KW_CROSS
    | KW_CURRENT_SCHEMA
    | KW_FREEZE
    | KW_FULL
    | KW_ILIKE
    | KW_INNER
    | KW_IS
    | KW_ISNULL
    | KW_JOIN
    | KW_LEFT
    | KW_LIKE
    | KW_NATURAL
    | KW_NOTNULL
    | KW_OUTER
    | KW_OVERLAPS
    | KW_RIGHT
    | KW_SIMILAR
    | KW_TABLESAMPLE
    | KW_VERBOSE
    ;

reserved_keyword
    : KW_ALL
    | KW_ANALYSE
    | KW_ANALYZE
    | KW_AND
    | KW_ANY
    | KW_ARRAY
    | KW_AS
    | KW_ASC
    | KW_ASYMMETRIC
    | KW_BOTH
    | KW_CASE
    | KW_CAST
    | KW_CHECK
    | KW_COLLATE
    | KW_COLUMN
    | KW_CONSTRAINT
    | KW_CREATE
    | KW_CURRENT_CATALOG
    | KW_CURRENT_DATE
    | KW_CURRENT_ROLE
    | KW_CURRENT_TIME
    | KW_CURRENT_TIMESTAMP
    | KW_CURRENT_USER
    //                 | KW_DEFAULT
    | KW_DEFERRABLE
    | KW_DESC
    | KW_DISTINCT
    | KW_DO
    | KW_ELSE
    | KW_END
    | KW_EXCEPT
    | KW_FALSE
    | KW_FETCH
    | KW_FOR
    | KW_FOREIGN
    | KW_FROM
    | KW_GRANT
    | KW_GROUP
    | KW_HAVING
    | KW_IN
    | KW_INITIALLY
    | KW_INTERSECT
    /*
	 from pl_gram.y, line ~2982 Fortunately, INTO is a fully reserved word in the main grammar, so
	 at least we need not worry about it appearing as an identifier.
	 */

    //                 | INTO
    | KW_LATERAL
    | KW_LEADING
    | KW_LIMIT
    | KW_LOCALTIME
    | KW_LOCALTIMESTAMP
    | KW_NOT
    | KW_NULL
    | KW_OFFSET
    | KW_ON
    | KW_ONLY
    | KW_OR
    | KW_ORDER
    | KW_PLACING
    | KW_PRIMARY
    | KW_REFERENCES
    | KW_RETURNING
    | KW_SELECT
    | KW_SESSION_USER
    | KW_SOME
    | KW_SYMMETRIC
    | KW_TABLE
    | KW_THEN
    | KW_TO
    | KW_TRAILING
    | KW_TRUE
    | KW_UNION
    | KW_UNIQUE
    | KW_USER
    | KW_USING
    | KW_VARIADIC
    | KW_WHEN
    | KW_WHERE
    | KW_WINDOW
    | KW_WITH
    ;

// exception_sect means opt_exception_sect in original grammar, don't be confused!

pl_block
    : (label_decl? (KW_DECLARE ((decl_statement | KW_DECLARE | label_decl)+)?)?) KW_BEGIN proc_stmt* exception_sect? KW_END any_identifier?
    ;

label_decl
    : LESS_LESS any_identifier GREATER_GREATER
    ;

decl_statement
    : any_identifier (
        KW_ALIAS KW_FOR (PARAM | colId)
        | KW_CONSTANT? typename (opt_collate_clause)? (KW_NOT KW_NULL)? (
            ( assign_operator | KW_DEFAULT) sql_expression
        )?
        | (KW_NO? KW_SCROLL)? KW_CURSOR (
            OPEN_PAREN decl_cursor_arg (COMMA decl_cursor_arg)* CLOSE_PAREN
        )? (KW_IS | KW_FOR) selectStmt
    ) SEMI
    ;

decl_cursor_arg
    : any_identifier typename
    ;

assign_operator
    : EQUAL
    | COLON_EQUALS
    ;

proc_stmt
    : pl_block SEMI
    | stmt_return
    | stmt_raise
    | stmt_assign
    | stmt_if
    | stmt_case
    | stmt_loop_while_for
    | stmt_foreach_a
    | stmt_exit
    | stmt_assert
    | stmt_execsql
    | stmt_dynexecute
    | stmt_perform
    | stmt_call
    | stmt_getdiag
    | stmt_open
    | stmt_fetch
    | stmt_move
    | stmt_close
    | stmt_null
    | stmt_commit_or_rollback
    | stmt_set
    ;

stmt_perform
    : KW_PERFORM sql_expression SEMI
    ;

stmt_call
    : KW_CALL any_identifier (OPEN_PAREN expr_list? CLOSE_PAREN SEMI)?
    | KW_DO any_identifier OPEN_PAREN expr_list? CLOSE_PAREN SEMI
    ;

stmt_assign
    : assign_var assign_operator sql_expression SEMI
    ;

stmt_getdiag
    : KW_GET (KW_CURRENT | KW_STACKED)? KW_DIAGNOSTICS (
        getdiag_list_item (COMMA getdiag_list_item)*
    ) SEMI
    ;

getdiag_list_item
    : assign_var assign_operator colId
    ;

assign_var
    : (any_name | PARAM) (OPEN_BRACKET expression CLOSE_BRACKET)*
    ;

stmt_if
    : KW_IF sql_expression KW_THEN proc_stmt* ((KW_ELSIF expression KW_THEN proc_stmt*)*) stmt_else? KW_END KW_IF SEMI
    ;

stmt_else
    : KW_ELSE proc_stmt*
    ;

stmt_case
    : KW_CASE sql_expression? (KW_WHEN expr_list KW_THEN proc_stmt*)+ stmt_else? KW_END KW_CASE SEMI
    ;

stmt_loop_while_for
    : label_decl? ((KW_WHILE expression) | (KW_FOR for_control))? loop_body
    ;

//TODO: rewrite using read_sql_expression logic?

for_control
    : any_name_list KW_IN (
        colId execute_param_clause?
        | selectStmt
        | explainStmt
        | KW_EXECUTE expression (KW_USING expr_list)?
        | KW_REVERSE? expression DOT_DOT expression (KW_BY expression)?
    )
    ;

stmt_foreach_a
    : label_decl? KW_FOREACH any_name_list (KW_SLICE Integral)? KW_IN KW_ARRAY expression loop_body
    ;

stmt_exit
    : (KW_EXIT | KW_CONTINUE) any_identifier? (KW_WHEN sql_expression)? SEMI
    ;

//todo implement RETURN statement according to initial grammar line 1754

stmt_return
    : KW_RETURN (
        KW_NEXT sql_expression
        | KW_QUERY ( KW_EXECUTE expression KW_USING expr_list | selectStmt)
        | sql_expression?
    ) SEMI
    ;

//https://www.postgresql.org/docs/current/plpgsql-errors-and-messages.html

//RAISE [ level ] 'format' [, expression [, ... ]] [ USING option = expression [, ... ] ];

//RAISE [ level ] condition_name [ USING option = expression [, ... ] ];

//RAISE [ level ] SQLSTATE 'sqlstate' [ USING option = expression [, ... ] ];

//RAISE [ level ] USING option = expression [, ... ];

//RAISE ;

stmt_raise
    : KW_RAISE (
        (KW_DEBUG | KW_LOG | KW_INFO | KW_NOTICE | KW_WARNING | KW_EXCEPTION)? (
            identifier
            | (KW_SQLSTATE stringConst)
            | (stringConst ((COMMA expression)+)?)
        )? (KW_USING (opt_raise_using_elem (COMMA opt_raise_using_elem)*))? SEMI
    )?
    ;

opt_raise_using_elem
    : identifier EQUAL expression
    ;

stmt_assert
    : KW_ASSERT sql_expression (COMMA sql_expression)? SEMI
    ;

loop_body
    : KW_LOOP proc_stmt* KW_END KW_LOOP any_identifier? SEMI
    ;

//TODO: looks like all other statements like INSERT/SELECT/UPDATE/DELETE are handled here;

//pls take a look at original grammar

stmt_execsql
    : stmt opt_execute_into? SEMI
    ;

//https://www.postgresql.org/docs/current/plpgsql-statements.html#PLPGSQL-STATEMENTS-SQL-NORESULT

//EXECUTE command-string [ INTO [STRICT] target ] [ USING expression [, ... ] ];

stmt_dynexecute
    : KW_EXECUTE expression (
        /*this is silly, but i have to time to find nice way to code */ opt_execute_into? (
            KW_USING expr_list
        )?
        | (KW_USING expr_list)? opt_execute_into?
        | //TODO
    ) SEMI
    ;

opt_execute_into
    : KW_INTO KW_STRICT? expr_list
    ;

//https://www.postgresql.org/docs/current/plpgsql-cursors.html#PLPGSQL-CURSOR-OPENING

//OPEN unbound_cursorvar [ [ NO ] SCROLL ] KW_FOR query;

//OPEN unbound_cursorvar [ [ NO ] SCROLL ] KW_FOR EXECUTE query_string

//                                     [ USING expression [, ... ] ];

//OPEN bound_cursorvar [ ( [ argument_name := ] argument_value [, ...] ) ];

stmt_open
    : KW_OPEN (
        cursor_variable (KW_NO? KW_SCROLL)? KW_FOR (
            selectStmt
            | KW_EXECUTE sql_expression (KW_USING expr_list)?
        )
        | colId (
            OPEN_PAREN (opt_open_bound_list_item (COMMA opt_open_bound_list_item)*) CLOSE_PAREN
        )?
    ) SEMI
    ;

opt_open_bound_list_item
    : (colId COLON_EQUALS)? expression
    ;

//https://www.postgresql.org/docs/current/plpgsql-cursors.html#PLPGSQL-CURSOR-OPENING

//FETCH [ direction { KW_FROM | IN } ] cursor INTO target;

stmt_fetch
    : KW_FETCH direction= opt_fetch_direction? from_in? cursor_variable KW_INTO expr_list SEMI
    ;

opt_fetch_direction
    : KW_NEXT
    | KW_PRIOR
    | KW_FIRST
    | KW_LAST
    | (KW_ABSOLUTE | KW_RELATIVE)? expression
    | KW_ALL
    | (KW_FORWARD | KW_BACKWARD) (expression | KW_ALL)?
    ;

//https://www.postgresql.org/docs/current/plpgsql-cursors.html#PLPGSQL-CURSOR-OPENING

//MOVE [ direction { KW_FROM | IN } ] cursor;

stmt_move
    : KW_MOVE opt_fetch_direction? cursor_variable SEMI
    ;

mergeStmt
    : with_clause? KW_MERGE KW_INTO (KW_ONLY)? table_name (STAR)? (KW_AS? colId)? KW_USING data_source KW_ON expression merge_when_clause+
    ;

data_source
    : ((KW_ONLY)? table_name (STAR)? | ( select_no_parens | values_clause)) (KW_AS? colId)?
    ;

merge_when_clause
    : KW_WHEN KW_MATCHED (KW_AND expression)? KW_THEN (merge_update | KW_DELETE | KW_DO KW_NOTHING)
    | KW_WHEN KW_NOT KW_MATCHED (KW_AND expression)? KW_THEN (merge_insert | KW_DO KW_NOTHING)
    ;

merge_insert
    : KW_INSERT (opt_column_list)? (KW_OVERRIDING (KW_SYSTEM | KW_USER) KW_VALUE)? default_values_or_values
    ;

merge_update
    : KW_UPDATE KW_SET (
        column_name EQUAL exprofdefault
        | opt_column_list EQUAL OPEN_PAREN exprofdefault (COMMA exprofdefault)* CLOSE_PAREN
    )+
    ;

default_values_or_values
    : KW_VALUES OPEN_PAREN exprofdefault (COMMA exprofdefault)* CLOSE_PAREN
    | KW_DEFAULT KW_VALUES
    ;

exprofdefault
    : sortBy
    | KW_DEFAULT
    ;

stmt_close
    : KW_CLOSE cursor_variable SEMI
    ;

stmt_null
    : KW_NULL SEMI
    ;

stmt_commit_or_rollback
    : (KW_COMMIT | KW_ROLLBACK) (KW_AND KW_NO? KW_CHAIN)? SEMI
    ;

stmt_set
    : KW_SET any_name KW_TO KW_DEFAULT SEMI
    | KW_RESET (any_name | KW_ALL) SEMI
    ;

cursor_variable
    : colId
    | PARAM
    ;

exception_sect
    : KW_EXCEPTION (KW_WHEN (proc_condition (KW_OR proc_condition)*) KW_THEN proc_stmt*)+
    ;

proc_condition
    : any_identifier
    | KW_SQLSTATE stringConst
    ;

any_identifier
    : colId
    | unreserved_keyword
    ;

sql_expression
    : target_list? into_clause? from_clause? where_clause? group_clause? (KW_HAVING expression)? window_clause?
    ;