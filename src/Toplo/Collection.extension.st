Extension { #name : #Collection }

{ #category : #'*Toplo' }
Collection >> asStampSelector [

	^ ToStampSelector new addAllStamps: (self collect: [ :e | e asSymbol ])
]
