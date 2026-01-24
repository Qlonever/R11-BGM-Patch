# Remember11 BGM PATCH Ver. 1.0
This is a patch that fixes a few BGM issues in the Windows version of Remember11 -the age of infinity- :
- Several tracks have swapped or poorly-made loop data
- A wind sound effect was erroneously replaced

This is done through xdelta patching, which can be applied somewhat automatically.

## Installation Steps

### Gestalt Edition Notice
Version 1.3.0 of Gestalt Edition now includes this patch. If you have Gestalt Edition 1.3.0 or later installed, you shouldn't need this.

### Automatic Install
1. From the FILE directory in your installation of Remember11, drag bgmpc.afs onto the PATCHER.bat included here. (If you'd rather use the command line, you can run PATCHER.bat with the path to bgmpc.afs as an argument.)
2. Press Y to back up the original files if you want to.
 
When installing this way, be sure not to remove PATCHER.bat from its folder, or else it won't work. Also, be aware that the script needs ~800MB of free disk space while it runs, and backups of both BGM files will take up that much space.

### Manual Install:

1. Run the xdelta3 executable via the command line:
xdelta3 -d -s [bgmpc.afs path] [patch.xdelta path] [patched file destination path]
2. Rename/delete bgmpc.afs and bgmpc-en.afs, then replace them with the patched file. The same file is used for both.
