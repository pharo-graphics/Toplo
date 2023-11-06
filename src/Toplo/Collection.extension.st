Extension { #name : 'Collection' }

{ #category : '*Toplo' }
Collection >> asElementSelector [

	^ ToStampSelector new addAllStampNames: (self collect: [ :e | e asSymbol ])
]
