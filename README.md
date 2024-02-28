# DirectoryCleaner

DirectoryCleaner is a batch script that deletes all files in a specified directory and its subdirectories, then recreates them as empty files.

## Usage

1. Run the script. You will be prompted to enter the directory you want to clear.
2. Enter the directory path or type 'help' for more information.

The script will then delete all files in the specified directory and its subdirectories. After that, it will recreate each file as an empty file.

Please note that this script will only recreate files, not directories. Also, the recreated files will be empty - any data they contained will be lost. Be sure to back up any important data before running this script.



## Help

If you need help while running the script, type 'help' when prompted to enter a directory. The script will display a help message with more information about what it does and how to find directories.

# Finding a Directory

To find the directory location of a file, right-click the file, select 'Properties', and look for 'Location'.

## Notes

* I've added a failsafe to protect Windows system32 directory.
* Added confirmation message which includes the users input directory to confirm prior to deletion.
* Errorhandling added to detect non-existent/improperly input directory paths.
*Included a 'help' feature which will give a brief description of the functions of this script as well as how to obtain directories.
