Trait {
	#name : #TToListSelectionElement,
	#instVars : [
		'listElement',
		'selectionOption',
		'nodeContainers',
		'precomputedBounds'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'t - list selection element - private' }
TToListSelectionElement >> boundsInListElement: aListElement [

	self shouldBeImplemented 
]

{ #category : #'t - list selection element - private' }
TToListSelectionElement >> initializeAsListSelectionElement [

	self constraintsDo: [ :c | c ignoreByLayout ].
	self focusability: BlFocusability ignore.
	" must prevent mouse events for the scrolling events "
	self preventMouseEvents.
	self outskirts: BlOutskirts inside
]

{ #category : #'t - list selection element - testing' }
TToListSelectionElement >> isBeneath [

	^ selectionOption isBeneath
]

{ #category : #'t - list selection element - testing' }
TToListSelectionElement >> isFocusable [
	" a selection element can't have the focus "

	^ false
]

{ #category : #'t - list selection element - accessing' }
TToListSelectionElement >> listElement [

	^ listElement
]

{ #category : #'t - list selection element - accessing' }
TToListSelectionElement >> nodeContainer [

	^ nodeContainers first
]

{ #category : #'t - list selection element - accessing' }
TToListSelectionElement >> nodeContainers [

	^ nodeContainers
]

{ #category : #'t - list selection element - accessing' }
TToListSelectionElement >> nodeContainers: aNodeContainerArray listElement: aListElement [

	| bnds |
	nodeContainers := aNodeContainerArray.
	listElement := aListElement.
	bnds := self precomputedBoundsIn: aListElement.
	self position: bnds origin.
	self extent: bnds extent
]

{ #category : #'t - list selection element - private' }
TToListSelectionElement >> positionFrom: aPoint in: aListElement [

	^ aPoint 
]

{ #category : #'t - list selection element - accessing' }
TToListSelectionElement >> precomputedBounds [

	^ precomputedBounds
]

{ #category : #'t - list selection element - accessing' }
TToListSelectionElement >> precomputedBoundsIn: aListElement [

	^ precomputedBounds ifNil: [
		  precomputedBounds := self boundsInListElement: aListElement ]
]

{ #category : #'t - list selection element - accessing' }
TToListSelectionElement >> selectionOption [

	^ selectionOption
]

{ #category : #'t - list selection element - accessing' }
TToListSelectionElement >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]

{ #category : #'t - list selection element - private' }
TToListSelectionElement >> sizeFrom: aPoint in: aListElement [

	^ aPoint
]
