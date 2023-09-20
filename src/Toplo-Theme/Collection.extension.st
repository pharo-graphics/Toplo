Extension { #name : #Collection }

{ #category : #'*Toplo-Theme' }
Collection >> asToStyleSelector [

	^ ToStyleTagSelector new styleTags: (self collect: [ :e | e asSymbol ])
]
