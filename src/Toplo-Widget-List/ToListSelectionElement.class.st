Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement',
		'selectionOption',
		'nodeContainers'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'private - selection element' }
ToListSelectionElement >> boundsInListElement: aListElement [

	| first last startBnds endBnds corner containers |
	containers := self nodeContainers.
	first := containers first.
	last := containers last.
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
		  origin: (self
				   positionFrom:
				   startBnds origin + aListElement innerElement position
				   in: aListElement)
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

	self deprecated: 'Use #nodeContainer' transformWith: '`@r node'->'`@r nodeContainer'.

	^ self nodeContainer
]

{ #category : #accessing }
ToListSelectionElement >> nodeContainer [

	^ nodeContainers first
]

{ #category : #accessing }
ToListSelectionElement >> nodeContainers [

	^ nodeContainers
]

{ #category : #accessing }
ToListSelectionElement >> nodeContainers: anArray [

	nodeContainers := anArray
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
