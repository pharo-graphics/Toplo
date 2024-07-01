Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#instVars : [
		'selectionOption'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListSelectionElement class >> selectionOption: aSelectionOption focused: aBoolean [

	^ self new
		  selectionOption: aSelectionOption;
		  focused: aBoolean;
		  yourself
]

{ #category : #initialization }
ToListSelectionElement >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self preventMouseEvents.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #accessing }
ToListSelectionElement >> isBeneath [

	^ selectionOption isBeneath
]

{ #category : #private }
ToListSelectionElement >> positionFrom: aPoint in: aListElement [

	^ aPoint
]

{ #category : #accessing }
ToListSelectionElement >> selectionMode [

	^ selectionOption selectionMode
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
