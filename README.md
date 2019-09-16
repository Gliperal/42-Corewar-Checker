#Corewar Checker

##What is this?

A testing framework for the 42 Corewar project. Debugging corewar can be a cumbersome and infuriating task, especially in cases where the bugs appear several thousand cycles or several thousand processes in (or both). The included tests are designed to provide minimal reproducible examples for many of the common problems.
NB: The tests bundled with this repository are tailored for 42's Corewar. Attempting to use this checker versus the Epitech Corewar may produce incorrect test results at best and undefined behavior at worst.

## How do I use it?

First, make sure that your corewar can work with this checker. There should be a Makefile present in the corewar directory that creates your corewar program. If "make corewar" does not recompile when necessary, you run the risk of testing an older version. Conversely, if "make corewar" will always recompile regardless if anything has changed, then you run the risk of recompiling for every test that is run. Upon successful execution, corewar should return exit status 0. This checker relies heavily on the option to dump the corewar memory at a specified cycle. If your corewar does not have this option, many tests will be unrunnable. The command line syntax, as recommended by the subject and expected by the checker, is
```
corewar [-dump nbr_cycles] [[-n number] champion1.cor] ...
```
If your corewar uses "-d" or "--dump", you may need to manually create the user.info file. If your corewar expects the arguments in a different order (e.g. -dump after the list of champions), the checker will not run at all.

TODO What if my corewar requires extra flags to run properly?

After initially cloning or extracting this checker, first run
	./setup.sh "path/to/corewar/directory"

Setup will need to be run any time the output format of corewar is changed (for instance, adding extra lines after the victory message, changing the dump format, etc.) Setup does **not** need to be run any time the source code is changed. The checker will automatically remake and run using the updated corewar.

To run the entire test suite:
```
/checker.sh
```

To run individual tests:
```
./test.sh [-c dump_cycle] champion_bytecode
```
