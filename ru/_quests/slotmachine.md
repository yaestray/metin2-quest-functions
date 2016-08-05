# Слот-машина
Данный квест является некой эмуляцией слот-машины. Суть такая: есть ряд из 5 ячеек. Когда в этих ячейках появляются 3 предмета или больше подряд, то игрок побеждает. Вот пример выигрышной комбинации:

| 1-й предмет  | 2-й предмет  | 3-й предмет  | 4-й предмет | 5-й предмет |
| ------------ | ------------ | ------------ | ----------- | ----------- |
| **Самоцвет** | **Самоцвет** | **Самоцвет** | Сякен       | Зуб орка    |

А такая комбинация не является выигрышной, потому что 3 предмета находятся не подряд:

| 1-й предмет  | 2-й предмет  | 3-й предмет | 4-й предмет  | 5-й предмет |
| ------------ | ------------ | ----------- | ------------ | ----------- |
| **Самоцвет** | **Самоцвет** | Сякен       | **Самоцвет** | Зуб орка    |

А в этом примере тоже считается, что выпало 3 предмета подряд:

| 1-й предмет  | 2-й предмет  | 3-й предмет  | 4-й предмет | 5-й предмет  |
| ------------ | ------------ | ------------ | ----------- | ------------ |
| **Самоцвет** | **Самоцвет** | **Самоцвет** | Сякен       | **Самоцвет** |

В этом примере выпало 4 предмета подряд:

| 1-й предмет  | 2-й предмет  | 3-й предмет  | 4-й предмет  | 5-й предмет  |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| Сякен        | **Самоцвет** | **Самоцвет** | **Самоцвет** | **Самоцвет** |

А тут и вовсе 5:

| 1-й предмет  | 2-й предмет  | 3-й предмет  | 4-й предмет  | 5-й предмет  |
| ------------ | ------------ | ------------ | ------------ | ------------ |
| **Самоцвет** | **Самоцвет** | **Самоцвет** | **Самоцвет** | **Самоцвет** |

> **Важно!** Данный квест не тестировался перед публикацией.

## Исходный код
### questlib.lua
Добавьте в конец вашего файла-библиотеки следующий код:

````lua
SLOTMACHINE__WRITE_LOGS = true
SLOTMACHINE__PRICE = 100000
SLOTMACHINE__NPC_VNUM = 9012
SLOTMACHINE__REWARDS = {
	{
		["item_vnum"] = 50034,
		["count"]     = {1, 5, 10}, -- 3-streak, 4-streak, 5-streak 
		["icon_path"] = "slotmachine/50034.tga"
	},
	{
		["item_vnum"] = 30094,
		["count"]     = {3, 10, 25}, -- 3-streak, 4-streak, 5-streak
		["icon_path"] = "slotmachine/30094.tga"
	},
	{
		["item_vnum"] = 80009,
		["count"]     = {1, 5, 15}, -- 3-streak, 4-streak, 5-streak
		["icon_path"] = "slotmachine/80009.tga"
	},
	-- etc
}
````

### slotmachine.quest
Создайте файл с именем `slotmachine.quest`, задайте ему кодировку ANSI или Windows-1251 (также известна как cp1251) и поместите туда код: 

````lua
quest slotmachine begin
	state start begin
		when SLOTMACHINE__NPC_VNUM.chat."Сыграть в игру " begin
			say_title(mob_name(npc.get_race()) .. ": ")
			say("Привет! Правила игры посты: если ")
			say("тебе выпадет 3 предмета в ряд, то ")
			say("ты их и получишь. Если впадет 4 или ")
			say("5 предметов, то награда увеличится. ")
			say(" ")
			say("Одна игра стоит " .. SLOTMACHINE__PRICE .. " янг. ")

			if select("Играю! ", "Не, я передумал ") == 2 then
				return
			end

			if pc.get_gold() < SLOTMACHINE__PRICE then
				syschat("У вас недостаточно янг. Одна игра стоит " .. SLOTMACHINE__PRICE .. ", а у вас всего " .. pc.get_gold() .. ". ")
				return
			end

			pc.change_gold(SLOTMACHINE__PRICE * -1)

			local results = {}
			local streak = 0

			say_title(mob_name(npc.get_race())..": ")

			for i = 0, 4, 1 do
				results[i] = number(1, table.getn(SLOTMACHINE__REWARDS))
				addimage(70 + 20 + i * 32, 44,  results[i]["icon_path"])
			end

			say(" ")
			say(" ")
			say(" ")

			if results[1] == results[2] and results[2] == results[3] and results[3] == results[4] and results[4] == results[5] then
				streak = 3
			elseif (results[2] == results[3] and results[3] == results[4]) and (results[1] == results[3] or results[5] == results[3]) then
				streak = 2
			elseif (results[1] == results[2] and results[2] == results[3]) or (results[2] == results[3] and results[3] == results[4]) or (results[3] == results[4] and results[4] == results[5]) then
				streak = 1
			end

			if streak == 0 then
				say("К сожалению, вы ничего не выиграли. ")
				return
			end

			say("Вы выиграли " .. item_name(SLOTMACHINE__REWARDS[results[3]]["item_vnum"]) .. " в количестве " .. SLOTMACHINE__REWARDS[results[3]]["count"][streak] .. " шт. ")

			pc.give_item2(SLOTMACHINE__REWARDS[results[3]]["item_vnum"], SLOTMACHINE__REWARDS[results[3]]["count"][streak])

			if SLOTMACHINE__WRITE_LOGS then
				char_log(SLOTMACHINE__REWARDS[results[3]]["item_vnum"], "SLOTMACHINE", SLOTMACHINE__REWARDS[results[3]]["count"][streak])
			end
		end
	end
end
````

### quest_list
Добавьте в конец файла `quest_list` (без расширения) следующие квесты:

````
slotmachine.quest
````

### Другое
В клиенте поместите иконки в формате TGA в директорию `\ymir work\ui\game\questboard\slotmachine\`. Имена иконки должны иметь такие же, как указаны в константе **SLOTMACHINE__REWARDS**.

## Конфигурация квеста
Константа **SLOTMACHINE__WRITE_LOGS** отвечает за то, нужно ли сохранять логи побед в базе данных. `true`, если нужно, иначе `false`. Логи можно найти в таблице `log.log`. Поле `how` всегда содержит `SLOTMACHINE`; поле `what` &mdash; vnum предмета, который выиграл игрок; поле `hint` &mdash; количество предметов, которое выиграл игрок; поле `who` &mdash; ID персонажа игрока.<br>
Константа **SLOTMACHINE__PRICE** содержит в себе стоимость одной игры в янгах.<br>
Константа **SLOTMACHINE__NPC_VNUM** содержит в себе vnum NPC, с которым будет происходить диалог.<br>
Константа **SLOTMACHINE__REWARDS** содержит в себе таблицу наград.