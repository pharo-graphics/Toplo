Extension { #name : #String }

{ #category : #'*Toplo-Theme' }
String >> asStyleSelector [ 

	^ ToStyleTagSelector new styleTag: self asSymbol
]

{ #category : #'*Toplo-Theme' }
String >> asStyleTag [

	^ self asSymbol asStyleTag
]
