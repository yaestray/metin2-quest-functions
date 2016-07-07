# pc.get_gm_level()
Функция **pc.get_gm_level** сообщает уровень доступа гейм-мастера.

## Возвращаемые значения
### access_level
Тип *number*. Уровень доступа администратора.

## Примечания
Функция **не** может быть вызвана анонимно.

Уровни доступа задаются в таблице `common.gmlist` в поле `mAuthority`. Существуют следующие уровни доступа:

| access_level | Название доступа | Название доступа (БД) |
| --- | --- | --- |
| 0 | GM_PLAYER | PLAYER |
| 1 | GM_LOW_WIZARD | LOW_WIZARD |
| 2 | GM_WIZARD | - |
| 3 | GM_HIGH_WIZARD | HIGH_WIZARD |
| 4 | GM_GOD | GOD |
| 5 | GM_IMPLEMENTOR | IMPLEMENTOR |