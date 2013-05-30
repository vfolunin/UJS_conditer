%problem%/statement/*.*

%problem%/checker/source.*
%problem%/checker/make.json

%problem%/testgen/source.*
%problem%/testgen/make.json
%problem%/tests/input*.txt
%problem%/tests/pattern*.txt

%problem%/author_make.json
%problem%/judge.json



%workarea%/checker.exe
%workarea%/input*.txt
%workarea%/pattern*.txt
%workarea%/judge.json



Кондитер

1.1 Проверяет компилируемость чекера                    ujs_ci {checker/make.json} {system_make.json} > checker_compile.json
1.2 Компилирует чекер                                   cmd {checker_compile.json} > checker.exe
1.3 Копирует чекер в %workarea%

2.1 Проверяет компилируемость тестгена (если есть)      ujs_ci {testgen/make.json} {system_make.json} > testgen_compile.json
2.2 Компилирует тестген                                 cmd {testgen_compile.json} > testgen.exe
2.3 Генерирует тесты                                    cmd testgen.exe > tests/input*.txt, tests/pattern*.txt

3.1 Копирует тесты в %workarea%

4.1 Копирует judge.json в %workarea%
