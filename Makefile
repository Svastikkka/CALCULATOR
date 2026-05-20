# Compiler
CC = gcc

# Compiler Flags
CFLAGS = -Wall -Wextra

# Math Library
LIBS = -lm

# Source File
SRC = src/main.c

# Output Binary
TARGET = calculator

# Default Target
all: build

# Build Binary
build:
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET) $(LIBS)

# Run Binary
run: build
	./$(TARGET)

# Remove Binary
clean:
	rm -f $(TARGET)