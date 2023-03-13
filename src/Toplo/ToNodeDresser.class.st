Class {
	#name : #ToNodeDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'focusGetterHandler',
		'monitor',
		'selected'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'events handling' }
ToNodeDresser >> addedToSelection: anElement [

	selected := true.
	self background: self selectionBackground  in: anElement.
	self border: initialBorder in: anElement.

]

{ #category : #accessing }
ToNodeDresser >> clickActionLauncher [

	^ ToNodeClickActionLauncher new
]

{ #category : #accessing }
ToNodeDresser >> defaultHoveredBackground [  

	^ theme item hoveredColor

]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> defaultHoveredBorder [

	^ BlBorder paint: self theme item hoveredBorderColor

]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> defaultInitialBackground [

	^ self theme item defaultColor
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> defaultInitialBorder [

	^ BlBorder paint: self theme item deselectedColor.

]

{ #category : #'events handling' }
ToNodeDresser >> hover: anElement event: anEvent [

	self border: self hoveredBorder in: anElement.
	" do not change the background if selected "
	selected ifTrue: [ ^ self ].
	self background: self hoveredBackground in: anElement
]

{ #category : #initialization }
ToNodeDresser >> initialize [ 

	super initialize.
	monitor := Monitor new.
	selected := false
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	focusGetterHandler := BlEventHandler on: BlClickEvent do: [ :anEvent | anElement holder infiniteElement requestFocus ].
	anElement addEventHandler: focusGetterHandler

]

{ #category : #'events handling' }
ToNodeDresser >> launchClick: aBlock for: anInfinite [

	| launcher |
	anInfinite hasClickLauncher ifTrue: [ ^self ].
	anInfinite selectedIndexes size > 1 ifFalse: [ ^ aBlock value ].
	monitor critical: [ 
		launcher := [ 
		            (Delay forMilliseconds: 250) wait.
		            aBlock value.
		            anInfinite clickLauncher: nil ]
			            forkAt: Processor highIOPriority
			            named: 'OBlMouseProcessor clickLauncher'.
		anInfinite clickLauncher: launcher ]
]

{ #category : #'events handling' }
ToNodeDresser >> leaved: anElement [

	self border: initialBorder in: anElement.
	" do not change the background if selected "
	selected ifTrue: [ ^ self ].
	self background: initialBackground in: anElement

]

{ #category : #'events handling' }
ToNodeDresser >> leftClicked: anElement [ 
	
	self restoreUnpressedState.
	selected ifTrue: [ ^ self ].
	" do not change the background and the border if selected "
	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement


]

{ #category : #'events handling' }
ToNodeDresser >> leftClicked: anElement event: anEvent [

	self
		launchClick: [ 
			self leftClicked: anElement.
			anElement holder announce: (ToClickOnNodeAnnouncement new
					 holder: anElement holder;
					 event: anEvent;
					 yourself) ]
		for: anElement holder infiniteElement
]

{ #category : #'events handling' }
ToNodeDresser >> leftPressed: anElement event: anEvent [

	selected ifTrue: [ ^ self ].
	super leftPressed: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onElementAttached: anElement inInfinite: aToInfinite [

	| holder |
	super onElementAttached: anElement inInfinite: aToInfinite.
	" when holder is attached it can be already selected (as an example with a selectAll) "
	"Selection must be preserved when adding/removing in the datasource list "
	holder := aToInfinite elementHolderOf: anElement.
	(aToInfinite selectionStrategy isSelected: holder layoutPosition) ifTrue: [ 
		self addedToSelection: anElement ].

]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onElementDetached: anElement inInfinite: aToInfinite [

	super onElementDetached: anElement inInfinite: aToInfinite
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement hMatchParent. 
	anElement geometry: BlRectangleGeometry new.
	anElement padding: (BlInsets top: 1  left: 3 bottom: 0 right: 3 ).
	anElement border: BlBorder empty
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'events handling' }
ToNodeDresser >> pressed: anElement event: anEvent [

	super pressed: anElement event: anEvent
]

{ #category : #accessing }
ToNodeDresser >> pressedBackground [

	^ theme item pressedColor
]

{ #category : #accessing }
ToNodeDresser >> pressedBorder [

	^ BlBorder paint: theme item pressedBorderColor width: 1
]

{ #category : #'events handling' }
ToNodeDresser >> removedFromSelection: anElement [

	selected := false.
	" recover initial background "
	self background: initialBackground  in: anElement
]

{ #category : #'events handling' }
ToNodeDresser >> savedPressedBackground: aBackground [

	" do not change the background if selected "
	super savedPressedBackground: aBackground.
]

{ #category : #accessing }
ToNodeDresser >> selectionBackground [

	^ self theme item selectedColor
]

{ #category : #'api - install/uninstall  hook' }
ToNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: focusGetterHandler

]
