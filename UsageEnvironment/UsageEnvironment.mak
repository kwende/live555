INCLUDES = -Iinclude -I../groupsock/include
PREFIX = /usr/local
LIBDIR = $(PREFIX)/lib
##### Change the following for your environment:
NODEBUG=1
TARGETOS = WINNT

UI_OPTS =       $(guilflags) $(guilibsdll)
CONSOLE_UI_OPTS =   $(conlflags) $(conlibsdll)
CPU=amd64

COMPILE_OPTS =      $(INCLUDES) $(cdebug) $(cflags) $(cvarsdll) -I. /EHsc /O2 /MD /GS /D "WIN64" /Oy- /Oi /D "NDEBUG"
C =         c
C_COMPILER =        cl
C_FLAGS =       $(COMPILE_OPTS)
CPP =           cpp
CPLUSPLUS_COMPILER =    $(C_COMPILER)
CPLUSPLUS_FLAGS =   $(COMPILE_OPTS)
OBJ =           obj
LINK =              link -out:
LIBRARY_LINK =      lib -out:
LINK_OPTS_0 =       $(linkdebug) ws2_32.lib /NXCOMPAT
LIBRARY_LINK_OPTS = 
LINK_OPTS =     $(LINK_OPTS_0) $(UI_OPTS)
CONSOLE_LINK_OPTS = $(LINK_OPTS_0) $(CONSOLE_UI_OPTS)
SERVICE_LINK_OPTS =     kernel32.lib advapi32.lib shell32.lib ws2_32.lib -subsystem:console,$(APPVER)
LIB_SUFFIX =        lib
LIBS_FOR_CONSOLE_APPLICATION =
LIBS_FOR_GUI_APPLICATION =
MULTIMEDIA_LIBS =   winmm.lib
EXE =           .exe
PLATFORM = Windows##### End of variables to change

NAME = libUsageEnvironment
USAGE_ENVIRONMENT_LIB = $(NAME).$(LIB_SUFFIX)
ALL = $(USAGE_ENVIRONMENT_LIB)
all:	$(ALL)

OBJS = UsageEnvironment.$(OBJ) HashTable.$(OBJ) strDup.$(OBJ)

$(USAGE_ENVIRONMENT_LIB): $(OBJS)
	$(LIBRARY_LINK)$@ $(LIBRARY_LINK_OPTS) $(OBJS)

.$(C).$(OBJ):
	$(C_COMPILER) -c $(C_FLAGS) $<       

.$(CPP).$(OBJ):
	$(CPLUSPLUS_COMPILER) -c $(CPLUSPLUS_FLAGS) $<

UsageEnvironment.$(CPP):	include/UsageEnvironment.hh
include/UsageEnvironment.hh:	include/UsageEnvironment_version.hh include/Boolean.hh include/strDup.hh
HashTable.$(CPP):		include/HashTable.hh
include/HashTable.hh:		include/Boolean.hh
strDup.$(CPP):			include/strDup.hh

clean:
	-rm -rf *.$(OBJ) $(ALL) core *.core *~ include/*~

install: install1 $(INSTALL2)
install1: $(USAGE_ENVIRONMENT_LIB)
	  install -d $(DESTDIR)$(PREFIX)/include/UsageEnvironment $(DESTDIR)$(LIBDIR)
	  install -m 644 include/*.hh $(DESTDIR)$(PREFIX)/include/UsageEnvironment
	  install -m 644 $(USAGE_ENVIRONMENT_LIB) $(DESTDIR)$(LIBDIR)
install_shared_libraries: $(USAGE_ENVIRONMENT_LIB)
	  ln -fs $(NAME).$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/$(NAME).$(SHORT_LIB_SUFFIX)
	  ln -fs $(NAME).$(LIB_SUFFIX) $(DESTDIR)$(LIBDIR)/$(NAME).so

##### Any additional, platform-specific rules come here:
