include Makefile.platform
include Makefile.ndll

PROJECT=openssl

ifeq ($(PLATFORM),Windows)
	OPENSSLPATH=D:\MyProg\_tools\OpenSSL
	CCFLAGS+= -I $(NEKOPATH)\include -I $(OPENSSLPATH)\include
	LDFLAGS+= -L$(NEKOPATH) -L$(OPENSSLPATH)
	LDFLAGS+= -leay32
else
	LDFLAGS+= -lcrypto
endif
