package haxe.crypto;

class Hmac
{
	var hash : IHash;

	public function new(hash:IHash)
	{
		this.hash = hash;
	}

	public function toString() : String
	{
		return "hmac-" + Std.string(hash);
	}

	public function calculate(key:String, msg:String)
	{
		var B = hash.getBlockSizeBytes();
		
		var K : String = key;
		if (K.length > B)
		{
			K = hexDecode(hash.calculate(K));
		}
		K = ByteString.nullPadString(K, B);
		K = K.substr(0, B);
		
		var Ki = new StringBuf();
		var Ko = new StringBuf();
		for (i in 0...K.length)
		{
			Ki.addChar(K.charCodeAt(i) ^ 0x36);
			Ko.addChar(K.charCodeAt(i) ^ 0x5c);
		}
		// hash(Ko + hash(Ki + message))
		Ki.add(msg);
		var p1 = Ki.toString();
		var t1 = hash.calculate(p1);
		var t2 = hexDecode(t1);
		Ko.add(t2);
		return hash.calculate(Ko.toString());
	}
	
	public function hexDecode(hex:String) : String
	{
		var b = new StringBuf();
		var i = 0; while (i < hex.length)
		{
			var n1 = "0123456789abcdef".indexOf(hex.charAt(i));
			var n2 = "0123456789abcdef".indexOf(hex.charAt(i + 1));
			b.addChar((n1 << 4) | n2);
			i += 2;
		}
		return b.toString();
	}
	
	public function hexEncode(s:String) : String
	{
		var r = "";
		for (i in 0...s.length)
		{
			var c = s.charCodeAt(i);
			r += "0123456789abcdef".substr(c >> 4, 1);
			r += "0123456789abcdef".substr(c & 0xF, 1);
		}
		return r;
	}
}
