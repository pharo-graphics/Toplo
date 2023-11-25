Extension { #name : 'Collection' }

{ #category : '*Toplo' }
Collection >> asElementSelector [

	^ ToStampSelector new addAllStamps: (self collect: [ :e | e asSymbol ])
]
