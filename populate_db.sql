INSERT INTO CLIENT (NAME) VALUES
('Олександр Голанов'),
('Артем Горбунов'),
('Вікторія Горник'),
('Світлана Зуб'),
('Катерина Кушніренко');

INSERT INTO PROJECT (CLIENT_ID, START_DATE, FINISH_DATE) VALUES
(1, '2023-01-01', '2023-12-01'),
(1, '2023-02-15', '2023-08-15'),
(2, '2023-03-10', '2023-09-10'),
(3, '2023-04-05', '2023-10-05'),
(4, '2023-05-20', '2023-11-20'),
(2, '2023-06-01', '2023-12-01'),
(3, '2023-07-15', '2024-01-15'),
(1, '2023-08-10', '2023-10-10'),
(4, '2023-09-05', '2024-02-05'),
(3, '2023-10-20', '2024-03-20');

INSERT INTO project_worker (PROJECT_ID, WORKER_ID) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(3, 5),
(4, 1),
(4, 2),
(4, 3),
(5, 4),
(6, 5),
(6, 1),
(7, 2),
(7, 3),
(7, 4),
(8, 5),
(8, 1),
(8, 2),
(9, 3),
(9, 4),
(9, 5),
(10, 1),
(10, 2),
(10, 3),
(10, 4),
(10, 5);