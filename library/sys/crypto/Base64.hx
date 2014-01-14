package sys.crypto;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

/**
	Encode/Decode base64
*/
class Base64
{
	public static inline function encode( s : String ) : String
	{
		#if cpp
		return _encode( s );
		#elseif neko
		return Lib.nekoToHaxe( _encode( Lib.haxeToNeko(s) ) );
		#elseif php
		return untyped __call__( "base64_encode", s );
		#end
	}
	
	public static inline function decode( s : String ) : String
	{
		#if cpp
		return _decode( s );
		#elseif neko
		return Lib.nekoToHaxe( _decode( Lib.haxeToNeko(s) ) );
		#elseif php
		return untyped __call__( "base64_decode", s );
		#end
	}
	
	#if (cpp||neko)
	private static inline function _encode( s : String ) return Lib.load( "openssl", "openssl_base64_encode", 1 )(s);
	private static inline function _decode( s : String ) return Lib.load( "openssl", "openssl_base64_decode", 1 )(s);
	#end
}
