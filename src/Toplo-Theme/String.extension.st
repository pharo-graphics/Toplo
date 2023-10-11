Extension { #name : #String }

{ #category : #'*Toplo-Theme' }
String >> asStyleSelector [ 

	^ ToStyleStampSelector new addStampName: self asSymbol
]
