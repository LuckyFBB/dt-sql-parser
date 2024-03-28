import { CodeCompletionCore } from 'antlr4-c3';
import { ParseErrorListener } from '../common/parseErrorListener';
import { Parser, Token } from 'antlr4ng';
import { MySqlParser } from '../../lib/mysql/MySqlParser';

export class MysqlErrorListener extends ParseErrorListener {
    private preferredRules: Set<number>;

    private objectNames: Map<number, string> = new Map([
        [MySqlParser.RULE_databaseName, 'database'],
        [MySqlParser.RULE_databaseNameCreate, 'database'],
        [MySqlParser.RULE_tableName, 'table'],
        [MySqlParser.RULE_tableNameCreate, 'table'],
        [MySqlParser.RULE_viewName, 'view'],
        [MySqlParser.RULE_viewNameCreate, 'view'],
        [MySqlParser.RULE_functionName, 'function'],
        [MySqlParser.RULE_functionNameCreate, 'function'],
        [MySqlParser.RULE_columnName, 'column'],
        [MySqlParser.RULE_columnNameCreate, 'column'],
    ]);

    constructor(errorListener, preferredRules) {
        super(errorListener);
        this.preferredRules = preferredRules;
    }

    public getExpectedText(parser: Parser, token: Token) {
        let expectedText = '';

        let currentContext = parser.context;
        while (currentContext?.parent) {
            currentContext = currentContext.parent;
        }

        const core = new CodeCompletionCore(parser);
        core.preferredRules = this.preferredRules;
        const candidates = core.collectCandidates(token.tokenIndex, currentContext);

        if (candidates.rules.size) {
            // get expectedText as collect rules first
            for (const candidate of candidates.rules) {
                const [ruleType] = candidate;
                const name = this.objectNames.get(ruleType);
                switch (ruleType) {
                    case MySqlParser.RULE_databaseName:
                    case MySqlParser.RULE_tableName:
                    case MySqlParser.RULE_functionName:
                    case MySqlParser.RULE_viewName: {
                        if (!name) {
                            expectedText = 'a new object name';
                        } else {
                            expectedText = `a new ${name} name`;
                        }
                        break;
                    }
                    case MySqlParser.RULE_databaseNameCreate:
                    case MySqlParser.RULE_tableNameCreate:
                    case MySqlParser.RULE_functionNameCreate:
                    case MySqlParser.RULE_viewNameCreate: {
                        if (!name) {
                            expectedText = 'an existing object';
                        } else {
                            expectedText = `an existing ${name}`;
                        }
                        break;
                    }
                }
            }
        }
        if (candidates.tokens.size) {
            expectedText += expectedText ? ' or a keyword' : 'a keyword';
        }
        return expectedText;
    }
}
