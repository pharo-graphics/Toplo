Extension { #name : #Collection }

{ #category : #'*Toplo-Theme' }
Collection >> asToTag [

	^ ToStyleTagSelector new styleTags: (self asArray collect: [ :e | e asSymbol ])
]
