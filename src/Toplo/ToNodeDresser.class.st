Class {
	#name : #ToNodeDresser,
	#superclass : #ToButtonDresser,
	#instVars : [
		'unselectedBackground',
		'focusGetterHandler'
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
ToNodeDresser >> hover: anElement event: anEvent [

	self border: self hoveredBorder in: anElement.
	unselectedBackground ifNotNil: [ ^ self ].
	self background: self hoveredBackground in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	focusGetterHandler := BlEventHandler
		                   on: BlClickEvent do: [ :anEvent | anElement holder infiniteElement requestFocus ].
	anElement addEventHandler: focusGetterHandler

]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: BlRectangleGeometry new.
	anElement padding: (BlInsets all: 2).
	anElement border: BlBorder empty
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #enumerating }
ToNodeDresser >> removedFromSelection: anElement [

	initialBackground := unselectedBackground.
	self background: initialBackground  in: anElement.
	unselectedBackground := nil
]

{ #category : #enumerating }
ToNodeDresser >> selectionBackground [

	^ theme button hoveredBorderColor alpha: 0.5 
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: focusGetterHandler

]
