# Multiverse OS: Minimal Bourne Shell Framework
===============================================================================
The primary reason to use bourne `sh` framework is used for Multiverse OS shell
scripting, and recommended to the user, is because it centralized the
security related responsbilities in shell scripts, implements thorough tests
written for each security related (not completed yet) function.

And all the auxillary logic beyond those security functions and other basic
helpers such as OS, validation, and other common utility functions are
implemented as small modules.

#### Minimal Code Footprint Using Modular Design
The modular design of `sh` framework ensures that the source code footprint
of the framework is as little as possible, and in general, very very small.
This is accomplished by putting most of the logic in small modules that
can be added individually, or piecemal, or altogether. These modules 
call the primary framework code `sh-framework.sh`, the file containing 
the important security functionality, the file that tests are primarily
written to test, and provide the common utilties used by the various
modules. 

The minimal resource usage of the `sh-framework` enables it to work
well as a drop in library for rapidly developing simple scripts for minor
tasks or one-offs, or simple commands and macros that simplify common
tasks while providing UI that matches the Multiverse color scheme, 
and design patterns, or featureful software and prototyping complex
software. 

#### Centralizing Critical Security Related Logic
By centralizing the important security logic of shell scripting, and
providing reliable tests to ensure these feature are working, even
after updates, customizations, in addition to preventing any breaking
changes from being merged into production code. Enabling users of
`sh-framework` to delegate more difficult security decisions to
both the Multiverse OS developers and the community using the framework,
leaving only the portions of your source code that is unique to your
project, making development not just more secure, but also faster,
easier to learn, and provide UI and functional consistency between
different shell scripts developed by different members of the community.

The important security logic provided by Multiverse OS, will continue
to be developed as a component of Multiverse, receive security updates,
have additional security features requested by the community or
required by Multiverse OS developers. Currently the features are:
  1) Validations for basic types: strings, numbers, arrays, filepaths, and
     more... 

  2) User input functions, to securely take in user input and validate 
     the input before using it, beacuse all input should be validated 
     even if the user is assumed to be trusted.

     This is how we conform to the security in depth philosphy required
     by the Multiverse OS design specification, which defines not just
     the software, and protocols, but also any software included in the
     Multiverse OS operating system.)  

  3) Tests that ensure any changes to the shell framework do not break
     existing logic, to avoid any breaking changes from being merged 
     into the production branch and released.

     Bash script developers rarely  implement tests. And by centralizing
     security related logic into the framework, and writing tests we believe
     reliably and reasonably test the security logic.

#### Framework both Multiverse developmers and Users
One important reason why we implemented our own shell framework for 
Multiverse OS and the users, is not just simply to satisfy our specific
prototyping requirements during development, but also to encourage
users to develop shell scripts to simplify their computing tasks.

As Multiverse project itself evovles, we want to faciliate P2P nucleatnig
points for the Multiverse community and various subcommunities; in a 
variety of ways. One way we plan to faciliate community participation
in ways that we have seen succeed in the past, such as community developed
modifications, as seen in video game communities. Constantly improving
a growing number of tools, guides, and features of the operating system
intended to not only encourage the development of shareable customizations,
provide a way for the community to indicate what they like, in a more
nuanced way than a simple up/down vote or 1-5 stars.


-------------------------------------------------------------------------------
## Shell Framework: Installation And Use
Enabling Multiverse developers to provide assurance that using this shell
library that will be included by default in Multiverse OS, easily
accessible to users and developers by importing via the use of an
environmental variable (aka ENV; from shell a list can be viewed by using
the `env` command). 

```
SH_FRAMEWORK="/home/user/.local/share/sh/framework"
```

*For Multiverse OS users this environmental variable is set by default.*


#### Installing the framework
However, if you do not yet have the library, or are not using Multiverse OS.
Pull the git repository to an accessible location and set the above environmental
variable, which will massively simplify importing the framework into shell
scripts. 

```
# IF you are not using Multiverse:
sudo su && cd ~/.local/share/ && git clone https://github.com/multiverse-os/sh-framework sh
echo "export SH_FRAMEWORK="~/.local/share/sh/framework.sh" >> ~/.bashrc && source ~/.bashrc
```


#### Using The Framework
If you are using Multiverse OS, using the framework is very 
easy, because it is already installed and the environmental
variable is already set. So you can skip to this step:

Create a shell script and put some code in it:

```
#!/bin/sh
sh_import $SH_FRAMEWORK

echo "hello world"
```

And that is it, you are ready to start using the shell framework functions and 
rapidly developing great shell scripts.

 

#### How this works: Background details
The environmental variable we are setting is the primary shell script file, 
it is also imported by all the modules. If you want a module you import it
individually. 

By default instead of `sh_import` which we prefer because it is more intuitive
and human readable is an alias of the `source`. We used the `source` command to
reload the `~/.bashrc`. 

In Debian by default, source has a default alias, similar to the default alias
provided by Multiverse OS, this alias is `.`. This allows a developer to
use the following shorthand during to import the shell framework:

```
#!/bin/sh
. $SH_FRAMEWORK
```

The `sh_import` alias, the variable/function naming in
the source code of the `sh-framework`, in addition to
all the Multiverse OS source code is directly inspired
by Ruby source code philosophy. Multiverse OS inspired
by the simplicity and accessibility of Ruby.


### Supported Operating Systems
Currently this framework is designed around the ability to
build shell scripts that function in both:
  * Debian Linux
  * Alpine Linux

In the future, all major linux operating systems and a variety
of micro/uni-kernels will be supported by both Multiverse OS
and the `sh-framework`. But the alpha release of Multiverse OS
will only guarantee support for the two above operating 
systems. 

**NOTE**_This is '/bin/sh' NOT '/bin/bash'._


### Examples
A folder of examples is included to explicitly show usage examples while providing templates for skeleton scripts that can hasten development of simple Multiverse OS shell scripts.

### Tests
A test script is included, it is simply made executable `chomd +x test.sh` and ran in the root of the project. The output will indicate if the tests failed or passed. 


### Framework Analysis
Since this is only the second attempt at putting together a simple shell framework, it will be worth doing static analysis on the resulting shell scripts to avoid any major mistakes. 

#### Static Analysis Resources
ShellCheck appears to be a good shell script static analysis tool, a few morecould be found and incorporated into the git version control process to avoid majorflaws. 
