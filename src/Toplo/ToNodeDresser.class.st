Class {
	#name : #ToNodeDresser,
	#superclass : #ToButtonDresser,
	#instVars : [
		'unselectedBackground'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #enumerating }
ToNodeDresser >> addedToSelection: anElement [

	unselectedBackground := initialBackground.
	anElement background: self selectionBackground
]

{ #category : #'events handling' }
ToNodeDresser >> clicked: anElement event: anEvent [

	super clicked: anElement event: anEvent.
	anElement holder announce: (ToClickOnNodeAnnouncement new
			 holder: anElement holder;
			 event: anEvent;
			 yourself)

]

{ #category : #'events handling' }
ToNodeDresser >> hover: anElement [

	
	self border: self hoveredBorder in: anElement.
	unselectedBackground ifNotNil: [ ^ self ].
	self background: self hoveredBackground in: anElement.
]

{ #category : #enumerating }
ToNodeDresser >> removedFromSelection: anElement [

	initialBackground := unselectedBackground.
	self background: initialBackground  in: anElement.
	unselectedBackground := nil
]

{ #category : #enumerating }
ToNodeDresser >> selectionBackground [

	^ theme button hoveredBorderColor alpha: 0.3 
]
