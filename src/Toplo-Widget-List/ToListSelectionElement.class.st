Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement',
		'selectionOption',
		'nodes',
		'placement',
		'measurement'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #initialization }
ToListSelectionElement >> initialize [

	super initialize.
	placement := ToNoCustomPlacement new.
	measurement := ToNoCustomMeasurement new.
	self constraintsDo: [ :c | c ignoreByLayout ].
	" let install the skin immediately to speed-up selection updating "
	self applySkinInstallerOnFirstRequest: true.
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
ToListSelectionElement >> measurement: aToElementCustomMeasurement [

	measurement := aToElementCustomMeasurement
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

{ #category : #layout }
ToListSelectionElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	placement positionElement: self context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
ToListSelectionElement >> onMeasure: anExtentMeasurementSpec [

	measurement onMeasure: anExtentMeasurementSpec element: self.
	super onMeasure: anExtentMeasurementSpec.


]

{ #category : #accessing }
ToListSelectionElement >> placement: aToElementCustomPlacement [

	placement := aToElementCustomPlacement
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
