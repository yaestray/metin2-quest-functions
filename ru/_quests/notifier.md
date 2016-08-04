# Система уведомлений
Данный квест позволит вам запустить собственную простую систему уведомлений. В этой системе уведомлений можно будет, например, сообщать важные новости, ссылки на социальные сети и прочую информацию.

> **Важно!** Данный квест не тестировался перед публикацией.

## Исходный код
### questlib.lua
Добавьте в ваш файл-библиотеку следующие строчки:

````lua
NOTIFIER_INTERVAL = 15 * 60
NOTIFIER_MESSAGES = {
	"15 января в 18:00 по МСК будет проходить PvP-турнир. Не забудьте взять с собой своё эго. ",
	"Подписывайтесь на наш репозиторий на GitHub: github.com/terron-kun/quest-functions ",
	"Знания - для ботаников. Вместо ОХ-эвента мы решили провести PvP-турнир. "
}

clear_server_timer("notifier_loop_timer")
server_loop_timer("notifier_loop_timer", NOTIFIER_INTERVAL)
````

### notifier.quest
Создайте файл с именем `notifier.quest`, задайте ему кодировку ANSI или Windows-1251 (также известна как cp1251) и поместите туда код: 

````lua
quest notifier begin
	state start begin
		when notifier_loop_timer.server_timer begin
			local msg_count = table.getn(NOTIFIER_MESSAGES)
			local random_msg_id = number(1, msg_count)
			local msg_text = NOTIFIER_MESSAGES[random_msg_id]
		
			notice_all(msg_text)
		end
	end
end
````

Добавьте в файл `quest_list` (без расширения) строчку `notifier.quest`. Затем заливайте всё на сервер и компилируйте. Не забывайте, что у всех файлов на конце должна быть пустая строка.

## Конфигурация квеста
Константа **NOTIFIER_INTERVAL** содержит в себе частоту появления уведомлений.
Константа **NOTIFIER_MESSAGES** содержит в себе таблицу возможных сообщений.