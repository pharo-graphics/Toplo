Extension { #name : #Association }

{ #category : #'*Toplo-Theme' }
Association >> asStyleStamp [

	^ ToStyleStamp new name: self key asSymbol; value: self value; yourself
]
