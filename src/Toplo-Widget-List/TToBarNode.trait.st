Trait {
	#name : #TToBarNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - bar node' }
TToBarNode >> isFake [

	^ self holder listElement fakeNode = self
]

{ #category : #'t - bar node' }
TToBarNode >> isFullyVisible [

	| bnds list |
	list := self holder listElement.
	bnds := (self measuredBounds inParent: list innerElement) asRectangle.
	^ self nodeContainerIntersection = bnds
]

{ #category : #'t - bar node' }
TToBarNode >> isPartlyVisible [

	^ self nodeContainerIntersection
		  ifNotNil: [ :i | i isZero not ]
		  ifNil: [ false ]
]

{ #category : #'t - bar node' }
TToBarNode >> nodeContainerIntersection [

	| intersection bnds pbnds list |
	self measuredWidth isZero ifTrue: [ ^ nil ].
	list := self holder listElement.
	bnds := (self measuredBounds inParent: list innerElement) asRectangle.
	pbnds := list innerElement measuredBounds asRectangle.
	pbnds := pbnds withRight: pbnds right.
	intersection := bnds intersect: pbnds.
	^ intersection 
]
