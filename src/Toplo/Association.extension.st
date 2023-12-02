Extension { #name : 'Association' }

{ #category : '*Toplo' }
Association >> asStampProperty [

	^ ToStampProperty new name: self key asSymbol; value: self value; yourself
]

{ #category : '*Toplo' }
Association >> asTokenProperty [

	^ ToTokenProperty new name: self key asSymbol; value: self value; yourself
]
