Extension { #name : 'String' }

{ #category : '*Toplo' }
String >> asElementSelector [ 

	^ ToStampSelector new addStamp: self asSymbol
]

{ #category : '*Toplo' }
String >> asStampProperty [

	^ ToStampProperty new
		  name: self asSymbol;
		  value: true;
		  yourself
]

{ #category : '*Toplo' }
String >> asTokenProperty [

	^ ToTokenProperty new
		  name: self asSymbol;
		  value: true;
		  yourself
]
