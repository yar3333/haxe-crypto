#include <stdio.h>
#include <stdlib.h>
#include <openssl/md5.h>
#include <neko.h>

static value crypto_md5(value v)
{
	const char * s = val_string(v);

	int len = val_strlen(v);
	MD5_CTX c;

	unsigned char digest[MD5_DIGEST_LENGTH];
	char *out = (char*)malloc(33);

	MD5_Init(&c);
	while (len > 0)
	{
		if (len > 512)
		{
			MD5_Update(&c, s, 512);
		}
		else
		{
			MD5_Update(&c, s, len);
		}
		len -= 512;
		s += 512;
	}
	MD5_Final(digest, &c);

	for (int n=0; n<16; n++)
		snprintf(&(out[n * 2]), 16 * 2, "%02x", (unsigned int)digest[n]);
	
	return alloc_string( out );
}
DEFINE_PRIM(crypto_md5, 1);
