Extension { #name : #Association }

{ #category : #'*Toplo-Theme' }
Association >> asStyleNamedValue [

	^ ToStyleNamedValue new name: self key asSymbol; value: self value; yourself
]
