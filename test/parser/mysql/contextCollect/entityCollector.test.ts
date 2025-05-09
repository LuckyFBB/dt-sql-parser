import { ParseTreeListener } from 'antlr4ng';
import fs from 'fs';
import path from 'path';
import { MySqlParserListener } from 'src/lib/mysql/MySqlParserListener';
import {
    AttrName,
    isCommonEntityContext,
    isFuncEntityContext,
    StmtContextType,
} from 'src/parser/common/entityCollector';
import { EntityContextType } from 'src/parser/common/types';
import { MySQL, MySqlEntityCollector, MysqlSplitListener } from 'src/parser/mysql';

const commonSql = fs.readFileSync(path.join(__dirname, 'fixtures', 'common.sql'), 'utf-8');

describe('MySQL entity collector tests', () => {
    const mysql = new MySQL();
    const parseTree = mysql.parse(commonSql);
    const splitListener = new MysqlSplitListener();
    mysql.listen(splitListener as MySqlParserListener, parseTree);

    test('validate common sql', () => {
        expect(mysql.validate(commonSql).length).toBe(0);
    });

    test('split results', () => {
        expect(splitListener.statementsContext.length).toBe(16);
    });

    test('create table by columns', () => {
        const columnCreateTableContext = splitListener.statementsContext[0];

        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, columnCreateTableContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const tableCreateEntity = allEntities[0];

        expect(tableCreateEntity.entityContextType).toBe(EntityContextType.TABLE_CREATE);
        expect(tableCreateEntity.text).toBe('new_tb_with_col');
        expect(tableCreateEntity.position).toEqual({
            startIndex: 13,
            endIndex: 27,
            line: 1,
            startColumn: 14,
            endColumn: 29,
        });
        expect(tableCreateEntity[AttrName.comment]).toEqual({
            text: "'new_tb_with_col comment'",
            startIndex: 77,
            endIndex: 101,
            line: 1,
            startColumn: 78,
            endColumn: 103,
        });

        expect(tableCreateEntity.belongStmt.stmtContextType).toBe(
            StmtContextType.CREATE_TABLE_STMT
        );
        expect(tableCreateEntity.belongStmt.position).toEqual({
            startIndex: 0,
            endIndex: 101,
            startLine: 1,
            endLine: 1,
            startColumn: 1,
            endColumn: 103,
        });
        if (isCommonEntityContext(tableCreateEntity)) {
            expect(tableCreateEntity.relatedEntities).toBeNull();

            expect(tableCreateEntity.columns.length).toBe(2);
            tableCreateEntity.columns.forEach((columEntity) => {
                expect(columEntity.entityContextType).toBe(EntityContextType.COLUMN_CREATE);
                expect(columEntity.belongStmt).toBe(tableCreateEntity.belongStmt);
                expect(columEntity.text).toBe(
                    commonSql.slice(
                        columEntity.position.startIndex,
                        columEntity.position.endIndex + 1
                    )
                );
            });
            expect(tableCreateEntity.columns[0][AttrName.comment]).toEqual({
                text: "'col1'",
                startIndex: 45,
                endIndex: 50,
                line: 1,
                startColumn: 46,
                endColumn: 52,
            });

            expect(tableCreateEntity.columns[0][AttrName.colType]).toEqual({
                text: 'int',
                startIndex: 33,
                endIndex: 35,
                line: 1,
                startColumn: 34,
                endColumn: 37,
            });
            expect(tableCreateEntity.columns[1][AttrName.comment]).toBeNull();
            expect(tableCreateEntity.columns[1][AttrName.colType]).toEqual({
                text: 'varchar(3)',
                startIndex: 57,
                endIndex: 66,
                line: 1,
                startColumn: 58,
                endColumn: 68,
            });
        }
    });

    test('create table by select', () => {
        const createTableBySelectContext = splitListener.statementsContext[1];

        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, createTableBySelectContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(3);

        const tableCreateEntity = allEntities[0];

        expect(tableCreateEntity.entityContextType).toBe(EntityContextType.TABLE_CREATE);
        expect(tableCreateEntity.text).toBe('new_tb_from_old');
        expect(tableCreateEntity.position).toEqual({
            startIndex: 118,
            endIndex: 132,
            line: 3,
            startColumn: 14,
            endColumn: 29,
        });

        expect(tableCreateEntity.belongStmt.stmtContextType).toBe(
            StmtContextType.CREATE_TABLE_STMT
        );
        expect(tableCreateEntity.belongStmt.position).toEqual({
            startIndex: 105,
            endIndex: 321,
            startLine: 3,
            endLine: 12,
            startColumn: 1,
            endColumn: 34,
        });
        if (isCommonEntityContext(tableCreateEntity)) {
            expect(tableCreateEntity.columns).toBeUndefined();

            expect(tableCreateEntity.relatedEntities.length).toBe(2);
            tableCreateEntity.relatedEntities.forEach((relatedEntity) => {
                expect(relatedEntity.entityContextType).toBe(EntityContextType.TABLE);
                expect(allEntities.some((en) => relatedEntity === en)).toBeTruthy();
            });
        }
        expect(allEntities[1].text).toBe('old_tb1');
        expect(allEntities[1].belongStmt.rootStmt).toBe(allEntities[0].belongStmt);
        expect(allEntities[1].position).toEqual({
            startIndex: 217,
            endIndex: 223,
            line: 8,
            startColumn: 9,
            endColumn: 16,
        });

        expect(allEntities[2].text).toBe('old_tb2');
        expect(allEntities[2].belongStmt.rootStmt).toBe(allEntities[0].belongStmt);
        expect(allEntities[2].position).toEqual({
            startIndex: 243,
            endIndex: 249,
            line: 10,
            startColumn: 9,
            endColumn: 16,
        });
    });

    test('create table like', () => {
        const createTableLikeContext = splitListener.statementsContext[2];

        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, createTableLikeContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(2);

        const tableCreateEntity = allEntities[0];
        const originTableEntity = allEntities[1];

        expect(tableCreateEntity.entityContextType).toBe(EntityContextType.TABLE_CREATE);
        expect(tableCreateEntity.text).toBe('new_tb_like_old');
        expect(tableCreateEntity.belongStmt.stmtContextType).toBe(
            StmtContextType.CREATE_TABLE_STMT
        );
        if (isCommonEntityContext(tableCreateEntity)) {
            expect(tableCreateEntity.columns).toBeUndefined();
            expect(tableCreateEntity.relatedEntities.length).toBe(1);
            expect(tableCreateEntity.relatedEntities[0]).toBe(originTableEntity);
        }
        expect(originTableEntity.entityContextType).toBe(EntityContextType.TABLE);
        expect(originTableEntity.text).toBe('old_tb');
        expect(originTableEntity.belongStmt).toBe(tableCreateEntity.belongStmt);
    });

    test('common select from table', () => {
        const selectTableContext = splitListener.statementsContext[3];
        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, selectTableContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const tableEntity = allEntities[0];

        expect(tableEntity.entityContextType).toBe(EntityContextType.TABLE);
        expect(tableEntity.text).toBe('select_tb');
        expect(tableEntity.belongStmt.stmtContextType).toBe(StmtContextType.SELECT_STMT);
        if (isCommonEntityContext(tableEntity)) {
            expect(tableEntity.columns).toBeUndefined();
            expect(tableEntity.relatedEntities).toBeNull();
        }
    });

    test('select into from table', () => {
        const selectTableContext = splitListener.statementsContext[4];
        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, selectTableContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const tableEntity = allEntities[0];

        expect(tableEntity.entityContextType).toBe(EntityContextType.TABLE);
        expect(tableEntity.text).toBe('into_select_tb');
        expect(tableEntity.belongStmt.stmtContextType).toBe(StmtContextType.SELECT_STMT);
        if (isCommonEntityContext(tableEntity)) {
            expect(tableEntity.columns).toBeUndefined();
            expect(tableEntity.relatedEntities).toBeNull();
        }
    });

    test('select from table join', () => {
        const selectTableContext = splitListener.statementsContext[5];
        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, selectTableContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(2);

        const tableEntity1 = allEntities[0];
        const tableEntity2 = allEntities[1];

        expect(tableEntity1.entityContextType).toBe(EntityContextType.TABLE);
        expect(tableEntity1.text).toBe('from_tb');
        expect(tableEntity1.belongStmt.stmtContextType).toBe(StmtContextType.SELECT_STMT);
        expect(tableEntity1[AttrName.alias]).toEqual({
            text: 'tb1',
            startIndex: 476,
            endIndex: 478,
            line: 21,
            startColumn: 26,
            endColumn: 29,
        });
        if (isCommonEntityContext(tableEntity1)) {
            expect(tableEntity1.columns).toBeUndefined();
            expect(tableEntity1.relatedEntities).toBeNull();
        }

        expect(tableEntity2.entityContextType).toBe(EntityContextType.TABLE);
        expect(tableEntity2.text).toBe('join_tb');
        expect(tableEntity2.belongStmt.stmtContextType).toBe(StmtContextType.SELECT_STMT);
        if (isCommonEntityContext(tableEntity2)) {
            expect(tableEntity2.columns).toBeUndefined();
            expect(tableEntity2.relatedEntities).toBeNull();
        }

        expect(tableEntity1.belongStmt).toBe(tableEntity2.belongStmt);
    });

    test('insert into table values', () => {
        const insertTableContext = splitListener.statementsContext[6];
        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, insertTableContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const tableEntity = allEntities[0];

        expect(tableEntity.entityContextType).toBe(EntityContextType.TABLE);
        expect(tableEntity.text).toBe('insert_tb');
        expect(tableEntity.belongStmt.stmtContextType).toBe(StmtContextType.INSERT_STMT);
        if (isCommonEntityContext(tableEntity)) {
            expect(tableEntity.columns).toBeUndefined();
            expect(tableEntity.relatedEntities).toBeNull();
        }
    });

    test('insert into table select', () => {
        const insertTableContext = splitListener.statementsContext[7];
        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, insertTableContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(3);

        const insertTableEntity = allEntities[0];
        const fromTableEntity1 = allEntities[1];
        const fromTableEntity2 = allEntities[2];

        expect(insertTableEntity.entityContextType).toBe(EntityContextType.TABLE);
        expect(insertTableEntity.text).toBe('insert_from_tb');
        expect(insertTableEntity.belongStmt.stmtContextType).toBe(StmtContextType.INSERT_STMT);

        expect(fromTableEntity1.entityContextType).toBe(EntityContextType.TABLE);
        expect(fromTableEntity1.text).toBe('from_tb1');
        expect(fromTableEntity1.belongStmt.stmtContextType).toBe(StmtContextType.SELECT_STMT);

        expect(fromTableEntity2.entityContextType).toBe(EntityContextType.TABLE);
        expect(fromTableEntity2.text).toBe('from_tb2');
        expect(fromTableEntity2.belongStmt.stmtContextType).toBe(StmtContextType.SELECT_STMT);

        expect(fromTableEntity1.belongStmt.parentStmt).toBe(insertTableEntity.belongStmt);
        expect(fromTableEntity2.belongStmt.parentStmt).toBe(insertTableEntity.belongStmt);
        expect(fromTableEntity1.belongStmt.rootStmt).toBe(insertTableEntity.belongStmt);
        expect(fromTableEntity2.belongStmt.rootStmt).toBe(insertTableEntity.belongStmt);
    });

    test('create view with col', () => {
        const insertTableContext = splitListener.statementsContext[8];
        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, insertTableContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        expect(allEntities[0].entityContextType).toBe(EntityContextType.VIEW_CREATE);
        expect(allEntities[0].text).toBe('new_view');
        expect(allEntities[0].belongStmt.stmtContextType).toBe(StmtContextType.CREATE_VIEW_STMT);
        if (isCommonEntityContext(allEntities[0])) {
            expect(allEntities[0].columns.length).toBe(2);
            expect(allEntities[0].columns[0].text).toBe('col1');
            expect(allEntities[0].columns[1].text).toBe('col2');
            expect(allEntities[0].columns[0].entityContextType).toBe(
                EntityContextType.COLUMN_CREATE
            );
            expect(allEntities[0].columns[0].belongStmt).toBe(allEntities[0].belongStmt);
        }
    });

    test('create view as select table', () => {
        const insertTableContext = splitListener.statementsContext[9];
        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, insertTableContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(2);

        expect(allEntities[0].entityContextType).toBe(EntityContextType.VIEW_CREATE);
        expect(allEntities[0].text).toBe('db.new_view');
        expect(allEntities[0].belongStmt.stmtContextType).toBe(StmtContextType.CREATE_VIEW_STMT);
    });

    test('create database', () => {
        const dbCreateContext = splitListener.statementsContext[10];

        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, dbCreateContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const dbEntity = allEntities[0];

        expect(dbEntity.entityContextType).toBe(EntityContextType.DATABASE_CREATE);
        expect(dbEntity.text).toBe('db_name');
        expect(dbEntity.position).toEqual({
            endColumn: 24,
            endIndex: 841,
            line: 31,
            startColumn: 17,
            startIndex: 835,
        });

        expect(dbEntity.belongStmt.stmtContextType).toBe(StmtContextType.CREATE_DATABASE_STMT);
        expect(dbEntity.belongStmt.position).toEqual({
            endColumn: 47,
            endIndex: 864,
            endLine: 31,
            startColumn: 1,
            startIndex: 819,
            startLine: 31,
        });
        if (isCommonEntityContext(dbEntity)) {
            expect(dbEntity.columns).toBeUndefined();
            expect(dbEntity.relatedEntities).toBeNull();
        }
    });

    test('create schema', () => {
        const schemaCreateContext = splitListener.statementsContext[11];

        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, schemaCreateContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const schemaEntity = allEntities[0];

        expect(schemaEntity.entityContextType).toBe(EntityContextType.DATABASE_CREATE);
        expect(schemaEntity.text).toBe('db_name');
        expect(schemaEntity.position).toEqual({
            endColumn: 36,
            endIndex: 902,
            line: 33,
            startColumn: 29,
            startIndex: 896,
        });

        expect(schemaEntity.belongStmt.stmtContextType).toBe(StmtContextType.CREATE_DATABASE_STMT);
        expect(schemaEntity.belongStmt.position).toEqual({
            endColumn: 59,
            endIndex: 925,
            endLine: 33,
            startColumn: 1,
            startIndex: 868,
            startLine: 33,
        });
        if (isCommonEntityContext(schemaEntity)) {
            expect(schemaEntity.columns).toBeUndefined();
            expect(schemaEntity.relatedEntities).toBeNull();
        }
    });

    test('show create database', () => {
        const dbCreateContext = splitListener.statementsContext[12];

        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, dbCreateContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const dbEntity = allEntities[0];

        expect(dbEntity.entityContextType).toBe(EntityContextType.DATABASE);
        expect(dbEntity.text).toBe('db_name');
        expect(dbEntity.position).toEqual({
            endColumn: 41,
            endIndex: 968,
            line: 35,
            startColumn: 34,
            startIndex: 962,
        });

        expect(dbEntity.belongStmt.stmtContextType).toBe(StmtContextType.COMMON_STMT);
        expect(dbEntity.belongStmt.position).toEqual({
            endColumn: 42,
            endIndex: 969,
            endLine: 35,
            startColumn: 1,
            startIndex: 929,
            startLine: 35,
        });
        if (isCommonEntityContext(dbEntity)) {
            expect(dbEntity.columns).toBeUndefined();
            expect(dbEntity.relatedEntities).toBeNull();
        }
    });

    test('drop database', () => {
        const dbDropContext = splitListener.statementsContext[13];

        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, dbDropContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const dbEntity = allEntities[0];

        expect(dbEntity.entityContextType).toBe(EntityContextType.DATABASE);
        expect(dbEntity.text).toBe('db_name');
        expect(dbEntity.position).toEqual({
            endColumn: 30,
            endIndex: 1000,
            line: 37,
            startColumn: 23,
            startIndex: 994,
        });

        expect(dbEntity.belongStmt.stmtContextType).toBe(StmtContextType.COMMON_STMT);
        expect(dbEntity.belongStmt.position).toEqual({
            endColumn: 31,
            endIndex: 1001,
            endLine: 37,
            startColumn: 1,
            startIndex: 972,
            startLine: 37,
        });
        if (isCommonEntityContext(dbEntity)) {
            expect(dbEntity.columns).toBeUndefined();
            expect(dbEntity.relatedEntities).toBeNull();
        }
    });

    test('create function', () => {
        const functionCreateContext = splitListener.statementsContext[14];

        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, functionCreateContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const functionEntity = allEntities[0];

        expect(functionEntity.entityContextType).toBe(EntityContextType.FUNCTION_CREATE);
        expect(functionEntity.text).toBe('hello');
        expect(functionEntity.position).toEqual({
            endColumn: 39,
            endIndex: 1041,
            line: 39,
            startColumn: 34,
            startIndex: 1037,
        });

        expect(functionEntity[AttrName.comment]).toEqual({
            text: "'this is a defuner user function'",
            endColumn: 125,
            endIndex: 1127,
            line: 39,
            startColumn: 92,
            startIndex: 1095,
        });

        expect(functionEntity.belongStmt.stmtContextType).toBe(
            StmtContextType.CREATE_FUNCTION_STMT
        );
        expect(functionEntity.belongStmt.position).toEqual({
            endColumn: 156,
            endIndex: 1158,
            endLine: 39,
            startColumn: 1,
            startIndex: 1004,
            startLine: 39,
        });
        if (isFuncEntityContext(functionEntity)) {
            expect(functionEntity.arguments).toBeNull();
            expect(functionEntity.relatedEntities).toBeNull();
        }
    });

    test('create function loadable', () => {
        const functionCreateContext = splitListener.statementsContext[15];

        const collectListener = new MySqlEntityCollector(commonSql);
        mysql.listen(collectListener as ParseTreeListener, functionCreateContext);

        const allEntities = collectListener.getEntities();

        expect(allEntities.length).toBe(1);

        const functionEntity = allEntities[0];

        expect(functionEntity.entityContextType).toBe(EntityContextType.FUNCTION_CREATE);
        expect(functionEntity.text).toBe('my_concat_ws');
        expect(functionEntity.position).toEqual({
            endColumn: 43,
            endIndex: 1203,
            line: 41,
            startColumn: 31,
            startIndex: 1192,
        });

        expect(functionEntity.belongStmt.stmtContextType).toBe(
            StmtContextType.CREATE_FUNCTION_STMT
        );
        expect(functionEntity.belongStmt.position).toEqual({
            endColumn: 87,
            endIndex: 1247,
            endLine: 41,
            startColumn: 1,
            startIndex: 1162,
            startLine: 41,
        });
        if (isFuncEntityContext(functionEntity)) {
            expect(functionEntity.relatedEntities).toBeNull();
        }
    });
});
