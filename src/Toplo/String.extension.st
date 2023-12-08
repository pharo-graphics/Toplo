Extension { #name : 'String' }

{ #category : '*Toplo' }
String >> asStampProperty [

	^ ToStampProperty new
		  name: self asSymbol;
		  value: true;
		  yourself
]

{ #category : '*Toplo' }
String >> asStampSelector [ 

	^ ToStampSelector new addStamp: self asSymbol
]

{ #category : '*Toplo' }
String >> asTokenProperty [

	^ ToTokenProperty new
		  name: self asSymbol;
		  value: true;
		  yourself
]
