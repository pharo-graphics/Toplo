Extension { #name : #String }

{ #category : #'*Toplo-Theme' }
String >> asToStyleSelector [ 

	^ ToStyleTagSelector new styleTag: self asSymbol
]
