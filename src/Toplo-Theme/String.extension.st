Extension { #name : #String }

{ #category : #'*Toplo-Theme' }
String >> asToTag [ 

	^ ToStyleTagSelector new styleTag: self asSymbol
]
