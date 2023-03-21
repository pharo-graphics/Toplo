Trait {
	#name : #TToElement,
	#category : #'Toplo-Core'
}

{ #category : #'as yet unclassified' }
TToElement >> addedInSelectionDecoration: aSelectionDecoration [

	self dresser element: self addedInInfiniteDecoration: aSelectionDecoration
]

{ #category : #'as yet unclassified' }
TToElement >> removedFromSelectionDecoration: aSelectionDecoration [

	self dresserDo: [ :d | d element: self removedFromInfiniteDecoration: aSelectionDecoration ]
]
