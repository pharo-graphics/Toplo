Trait {
	#name : #TToListNode,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #initialization }
TToListNode >> autoDistribute: aBoolean [

	aBoolean
		ifTrue: [
			self constraintsDo: [ :c |
				self holder listElement isHorizontal
					ifTrue: [ c horizontal matchParent ]
					ifFalse: [ c vertical matchParent ] ] ]
		ifFalse: [ "self setInitialConfiguration" ]
]

{ #category : #'t - list node' }
TToListNode >> endWidthGap [

	^ 0
]

{ #category : #'t - list node' }
TToListNode >> isFullyVisible [

	| bnds list |
	list := self holder listElement.
	bnds := (self measuredBounds inParent: list innerContainer) asRectangle.
	^ self nodeContainerIntersection = bnds
]

{ #category : #'t - list node' }
TToListNode >> isPartlyVisible [

	^ self nodeContainerIntersection
		  ifNotNil: [ :i | i isZero not ]
		  ifNil: [ false ]
]

{ #category : #'t - list node' }
TToListNode >> nodeContainerIntersection [

	| intersection bnds pbnds list |
	self measuredWidth isZero ifTrue: [ ^ nil ].
	list := self holder listElement.
	bnds := (self measuredBounds inParent: list innerContainer) asRectangle.
	pbnds := list innerContainer measuredBounds asRectangle.
	pbnds := pbnds withRight: pbnds right - self endWidthGap.
	intersection := bnds intersect: pbnds.
	^ intersection 
]
