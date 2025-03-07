Trait {
	#name : #TToBarNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - bar node' }
TToBarNode >> isFake [

	^ self holder listElement fakeNode = self
]

{ #category : #'t - bar node' }
TToBarNode >> isFullyVisibleInInnerElement [

	| bnds list intersection |
	list := self holder listElement.
	bnds := (self measuredBounds inSpace) asRectangle.
	intersection := self nodeAndListElementIntersection.
	^ intersection = bnds
]

{ #category : #'t - bar node' }
TToBarNode >> isPartlyVisible [

	^ self nodeAndListElementIntersection
		  ifNotNil: [ :i | i isZero not ]
		  ifNil: [ false ]
]

{ #category : #'t - bar node' }
TToBarNode >> listElementReferenceBoundsInSpace [

	|  list |
	list := self holder listElement.
	^ list innerElement bounds inSpace
]

{ #category : #'t - bar node' }
TToBarNode >> nodeAndListElementIntersection [

	| intersection bnds pbnds list |
	list := self holder listElement.
	bnds := self measuredBounds inSpace bounds asRectangle.
	pbnds := self listElementReferenceBoundsInSpace asRectangle.
	intersection := bnds intersect: pbnds.
	^ intersection
]
