# d.new_jump_all()
Функция **d.new_jump_all** создет подземелье и телепортирует в него всех игроков, которые находятся в локации, из которой была вызвана функция.

## Параметры функции
### map_index
Тип *number*. **Обязательный параметр**. Индекс локации, в которой будет создано подземелье.

### x
Тип *number*. **Обязательный параметр**. Серверная координата по оси X без двух нулей на конце.

### y
Тип *number*. **Обязательный параметр**. Серверная координата по оси Y без двух нулей на конце.

## Примечания
Функция **не** может быть вызвана анонимно.

Телепортируются даже те игроки, которые торгуют.