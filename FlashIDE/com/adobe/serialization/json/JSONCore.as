/*
  Copyright (c) 2008, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.adobe.serialization.json
{
	
	/**
	 * This class provides encoding and decoding of the JSONCore format.
	 *
	 * Example usage:
	 * <code>
	 * 		// create a JSONCore string from an internal object
	 * 		JSONCore.encode( myObject );
	 *
	 *		// read a JSONCore string into an internal object
	 *		var myObject:Object = JSONCore.decode( JSONCoreString );
	 *	</code>
	 */
	public final class JSONCore
	{
		/**
		 * Encodes a object into a JSONCore string.
		 *
		 * @param o The object to create a JSONCore string for
		 * @return the JSONCore string representing o
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function encode( o:Object ):String
		{
			return new JSONEncoder(o).getString();
		}
		
		/**
		 * Decodes a JSONCore string into a native object.
		 *
		 * @param s The JSONCore string representing the object
		 * @param strict Flag indicating if the decoder should strictly adhere
		 * 		to the JSONCore standard or not.  The default of <code>true</code>
		 * 		throws errors if the format does not match the JSONCore syntax exactly.
		 * 		Pass <code>false</code> to allow for non-properly-formatted JSONCore
		 * 		strings to be decoded with more leniancy.
		 * @return A native object as specified by s
		 * @throw JSONCoreParseError
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public static function decode( s:String, strict:Boolean = true ):*
		{
			return new JSONDecoder( s, strict ).getValue();
		}
	
	}

}