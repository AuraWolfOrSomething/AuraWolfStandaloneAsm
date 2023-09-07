
# Aura Wolf's Standalone Assembly
This repository was created to distributing LLF's assembly in a more user friendly way. I started this particular project with the SkillSystem available on August 10th, 2023, so there may be some adjustments because of this new base (for comparison, the SkillSystem LLF used was probably from around May 2020).

## Installation
Installers are directly named after the assembly/folder itself Therefore, to install a hack, you will need to have "#include [FolderName]/[FolderName].event" somewhere in your buildfile. For example, if you are using SkillSystem, you could put the downloaded assembly in EngineHacks and then edit _MasterHackInstaller.event to have that line.

## Navigation
Assembly hacks' files and subfolders should follow the listed conventions below (both in naming and functionality).

## Files
- [FolderName].event: To install the assembly, include this file. This file may also have instructions on how to use it or have data to adjust, such as a list or table.
- [FolderName]Defs.s: This file is the definitions file for all of the included assembly source code.
- [FolderName]Text.event: This file contains any new text to be inserted. If "#define USE_[FOLDERNAME]_TEXT" is uncommented, it will use the SetText and String macros to add new text entries. There are also commented entries you can directly put in text_buildfile or wherever you want to install the text (just make sure to comment the defintion mentioned above).

## Subfolders
- asm: This folder has the assembly source code [and also a spare .bat for .lyn.events files :) ]. IThere may be more than one asm subfolder to group certain files together.
- [DifferentFolderName]: In order for the assembly to work, edits to either other engine hacks or important functions may be required. In this folder, you can find versions of those that are compatible with/enable this assembly.
