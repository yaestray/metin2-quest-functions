# guild.get_reserve_war_table()
Функция **guild.get_reserve_war_table** сообщает список воюющих гильдий.

## Возвращаемые значения
### war_list
Тип *table*. Список воюющих гильдий. Таблица выглядит примерно так:

````lua
{
	{war_id, winner, loser, handicap}, -- первая воюющая пара
	{war_id, winner, loser, handicap}, -- вторая воюющая пара
	-- и т.д.
}
````

* `war_id` <sup>number</sup> &mdash; уникальный ID войны;
* `winner` <sup>number</sup> &mdash; ID побеждающей гильдии;
* `loser` <sup>number</sup> &mdash; ID проигрывающей гильдии;
* `handicap` <sup>number</sup> &mdash; неизвестно, что это.

Если нет войн, то возвращается пустая таблица, то бишь `{}`.

## Примечания
Функция может быть вызвана анонимно.