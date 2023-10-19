Extension { #name : 'String' }

{ #category : '*Toplo' }
String >> asStyleStamp [

	^ ToStyleStamp new
		  name: self asSymbol;
		  value: true;
		  yourself
]
