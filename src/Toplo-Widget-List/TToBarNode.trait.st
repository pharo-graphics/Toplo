Trait {
	#name : #TToBarNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #'t - bar node' }
TToBarNode >> autoDistribute: aBoolean [

	aBoolean ifTrue: [
		self isHorizontal
			ifTrue: [ self hMatchParent ]
			ifFalse: [ self vMatchParent ] ]
]

{ #category : #'t - bar node' }
TToBarNode >> endWidthGap [

	^ 0
]

{ #category : #'t - bar node' }
TToBarNode >> isFake [

	^ self holder listElement fakeNode = self
]

{ #category : #'t - bar node' }
TToBarNode >> isFullyVisible [

	| bnds list |
	list := self holder listElement.
	bnds := (self measuredBounds inParent: list innerContainer) asRectangle.
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
	bnds := (self measuredBounds inParent: list innerContainer) asRectangle.
	pbnds := list innerContainer measuredBounds asRectangle.
	pbnds := pbnds withRight: pbnds right - self endWidthGap.
	intersection := bnds intersect: pbnds.
	^ intersection 
]
