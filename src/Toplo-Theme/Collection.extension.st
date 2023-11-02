Extension { #name : #Collection }

{ #category : #'*Toplo-Theme' }
Collection >> asElementSelector [

	^ ToStampSelector new addAllStampNames: (self collect: [ :e | e asSymbol ])
]
