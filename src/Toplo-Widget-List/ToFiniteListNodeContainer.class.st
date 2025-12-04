"
I'm a triplet (start, middle, end) and I'm child of an inner for finite list. 
My role is to contain `ToListNode` element.
"
Class {
	#name : #ToFiniteListNodeContainer,
	#superclass : #ToNodeContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToFiniteListNodeContainer >> applyConfiguration [

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
ToFiniteListNodeContainer >> intersectionRectangleWithListElement [

	| intersection bnds pbnds list |
	list := self holder listElement.
	bnds := self measuredBounds inSpace bounds asRectangle.
	pbnds := self listElementReferenceBoundsInSpace asRectangle.
	intersection := bnds intersect: pbnds.
	^ intersection
]

{ #category : #testing }
ToFiniteListNodeContainer >> isFullyVisibleInListElement [

	| bnds  intersection |
	bnds := (self measuredBounds inSpace) asRectangle.
	intersection := self intersectionRectangleWithListElement.
	^ intersection = bnds
]

{ #category : #testing }
ToFiniteListNodeContainer >> isPartlyVisibleInListElement [

	^ self intersectionRectangleWithListElement
		  ifNotNil: [ :i | i isZero not ]
		  ifNil: [ false ]
]

{ #category : #testing }
ToFiniteListNodeContainer >> listElementReferenceBoundsInSpace [

	|  list |
	list := self holder listElement.
	^ list innerElement bounds inSpace
]
