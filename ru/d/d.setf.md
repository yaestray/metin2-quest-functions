# d.setf()
Функция **d.setf** создает флаг, который будет существовать в течение одной сессии в подземелье.

## Параметры функции
### flag_name
Тип *string*. **Обязательный параметр**. Название флага. Название флага не может быть длиннее максимально-допустимой длины поля szState в таблице player.quest.

### value
Тип *number*. **Обязательный параметр**. Значение флага.

## Примечания
Функция может быть вызвана анонимно.

Флаг будет обнулен после того, как все игроки выйдут из подземелья.

Эта функция работает только в подземельях.