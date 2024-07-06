## Introduction to Makefile

#### - What is Make?

- its build automation tool we can install it using " sudo apt-get install make " 

#### How Make works?

- By parsing input file named ' Makefile ' which contains instructions (Rules) for ' Make ' on how to compile and link the program


---

## Basic Syntax and Structure

A Makefile consists of rules. Each rule has three parts:

1. Target: the file to be generated.
2. Prerequisites: the files that are used as input to create the target.
3. Recipe: the shell commands used to create the target.

```
target: prerequisites
[<Tab>] recipe
```

### Example

```makefile
add.o: add.c
	gcc -c add.c

main.o: main.c
	gcc -c main.c

a.out: main.o add.o
	gcc main.o add.o 
	
```



---



## Phony Targets

A phony target is one that is not really the name of a file; rather, it is just a name for a recipe to be executed when you make an explicit request.

### Example

```makefile
main.o: main.c 
	gcc -c main.c

add.o: add.c
	gcc -c add.c
	
main.elf: main.o add.o
	gcc main.o add.o -o main.elf 
	
.PHONY: clean
clean:
	@rm main.o main.elf add.o
	@echo "Cleaned Successfully!"
```



---



## Variables in Makefile

Variables are used to store values that can be reused throughout the Makefile.

- **Case Sensitivity**: Variable names are case-sensitive (e.g., `var` and `VAR` are different).
- **No Whitespace**: Avoid spaces within variable names.
- **Naming Conventions**:
  - Use uppercase for constants or config parameters (e.g., `SRC_DIR`).
  - Use lowercase or mixed case for dynamic or less critical variables (e.g., `srcs`).
- **Avoid Reserved Words**: Don’t use names that might clash with built-in functions or rules.



### Variable References

Variable references are used to access the value of a variable. They are denoted by \`$(VAR)\` 

## Example

```makefile
program=iti.elf
main.o: main.c
	gcc -c main.c

add.o: add.c 
	gcc -c add.c 

$(program): main.o add.o
	gcc add.o main.o -o $(program)

.PHONY: clean
clean:
	@rm main.o main.elf add.o
	@echo "Cleaned Successfully!"
```

### Substitution References

Substitution references in Makefiles allow you to modify variable values based on patterns or suffixes.

### Syntax:

- `$(var:pattern=replacement)`: Replace matches of `pattern` with `replacement` in `var`.
- `$(var:suffix=replacement)`: Replace suffix `suffix` with `replacement` in `var`.

### Example

```makefile
OBJ = main.o file1.o file2.o
SRC = $(OBJ:.o=.c)

all:
	@echo "OBJ: $(OBJ)"
	@echo "SRC: $(SRC)"
```



---



## Automatic Variables

Automatic variables are special variables that are set by Make for each rule.

- \`$@\`: The file name of the target.
- \`$<\`: The name of the first prerequisite.
- \`$^\`: The names of all the prerequisites.

### Example

```makefile
program: file1.o file2.o
    gcc $^ -o $@
```



---



## Pattern Rule Explanation

A pattern rule in Makefiles is a rule that can be used to build files based on their names or types without explicitly specifying each dependency. It allows you to define a generic recipe for building a target based on a pattern of filenames.

### Before Using Pattern Rule:

Before using a pattern rule, you might have explicit rules for each target, like this:

```makefile
main.o: main.c
    $(CC) -c main.c -o main.o

add.o: add.c
    $(CC) -c add.c -o add.o

program: main.o add.o
    $(CC) main.o add.o -o program
```

In this example:

- `main.o` and `add.o` are compiled from `main.c` and `add.c` respectively using explicit rules.
- `program` is linked from `main.o` and `add.o` to create the final executable.

### After Using Pattern Rule:

After applying a pattern rule, you can generalize the compilation process using a single rule that matches multiple targets and their corresponding source files:

```makefile
%.o: %.c
    $(CC) -c $< -o $@

program: main.o add.o
    $(CC) main.o add.o -o program
```

In this revised example:

- `%.o: %.c` is a pattern rule that matches any `.o` file to be built from its corresponding `.c` file.
- `$(CC) -c $< -o $@` is the recipe for compiling a `.c` file (`$<`) into a `.o` file (`$@`).

### Explanation:

- **Pattern Rule (`%.o: %.c`)**: This rule states that any `.o` file can be built from a `.c` file using the specified recipe.
- **Recipe (`$(CC) -c $< -o $@`)**:
  - `$(CC)`: The variable `CC` holds the C compiler command.
  - `-c $<`: `-c` option tells the compiler to produce an object file from the source file (`$<` represents the prerequisite, i.e., the source file).
  - `-o $@`: `-o` option specifies the output file (`$@` represents the target, i.e., the object file).
- **Usage in `program` Target**:
  - `program` depends on `main.o` and `add.o`.
  - The recipe for `program` links `main.o` and `add.o` into the executable `program`.

### Benefits:

- **Simplicity**: Instead of writing separate rules for each object file, a single pattern rule handles all `.o` files.
- **Flexibility**: If you add more `.c` files, the pattern rule automatically applies to them without needing additional rules.

Using pattern rules in Makefiles reduces redundancy and makes your build process more maintainable and scalable as your project grows with additional source files.

---
