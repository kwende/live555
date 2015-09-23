INCLUDES = -I../UsageEnvironment/include -I../groupsock/include -I../liveMedia/include -I../BasicUsageEnvironment/include
# Default library filename suffixes for each library that we link with.  The "config.*" file might redefine these later.
libliveMedia_LIB_SUFFIX = $(LIB_SUFFIX)
libBasicUsageEnvironment_LIB_SUFFIX = $(LIB_SUFFIX)
libUsageEnvironment_LIB_SUFFIX = $(LIB_SUFFIX)
libgroupsock_LIB_SUFFIX = $(LIB_SUFFIX)
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

MEDIA_SERVER = live555MediaServer$(EXE)

PREFIX = /usr/local
ALL = $(MEDIA_SERVER)
all: $(ALL)

.$(C).$(OBJ):
	$(C_COMPILER) -c $(C_FLAGS) $<
.$(CPP).$(OBJ):
	$(CPLUSPLUS_COMPILER) -c $(CPLUSPLUS_FLAGS) $<

MEDIA_SERVER_OBJS = live555MediaServer.$(OBJ) DynamicRTSPServer.$(OBJ)

live555MediaServer.$(CPP):	DynamicRTSPServer.hh version.hh
DynamicRTSPServer.$(CPP):	DynamicRTSPServer.hh

USAGE_ENVIRONMENT_DIR = ../UsageEnvironment
USAGE_ENVIRONMENT_LIB = $(USAGE_ENVIRONMENT_DIR)/libUsageEnvironment.$(libUsageEnvironment_LIB_SUFFIX)
BASIC_USAGE_ENVIRONMENT_DIR = ../BasicUsageEnvironment
BASIC_USAGE_ENVIRONMENT_LIB = $(BASIC_USAGE_ENVIRONMENT_DIR)/libBasicUsageEnvironment.$(libBasicUsageEnvironment_LIB_SUFFIX)
LIVEMEDIA_DIR = ../liveMedia
LIVEMEDIA_LIB = $(LIVEMEDIA_DIR)/libliveMedia.$(libliveMedia_LIB_SUFFIX)
GROUPSOCK_DIR = ../groupsock
GROUPSOCK_LIB = $(GROUPSOCK_DIR)/libgroupsock.$(libgroupsock_LIB_SUFFIX)
LOCAL_LIBS =	$(LIVEMEDIA_LIB) $(GROUPSOCK_LIB) \
		$(BASIC_USAGE_ENVIRONMENT_LIB) $(USAGE_ENVIRONMENT_LIB)
LIBS =			$(LOCAL_LIBS) $(LIBS_FOR_CONSOLE_APPLICATION)

live555MediaServer$(EXE):	$(MEDIA_SERVER_OBJS) $(LOCAL_LIBS)
	$(LINK)$@ $(CONSOLE_LINK_OPTS) $(MEDIA_SERVER_OBJS) $(LIBS)

clean:
	-rm -rf *.$(OBJ) $(ALL) core *.core *~ include/*~

install: $(MEDIA_SERVER)
	  install -d $(DESTDIR)$(PREFIX)/bin
	  install -m 755 $(MEDIA_SERVER) $(DESTDIR)$(PREFIX)/bin

##### Any additional, platform-specific rules come here:
