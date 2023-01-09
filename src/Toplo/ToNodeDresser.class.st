Class {
	#name : #ToNodeDresser,
	#superclass : #ToButtonDresser,
	#instVars : [
		'focusGetterHandler',
		'initialBackgroundSave'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #enumerating }
ToNodeDresser >> addedToSelection: anElement [

	initialBackgroundSave := initialBackground.
	anElement background: self selectionBackground
]

{ #category : #accessing }
ToNodeDresser >> clickActionLauncher [

	^ ToNodeClickActionLauncher new
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
	initialBackgroundSave ifNotNil: [ ^ self ].
	self background: self hoveredBackground in: anElement
]

{ #category : #'events handling' }
ToNodeDresser >> hoveredBackground: aBackground [

	" do not change the background if selected "
	initialBackgroundSave ifNotNil: [ ^ self ].
	super hoveredBackground: aBackground.
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	focusGetterHandler := BlEventHandler on: BlClickEvent do: [ :anEvent | anElement holder infiniteElement requestFocus ].
	anElement addEventHandler: focusGetterHandler

]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement geometry: BlRectangleGeometry new.
	anElement padding: (BlInsets top: 1  left: 3 bottom: 0 right: 3 ).
	anElement border: BlBorder empty
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #enumerating }
ToNodeDresser >> removedFromSelection: anElement [

	" recover initial background "
	initialBackground := initialBackgroundSave.
	self background: initialBackground  in: anElement.
	initialBackgroundSave := nil
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
