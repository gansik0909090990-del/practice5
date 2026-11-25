# Практикум 5. Автоматические тесты и исправление дефекта

**ФИО:** ______________________________  
**Группа:** ____________________________  
**Дата:** ______________________________

## 1. Цель работы

Получить запускаемые автоматические тесты, воспроизвести и исправить дефект, освоить безопасную отмену отдельного изменения с помощью `git revert`.

## 2. Инструменты

- Язык: Python
- Средство тестирования: встроенный модуль `unittest`
- Система контроля версий: Git
- Команда контрольного запуска в среде подготовки: `python -m unittest -v`
- Версия Python при подготовке: `Python 3.13.5`
- Версия Git при подготовке: `git version 2.47.3`

> Примечание: выводы ниже получены фактическим запуском тестов и Git-команд при подготовке этого проекта. Для подтверждения на своём компьютере повторите команды из README.md.

## 3. Тестируемая логика и проверки

Реализована функция `is_adult(age)`, которая определяет совершеннолетие.

Созданы три автоматические проверки:
1. **Основной случай:** `is_adult(25)` возвращает `True`.
2. **Граничный случай:** `is_adult(18)` возвращает `True`.
3. **Ошибочный случай:** `is_adult(-1)` вызывает `ValueError`.

## 4. Дефект и воспроизведение до исправления

В исходной версии использовалось условие `age > 18`. Поэтому человек в возрасте ровно 18 лет ошибочно определялся как несовершеннолетний.

Команда:
```powershell
py -m unittest -v
```

Фактический контрольный вывод (в среде подготовки команда была `python -m unittest -v`):
```text
Spreadsheet runtime warmup failed during python startup
Traceback (most recent call last):
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/patches/warm_spreadsheet_runtime_on_startup.py", line 26, in warm_spreadsheet_runtime_on_startup
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/spreadsheet_warmup.py", line 785, in warm_spreadsheet_runtime
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/spreadsheet_warmup.py", line 718, in _warm_feature_flows
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/spreadsheet_warmup.py", line 509, in _warm_drawing_and_image_flows
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/generated/interface/models.py", line 32861, in bring_to_front
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/rpc/remote.py", line 764, in __call__
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/rpc/client.py", line 175, in call
artifact_tool.rpc.client.RemoteError: Element ordering requires an owning element collection.
test_adult_above_18 (test_age.TestIsAdult.test_adult_above_18)
Основной случай: 25 лет — совершеннолетний. ... ok
test_exactly_18 (test_age.TestIsAdult.test_exactly_18)
Граничный случай: ровно 18 лет — совершеннолетний. ... FAIL
test_negative_age (test_age.TestIsAdult.test_negative_age)
Ошибочный случай: отрицательный возраст вызывает ValueError. ... ok

======================================================================
FAIL: test_exactly_18 (test_age.TestIsAdult.test_exactly_18)
Граничный случай: ровно 18 лет — совершеннолетний.
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/mnt/data/practice5_github_ready/test_age.py", line 12, in test_exactly_18
    self.assertTrue(is_adult(18))
    ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^
AssertionError: False is not true

----------------------------------------------------------------------
Ran 3 tests in 0.001s

FAILED (failures=1)
```

Ожидаемо упал только граничный тест `test_exactly_18`.

## 5. Исправление и результат после исправления

Дефект устранён минимальной заменой:
- было: `return age > 18`
- стало: `return age >= 18`

После исправления выполнена та же команда тестирования.

Фактический контрольный вывод:
```text
Spreadsheet runtime warmup failed during python startup
Traceback (most recent call last):
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/patches/warm_spreadsheet_runtime_on_startup.py", line 26, in warm_spreadsheet_runtime_on_startup
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/spreadsheet_warmup.py", line 785, in warm_spreadsheet_runtime
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/spreadsheet_warmup.py", line 718, in _warm_feature_flows
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/spreadsheet_warmup.py", line 509, in _warm_drawing_and_image_flows
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/generated/interface/models.py", line 32861, in bring_to_front
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/rpc/remote.py", line 764, in __call__
  File "/tmp/tmp.QlpUkOUI9D/artifact_tool_v2-2.8.66/artifact_tool/rpc/client.py", line 175, in call
artifact_tool.rpc.client.RemoteError: Element ordering requires an owning element collection.
test_adult_above_18 (test_age.TestIsAdult.test_adult_above_18)
Основной случай: 25 лет — совершеннолетний. ... ok
test_exactly_18 (test_age.TestIsAdult.test_exactly_18)
Граничный случай: ровно 18 лет — совершеннолетний. ... ok
test_negative_age (test_age.TestIsAdult.test_negative_age)
Ошибочный случай: отрицательный возраст вызывает ValueError. ... ok

----------------------------------------------------------------------
Ran 3 tests in 0.000s

OK
```

Все три теста завершились успешно (`OK`).

## 6. Git: ветка, коммиты и revert

Создана ветка `fix/tested-bug`. В ней сохранены коммит исправления и учебный коммит, который отменён с помощью `git revert`. После этого ветка исправления слита в `main`, поэтому основная ветка содержит готовое решение и всю историю.

- Коммит тестов: `см. git log ниже`
- Хеш отменённого учебного коммита: `81e54fb8425eef6bb8f657ac8460a9c7454b62c2`
- Хеш revert-коммита: `0e482f263bed46786ba3187dd01cb3f2558e0695`

Фактический вывод истории:
```text
* 457cb3a (HEAD -> main) docs: update final verification output
* 19e9bbe docs: add simple GitHub publishing instructions
* 21ae8a7 docs: save final repository verification
* 7c16b02 docs: finalize practical report
* bd79526 docs: record final git history
* 04b6d20 (fix/tested-bug) docs: add test and git evidence
*   d558ae9 merge: integrate tested fix
|\  
| * 0e482f2 Revert "chore: add revert demo"
| * 81e54fb chore: add revert demo
| * 1940d45 fix: handle age 18 boundary
|/  
* 9774692 test: cover core behavior
```

Фактический статус рабочей копии:
```text
## main
```

## 7. Вывод

В ходе практической работы созданы три автоматических теста на `unittest`. Граничный тест обнаружил дефект обработки возраста 18 лет. Дефект исправлен минимальным изменением условия. Отдельное учебное изменение отменено командой `git revert`, при этом история Git сохранена. После исправления и отмены учебного коммита все три теста проходят успешно.
