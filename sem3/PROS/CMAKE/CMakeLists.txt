cmake_minimum_required(VERSION 3.10)

# Nazwa projektu i określenie języka (C)
project(moj_program C)

# Ustawienie standardu C99
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Dodanie pliku wykonywalnego
add_executable(main a.c)

# Flagi kompilacji
target_compile_options(main PRIVATE -Wall -Wextra)
    
