Class {
	#name : #ToBarNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToBarNodeContainer >> applyConfiguration [

	| bar |
	super applyConfiguration.
	bar := self holder listElement.
	bar isFlowable
		ifTrue: [ self fitContent ]
		ifFalse: [
				bar isVertical
					ifTrue: [
							bar isHMatchParent
								ifTrue: [ self hMatchParent ]
								ifFalse: [ self hFitContent ].
							bar autoDistribute
								ifTrue: [ self vMatchParent ]
								ifFalse: [ self vFitContent ] ]
					ifFalse: [
							bar isVMatchParent
								ifTrue: [ self vMatchParent ]
								ifFalse: [ self vFitContent ].
							bar autoDistribute
								ifTrue: [ self hMatchParent ]
								ifFalse: [ self hFitContent ] ] ].
	bar exactNodeWidth ifNotNil: [ :w | self width: w ].
	bar exactNodeHeight ifNotNil: [ :h | self height: h ]
]

{ #category : #testing }
ToBarNodeContainer >> intersectionRectangleWithListElement [

	| intersection bnds pbnds list |
	list := self holder listElement.
	bnds := self measuredBounds inSpace bounds asRectangle.
	pbnds := self listElementReferenceBoundsInSpace asRectangle.
	intersection := bnds intersect: pbnds.
	^ intersection
]

{ #category : #testing }
ToBarNodeContainer >> isFullyVisibleInListElement [

	| bnds  intersection |
	bnds := (self measuredBounds inSpace) asRectangle.
	intersection := self intersectionRectangleWithListElement.
	^ intersection = bnds
]

{ #category : #testing }
ToBarNodeContainer >> isPartlyVisibleInListElement [

	^ self intersectionRectangleWithListElement
		  ifNotNil: [ :i | i isZero not ]
		  ifNil: [ false ]
]

{ #category : #testing }
ToBarNodeContainer >> listElementReferenceBoundsInSpace [

	|  list |
	list := self holder listElement.
	^ list innerElement bounds inSpace
]
