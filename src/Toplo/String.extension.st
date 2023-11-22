Extension { #name : 'String' }

{ #category : '*Toplo' }
String >> asElementSelector [ 

	^ ToStampSelector new addStampName: self asSymbol
]

{ #category : '*Toplo' }
String >> asStyleStamp [

	^ ToReadOnlyStyleStamp new
		  name: self asSymbol;
		  value: true;
		  yourself
]
