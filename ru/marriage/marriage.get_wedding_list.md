# marriage.get_wedding_list()
Функция **marriage.get_wedding_list** сообщает список свадеб, которые происходят в данный момент.

## Возвращаемые значения
### wedding_list
Тип *table*. Таблица, содержащая список свадеб. Таблица выглядит примерно так:

````lua
{
	{player1_id, player2_id, player1_name, player2_name},
	{player1_id, player2_id, player1_name, player2_name},
	-- etc
}
````

* `player1_id` <sup>number</sup> &mdash; ID первого игрока; 
* `player1_id` <sup>number</sup> &mdash; ID второго игрока; 
* `player1_name` <sup>string</sup> &mdash; имя первого игрока; 
* `player2_name` <sup>string</sup> &mdash; имя второго игрока.

## Примечания
Функция может быть вызвана анонимно.