#include "Calculator.h"
#include <QJSEngine>
#include <QDebug>
#include <cmath>

Calculator::Calculator(QObject *parent) : QObject(parent)
{
    m_result = "0";
}

QString Calculator::expression() const
{
    return m_expression;
}

QString Calculator::result() const
{
    return m_result;
}

void Calculator::inputDigit(const QString &digit)
{
    if (m_justCalculated) {
        m_expression.clear();
        m_justCalculated = false;
        resetFlags();
    }

    if (digit == ".") {
        if (!m_hasDecimal) {
            if (m_expression.isEmpty() || m_expression.endsWith(" ")) {
                m_expression += "0";
            }
            m_expression += ".";
            m_hasDecimal = true;
        }
    } else {
        if (m_expression == "0" || m_expression == "Error") {
            m_expression.clear();
        }
        m_expression += digit;
    }

    m_hasOperator = false;
    m_hasDecimal = true;

    emit expressionChanged();
}

void Calculator::inputOperator(const QString &op)
{
    if (m_expression.isEmpty() || m_expression == "Error") {
        if (op == "-") {
            m_expression = "-";
            emit expressionChanged();
        }
        return;
    }

    if (m_expression.endsWith('.')) {
        m_expression += '0';
    }

    QChar lastChar = m_expression.at(m_expression.size() - 1);
    if (lastChar == '(' && op != "-") {
        return;
    }

    if (m_hasOperator) {
        m_expression.chop(3);
    }

    if (op == "+") m_expression += " + ";
    else if (op == "-") m_expression += " - ";
    else if (op == "*") m_expression += " × ";
    else if (op == "/") m_expression += " ÷ ";

    m_hasOperator = true;
    m_hasDecimal = false;
    emit expressionChanged();
}

void Calculator::clear()
{
    m_expression.clear();
    m_result = "0";
    resetFlags();
    emit expressionChanged();
    emit resultChanged();
}

void Calculator::brackets()
{
    if (m_justCalculated) {
        m_expression = m_result;
        m_justCalculated = false;
    }

    if (m_expression.isEmpty()) {
        m_expression = "(";
    } else {
        int open = m_expression.count('(');
        int close = m_expression.count(')');
        QChar last = m_expression.at(m_expression.size()-1);

        if (open == close || last == '(' || last == ' ') {
            m_expression += "(";
        } else {
            m_expression += ")";
        }
    }

    emit expressionChanged();
}

void Calculator::toggleSign()
{
    if (m_expression.isEmpty() || m_expression == "Error") return;

    if (m_expression.startsWith("-")) {
        m_expression.remove(0, 1);
    } else {
        m_expression.prepend("-");
    }

    emit expressionChanged();
}

void Calculator::inputPercent()
{
    if (m_expression.isEmpty() || m_expression == "Error") return;
    m_expression += "%";
    emit expressionChanged();
}

void Calculator::calculate()
{
    if (m_expression.isEmpty() || m_expression == "Error") return;

    try {
        QString expr = m_expression;
        expr.replace(" ", "");
        expr.replace("×", "*").replace("÷", "/");

        expr.replace("%", "*0.01");

        QJSEngine engine;
        QJSValue value = engine.evaluate(expr);

        if (value.isError()) {
            m_result = "Error";
        } else {
            double result = value.toNumber();

            if (std::abs(result) > 1e10 || (std::abs(result) < 1e-10 && result != 0)) {
                m_result = QString::number(result, 'g', 10);
            } else if (std::floor(result) == result) {
                m_result = QString::number(static_cast<long>(result));
            } else {
                m_result = QString::number(result, 'f', 6);
                while (m_result.endsWith('0')) m_result.chop(1);
                if (m_result.endsWith('.')) m_result.chop(1);
            }
        }
    } catch (...) {
        m_result = "Error";
    }

    m_justCalculated = true;
    emit resultChanged();
}

void Calculator::resetFlags()
{
    m_hasOperator = false;
    m_hasDecimal = false;
    m_justCalculated = false;
}
