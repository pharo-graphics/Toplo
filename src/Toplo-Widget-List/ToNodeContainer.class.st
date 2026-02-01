"
I'm abstract a triplet (start, middle, end) for list. 
I'm one of the children of the inner element of a list.
I hold a kind of `ToAbstractListNode` as my middle container.  
I refer to the nodeHolder (a kind of `ToNodeHolder`).
"
Class {
	#name : #ToNodeContainer,
	#superclass : #ToTripletContainer,
	#category : #'Toplo-Widget-List-Node'
}

{ #category : #configuration }
ToNodeContainer >> applyConfiguration [

	| list conf |
	super applyConfiguration.
	list := self holder listElement.
	conf := list toConfiguration.

	(list useInfiniteLayout not and: [
		 conf isFlowable or: [ list isOrientable not ] ])
		ifTrue: [ self exactOrFitContent ]
		ifFalse: [
		list isOrientable ifTrue: [ self applyOrientableConfiguration ] ].

	self isFake ifTrue: [ ^ self applyFakeConfiguration ].
	self node applyConfiguration
]

{ #category : #configuration }
ToNodeContainer >> applyFakeConfiguration [

	| list |
	list := self holder listElement.
	list isOrientable ifFalse: [
			self extent: 0 @ 0.
			self margin: (BlInsets all: 0).
			^ self ].
	list isHorizontal
		ifTrue: [
				self width: 0.
				self margin: ((self margin withLeft: 0)
						 withRight: 0;
						 yourself) ]
		ifFalse: [
				self height: 0.
				self margin: ((self margin withTop: 0)
						 withBottom: 0;
						 yourself) ]
]

{ #category : #configuration }
ToNodeContainer >> applyHorizontalConfiguration [

	| list conf |
	list := self holder listElement.
	conf := list toConfiguration.

	self vMatchParent.
	(list useInfiniteLayout not and: [ conf autoDistribute ])
		ifTrue: [ self hMatchParent ]
		ifFalse: [ self hExactOrFitContent ]
]

{ #category : #configuration }
ToNodeContainer >> applyOrientableConfiguration [

	| list conf |
	list := self holder listElement.
	conf := list toConfiguration.

	list isVertical
		ifTrue: [ self applyVerticalConfiguration ]
		ifFalse: [ self applyHorizontalConfiguration ]
]

{ #category : #configuration }
ToNodeContainer >> applyVerticalConfiguration [

	| list conf |
	list := self holder listElement.
	conf := list toConfiguration.

	self hMatchParent.
	(list useInfiniteLayout not and: [ conf autoDistribute ])
		ifTrue: [ self vMatchParent ]
		ifFalse: [ self vExactOrFitContent ]
]

{ #category : #accessing }
ToNodeContainer >> checkbox [

	^ self startContainer ifNotNil: [:sc | sc childWithId: #'list-selection-checkbox' ifNone: [  ] ]
]

{ #category : #comparing }
ToNodeContainer >> equals: other [

	^ self = other
]

{ #category : #accessing }
ToNodeContainer >> holder: aNodeHolder [

	super holder: aNodeHolder.
	self createMiddleContainer 
]

{ #category : #testing }
ToNodeContainer >> intersectionRectangleWithListElement [

	| intersection bnds pbnds list |
	list := self holder listElement.
	bnds := self measuredBounds inSpace bounds asRectangle.
	pbnds := self listElementReferenceBoundsInSpace asRectangle.
	intersection := bnds intersect: pbnds.
	^ intersection
]

{ #category : #testing }
ToNodeContainer >> isFake [

	| list |
	list := self holder listElement.
	^ list isFakeNodeContainer: self
]

{ #category : #testing }
ToNodeContainer >> isFullyVisibleInListElement [

	| bnds  intersection |
	bnds := (self measuredBounds inSpace) asRectangle.
	intersection := self intersectionRectangleWithListElement.
	^ intersection = bnds
]

{ #category : #testing }
ToNodeContainer >> isPartlyVisibleInListElement [

	^ self intersectionRectangleWithListElement
		  ifNotNil: [ :i | i isZero not ]
		  ifNil: [ false ]
]

{ #category : #accessing }
ToNodeContainer >> listElement [ 

	^ self holder listElement
]

{ #category : #testing }
ToNodeContainer >> listElementReferenceBoundsInSpace [

	|  list |
	list := self holder listElement.
	^ list innerElement bounds inSpace
]

{ #category : #'t - triplet container - instance creation' }
ToNodeContainer >> newMiddleContainer [

	| node |
	node := self nodeManager newNodeForHolder: self holder.
	node holder: self holder.
	^ node
]

{ #category : #'instance creation' }
ToNodeContainer >> newRawSkin [

	^ ToNodeContainerSkin new
]

{ #category : #'t - triplet container - instance creation' }
ToNodeContainer >> newStartContainer [

	^ self newLinearContainer 
]

{ #category : #accessing }
ToNodeContainer >> node [

	^ self middleContainer 
]

{ #category : #accessing }
ToNodeContainer >> nodeManager [ 

	^ self listElement nodeManager
]
