Extension { #name : #Collection }

{ #category : #'*Toplo-Theme' }
Collection >> asStyleSelector [

	^ ToStyleStampSelector new addAllStampNames: (self collect: [ :e | e asSymbol ])
]
