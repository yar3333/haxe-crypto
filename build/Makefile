include Makefile.platform
include Makefile.ndll

PROJECT=openssl

ifeq ($(PLATFORM),Windows)
	OPENSSLPATH=D:\MyProg\_tools\OpenSSL
	CCFLAGS+= -I $(NEKOPATH)\include -I $(OPENSSLPATH)\include
	LDFLAGS+= -L$(NEKOPATH) -L$(OPENSSLPATH)\lib\MinGW
	LDFLAGS+= $(OPENSSLPATH)\lib\MinGW\libeay32.a
else
	LDFLAGS+= -lcrypto
endif
