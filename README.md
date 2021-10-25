# test-db
Проект создан с помощью _**Node JS, Express, create-react-app, MySQL**_.

Для запуска проекта необходима установка MySQL, Node JS.
После установки данных программ необходимо: 
- создать базу данных из файла server/database.sql c помощью импорта в программе MySQL Workbench;
- клонировать репозиторий;
- в файле server/server.js строки 7-12, указать пользователя и пароль, а также актуальное название БД(поля user, password, database);
- открыть командную строку в папке данного проекта 
и выполнить команды _**`npm install`**_, затем _**`npm run all`**_ ;
- на http://localhost:3001 запустится сервер с данными;
- затем откроется страница клиента http://localhost:3000;
---
В случае ошибки `Unhandled Rejection (TypeError): storeList.map is not a function` при отображении клиента(http://localhost:3000) выполнить в MySQL Workbench следующие команды, где $user - имя пользователя, $password - пароль: 
- `SET GLOBAL time_zone = '-3:00';`
- `ALTER USER '$user'@'localhost' IDENTIFIED WITH mysql_native_password BY '$password';`

---
На странице клиента(http://localhost:3000) для получения данных следует ввести дату начала и дату окончания периода.

В отчете о движении заданного товара по складам следует ввести название товара из таблицы БД `product`.