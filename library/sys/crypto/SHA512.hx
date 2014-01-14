package sys.crypto;

#if cpp
import cpp.Lib;
#else
import neko.Lib;
#end

/**
*/
class SHA512
{
	public static inline var DIGEST_LENGTH = 64;
	
	public static inline function encode( s : String ) : String
	{
		#if cpp
		return _sha512( s );
		#elseif neko
		return Lib.nekoToHaxe( _sha512( Lib.haxeToNeko(s) ) );
		#end
	}
	
	static inline function _sha512( s : String ) return Lib.load( "openssl", "openssl_sha512", 1 )(s);
}
