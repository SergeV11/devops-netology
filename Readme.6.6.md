# Домашнее задание к занятию "6.6. Troubleshooting"


## 1.

операцию можно найти командой:
```
db.currentOp()
```

завершение операции:
```
db.killOp()
```

вероятнее всего проблема в отсутствии либо некорректном индексе, соответственно чтобы ускорить выполнение операций нужно его либо создать, либо сделать ребилд

## 2.

судя по документации, закончилась оперативная память и часть данных начала уходить в своп

## 3.

эта ошибка говорит о потере соединения с сервером во время запроса. как правило это случается на больших запросах. и видимо началось это из-за значительного увеличения объёма данных

- первое что нужно сделать это убедиться что все необходимые индексы созданы и находятся в актуальном состоянии
- также можно попробовать увеличить параметры net_read_timeout, wait_timeout, connect_timeout, interactive_timeout
- если проблема в недостатке ресурсов, то можно их увеличить
- также в редких случаях это может быть проблема коннектора к бд


## 4.

это происходит потому что оперативная память закончилась. процесс Out-Of-Memory Killer принимает решение завершить процесс который съедает память чтобы сама ос продолжила работу.
решение проблемы заключается либо в увеличении оперативной памяти, либо в ограничении используемой памяти в настройках PostgreSQL
