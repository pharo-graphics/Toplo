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

	| bnds list intersection |
	list := self holder listElement.
	bnds := (self measuredBounds inSpace) asRectangle.
	intersection := self nodeAndInnerElementIntersection.
	^ intersection = bnds
]

{ #category : #'t - bar node' }
TToBarNode >> isPartlyVisible [

	^ self nodeAndInnerElementIntersection
		  ifNotNil: [ :i | i isZero not ]
		  ifNil: [ false ]
]

{ #category : #'t - bar node' }
TToBarNode >> nodeAndInnerElementIntersection [

	| intersection bnds pbnds list |
	self measuredWidth isZero ifTrue: [ ^ nil ].
	list := self holder listElement.
	bnds := (self measuredBounds inSpace) bounds asRectangle.
	pbnds := list innerElement bounds inSpace bounds asRectangle.
	intersection := bnds intersect: pbnds.
	^ intersection 
]
