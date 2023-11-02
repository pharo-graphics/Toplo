Extension { #name : 'String' }

{ #category : '*Toplo-Theme' }
String >> asElementSelector [ 

	^ ToStampSelector new addStampName: self asSymbol
]
