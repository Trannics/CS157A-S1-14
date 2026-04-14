CREATE USER IF NOT EXISTS 'taskme_app'@'localhost' IDENTIFIED BY 'taskme123';
GRANT ALL PRIVILEGES ON team14.* TO 'taskme_app'@'localhost';
FLUSH PRIVILEGES;
