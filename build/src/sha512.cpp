#include <string.h>
#include <cstdio>
#include <openssl/sha.h>
#include <neko.h>

static value openssl_sha512( value v ) {

	unsigned char digest[SHA512_DIGEST_LENGTH];
	char* s = (char*)val_string(v);
 
	SHA512_CTX ctx;
	SHA512_Init( &ctx );
	SHA512_Update( &ctx, s, strlen(s) );
	SHA512_Final( digest, &ctx );
 
	char md[SHA512_DIGEST_LENGTH*2+1];
	for( int i = 0; i < SHA512_DIGEST_LENGTH; i++ )
		sprintf( &md[i*2], "%02x", (unsigned int)digest[i] );

	return alloc_string( md );
}

DEFINE_PRIM( openssl_sha512, 1 );
