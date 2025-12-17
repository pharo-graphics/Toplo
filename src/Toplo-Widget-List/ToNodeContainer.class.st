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

	| list |
	super applyConfiguration.
	self node applyConfiguration.
	list := self holder listElement.
	list isHorizontal
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].
	self vFitContent
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
ToNodeContainer >> item [

	^ self node item
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

	^ self holder listElement nodeManager
]
