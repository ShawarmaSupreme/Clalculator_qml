#pragma once

#include <QObject>
#include <QString>
#include <QStack>
#include <QRegularExpression>

class Calculator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString expression READ expression NOTIFY expressionChanged)
    Q_PROPERTY(QString result READ result NOTIFY resultChanged)

public:
    explicit Calculator(QObject *parent = nullptr);

    QString expression() const;
    QString result() const;

signals:
    void expressionChanged();
    void resultChanged();
    void secretMenuActivated();

public slots:
    void inputDigit(const QString &digit);
    void inputOperator(const QString &op);
    void clear();
    void brackets();
    void toggleSign();
    void inputPercent();
    void calculate();

    Q_INVOKABLE void showSecretMenu() {
        emit secretMenuActivated();
    }

private:
    QString m_expression;
    QString m_result;
    bool m_hasOperator = false;
    bool m_hasDecimal = false;
    bool m_justCalculated = false;

    void resetFlags();
    double evaluateExpression(const QString &expr);
    QString formatResult(double result);
};
