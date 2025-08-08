Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement',
		'selectionOption',
		'nodes'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'private - selection element' }
ToListSelectionElement >> boundsFromNodesIn: aListElement [

	| first last startBnds endBnds corner myNodes |
	myNodes := self nodes.
	first := myNodes first.
	last := myNodes last.
	startBnds := (first measuredBounds inSpace inChild:
		              aListElement innerElement) bounds.
	endBnds := first = last
		           ifTrue: [ startBnds ]
		           ifFalse: [
				           (last measuredBounds inSpace inChild:
					            aListElement innerElement) bounds ].
	(aListElement isVertical and: [
		 first constraints horizontal isMatchParent ])
		ifTrue: [
				| w |
				w := aListElement innerElement bounds width.
				corner := w @ endBnds corner y ]
		ifFalse: [ corner := endBnds corner ].

	^ Rectangle
		  origin: (self positionFrom: startBnds origin in: aListElement)
			  + listElement padding topLeft
		  extent:
		  (self sizeFrom: corner - startBnds origin in: aListElement)
]

{ #category : #initialization }
ToListSelectionElement >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self focusability: BlFocusability ignore.
	" must prevent mouse events for the scrolling events "
	self preventMouseEvents.
	self outskirts: BlOutskirts inside
]

{ #category : #accessing }
ToListSelectionElement >> isBeneath [

	^ selectionOption isBeneath
]

{ #category : #'focus testing' }
ToListSelectionElement >> isFocusable [
	" a selection element can't have the focus "

	^ false
]

{ #category : #accessing }
ToListSelectionElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListSelectionElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #accessing }
ToListSelectionElement >> node [

	^ nodes first
]

{ #category : #accessing }
ToListSelectionElement >> nodes [

	^ nodes
]

{ #category : #accessing }
ToListSelectionElement >> nodes: aNodeArray [

	nodes := aNodeArray
]

{ #category : #private }
ToListSelectionElement >> positionFrom: aPoint in: aListElement [

	^ aPoint 
]

{ #category : #accessing }
ToListSelectionElement >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToListSelectionElement >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]

{ #category : #private }
ToListSelectionElement >> sizeFrom: aPoint in: aListElement [

	^ aPoint
]
