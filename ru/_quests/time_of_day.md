# Система смены времени суток
Данный квест будет автоматически менять время суток на вашем сервере.

> **Важно!** Данный квест не тестировался перед публикацией.

## Исходный код
### questlib.lua
Добавьте в конец вашего файла-библиотеки следующий код:

````lua
TIME_OF_DAY__MORNING_TIME = 9
TIME_OF_DAY__NIGHT_TIME = 1
TIME_OF_DAY__CHECK_INTERVAL = 60
TIME_OF_DAY__DO_INIT = true

clear_server_timer("time_of_day_checker")
server_loop_timer("time_of_day_checker", TIME_OF_DAY__CHECK_INTERVAL)

function time_of_date__is_standart_mode_used()
	return math.max(TIME_OF_DAY__MORNING_TIME, TIME_OF_DAY__NIGHT_TIME) == TIME_OF_DAY__NIGHT_TIME
end

function time_of_date__is_day()
	local current_hour = tonumber(os.date("%H"))

	if time_of_date__is_standart_mode_used() then
		return current_hour >= TIME_OF_DAY__MORNING_TIME and current_hour < TIME_OF_DAY__NIGHT_TIME
	else
		return current_hour >= TIME_OF_DAY__MORNING_TIME or current_hour < TIME_OF_DAY__NIGHT_TIME
	end
end

-- Инициализация при запуске сервера
if TIME_OF_DAY__DO_INIT then
	if time_of_date__is_day() and game.get_event_flag("eclipse") == 0 then
		game.set_event_flag("eclipse", 1)
	elseif not time_of_date__is_day() and game.get_event_flag("eclipse") == 1 then
		game.set_event_flag("eclipse", 0)
	end
end
````

### times_of_day.quest
Создайте файл с именем `time_of_day.quest`, задайте ему кодировку ANSI или Windows-1251 (также известна как cp1251) и поместите туда код: 

````lua
quest time_of_day begin
	state start begin
		when time_of_day_checker.server_timer begin
			if time_of_date__is_day() and game.get_event_flag("eclipse") == 1 then
				game.set_event_flag("eclipse", 0)

				time_of_day.anyway_action()
				time_of_day.day_action()

			elseif not time_of_date__is_day() and game.get_event_flag("eclipse") == 0 then
				game.set_event_flag("eclipse", 1)

				time_of_day.anyway_action()
				time_of_day.night_action()
			end
		end

		-- Данная функция описывает события, которые произойдут во время изменения времени суток на день
		function day_action()
			notice_all("Доброе утро, сладкие игроки! ")
		end

		-- Данная функция описывает события, которые произойдут во время изменения времени суток на ночь
		function night_action()
			notice_all("Добрых снов, котики! ")
		end

		-- Данная функция описывает события, которые произойдут во время любого изменения времени суток
		function anyway_action()

		end
	end
end
````

### quest_list
Добавьте в конец файла `quest_list` (без расширения) следующие квесты:

````
time_of_day.quest
````

### quest_functions
Добавьте в конец файла `quest_functions` (без расширения) следующие функции:

````
time_of_date__is_standart_mode_used
time_of_date__is_day
````

## Конфигурация квеста
Константа **TIME_OF_DAY__MORNING_TIME** содержит в себе час, в который наступает утро.<br>
Константа **TIME_OF_DAY__NIGHT_TIME** содержит в себе час, в который наступает ночь.<br>
Константа **TIME_OF_DAY__CHECK_INTERVAL** содержит в себе частоту проверки времени суток в секундах.<br>
Константа **TIME_OF_DAY__DO_INIT** отвечает за то, нужно ли при включении сервера производить автоматическую инициализацию событий из квестового файла. Простыми словами: допустим, на вашем сервере автоматически проставляется квота при изменении времени суток. И после технических работ вы в ночное время включаете сервер, а на нём уже установлена ночь. Если данная константа имеет значение `false`, то при включении сервера ничего не произойдет и квест `time_of_day.quest` не будет работать до тех пор, пока не наступит день. Если присвоить константе значение `true`, то сервер при запуске выполнит инструкции, описанные в квестовом файле, присущие текущему времени суток.

## Функции
### time_of_date__is_standart_mode_used()
Возвращает информацию типа *boolean*. Сообщает, стоит ли стандартный режим времени суток. Это значит, что если ночь у вас наступает до 23:00, то функция вернет `true`. Если ночь наступает в 00:00 или позже, то это считается нестандартным режимом и функция вернет `false`.

### time_of_date__is_day()
Возвращает информацию типа *boolean*. `true`, если сейчас на сервере дневное время, и `false`, если ночное. Обратите внимание на то, что данная функция работает со временем. Она не сообщает, действительно ли на сервере сейчас установлена ночь.