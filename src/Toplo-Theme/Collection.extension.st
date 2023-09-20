Extension { #name : #Collection }

{ #category : #'*Toplo-Theme' }
Collection >> asStyleSelector [

	^ ToStyleTagSelector new styleTags: (self collect: [ :e | e asSymbol ])
]
