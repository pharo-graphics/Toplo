Extension { #name : 'Association' }

{ #category : '*Toplo' }
Association >> asStyleStamp [

	^ ToReadOnlyStyleStamp new name: self key asSymbol; value: self value; yourself
]
