# Scripts and utils: a few tools to make your life easier. 
Sometimes, programming gets pretty repetitive. Here are some of the scripts I wrote while studying at 42 to streamline some processes. Enjoy !

# Scripts

## create_class

Automates the creation of a basic C++ project structure, including 'headers' and 'src' directories, and generates .hpp and .cpp files for class names given as arguments. 

It is meant to be aliased and used directly in your directory (see [aliasing](#creating-an-alias-in-zshrc)). Keep in mind that aliasing needs to be done in your shell configuration file - for me it was zsh, but maybe you're using bash or something else.

### Features

- Creates 'headers' and 'src' directories if they don't exist
- Generates .hpp and .cpp files for each provided class name
- Ensures class names start with an uppercase letter
- Prevents overwriting existing files

### Usage

1. Make the script executable:

```bash
	chmod +x script_name.sh
```
2. Run the script with class names as arguments:

```bash
	bash ./create_class ClassName1 ClassName2 ClassName3
```

### Behavior

- If 'headers' or 'src' directories already exist, the script will notify you.
- For each provided class name:
	- If files already exist, it will notify you.
	- If the class name doesn't start with an uppercase letter, it will show an error.
	- Otherwise, it creates both .hpp and .cpp files in their respective directories.

### Error Handling

- Displays an error if no arguments are provided.
- Notifies if directories or files already exist.
- Warns if a class name doesn't start with an uppercase letter.

### Creating an alias in .zshrc

To create an alias for this script in your .zshrc file:

1. Open your .zshrc file (usually at the root of your session (`~/`)):

```bash
	vim ~/.zshrc
```

2. Add the following line (replace `/path/to/script.sh` with the actual path):
> you can make the alias name anything you want
```bash
	alias cclass='bash ~/path/to/create_class'
```

3. Save the file and exit the editor.

4. Reload your .zshrc file:

```bash
source ~/.zshrc
```
Now you can use the alias to run the script from anywhere!
