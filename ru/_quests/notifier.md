# Система уведомлений
Данный квест позволит вам запустить собственную простую систему уведомлений. В этой системе уведомлений можно будет, например, сообщать важные новости, ссылки на социальные сети и прочую информацию.

> **Важно!** Данный квест не тестировался перед публикацией.

## Исходный код
### questlib.lua
Добавьте в конец вашего файла-библиотеки следующий код:

````lua
NOTIFIER__INTERVAL = 60 * 15
NOTIFIER__MESSAGES = {
	"15 января в 18:00 по МСК будет проходить PvP-турнир. Не забудьте взять с собой своё эго. ",
	"Подписывайтесь на наш репозиторий на GitHub: github.com/terron-kun/quest-functions ",
	"Знания - для ботаников. Вместо ОХ-эвента мы решили провести PvP-турнир. "
}

clear_server_timer("notifier_loop")
server_loop_timer("notifier_loop", NOTIFIER__INTERVAL)
````

### notifier.quest
Создайте файл с именем `notifier.quest`, задайте ему кодировку ANSI или Windows-1251 (также известна как cp1251) и поместите туда код: 

````lua
quest notifier begin
	state start begin
		when notifier_loop.server_timer begin
			local msg_count = table.getn(NOTIFIER__MESSAGES)
			local random_msg_id = number(1, msg_count)
			local msg_text = NOTIFIER__MESSAGES[random_msg_id]
		
			notice_all(msg_text)
		end
	end
end
````

### quest_list
Добавьте в конец файла `quest_list` (без расширения) следующие квесты:

````
notifier.quest
````

## Конфигурация квеста
Константа **NOTIFIER__INTERVAL** содержит в себе частоту появления уведомлений в секундах.<br>
Константа **NOTIFIER__MESSAGES** содержит в себе таблицу возможных сообщений.