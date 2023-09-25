Extension { #name : #Association }

{ #category : #'*Toplo-Theme' }
Association >> asStyleTag [

	^ ToElementTag new name: self key asSymbol; value: self value; yourself
]
