# game.get_event_flag()
Функция **game.get_event_flag** сообщает значение эвентового (серверного) флага.

## Параметры функции
### flag_name
Тип *string*. **Обязательный параметр**. Имя флага.

## Возвращаемые значения
### value
Тип *number*. Значение эвентового флага. Если параметр [flag_name](#flag_name) не является строкой, а также если флага с таким именем не существует, то возвращается `0`.

## Примечания
Функция может быть вызвана анонимно.