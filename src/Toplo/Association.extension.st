Extension { #name : 'Association' }

{ #category : '*Toplo' }
Association >> asStyleStamp [

	^ ToStyleStamp new name: self key asSymbol; value: self value; yourself
]
