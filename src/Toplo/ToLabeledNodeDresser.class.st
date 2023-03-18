Class {
	#name : #ToLabeledNodeDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'focusGetterHandler',
		'monitor',
		'selected',
		'textBackup'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'events handling' }
ToLabeledNodeDresser >> addedToSelection: anElement [

	super addedToSelection: anElement.
	selected := true.
	textBackup := anElement label text rope copy.
	anElement label text foreground: self selectionBackground contrastingBlackAndWhiteColor.
	anElement label requestLayout.
	
	self background: self selectionBackground  in: anElement.
	"self border: initialBorder in: anElement."

]

{ #category : #accessing }
ToLabeledNodeDresser >> clickActionLauncher [

	^ ToNodeClickActionLauncher new
]

{ #category : #accessing }
ToLabeledNodeDresser >> defaultHoveredBackground [  

	^ theme item hoveredColor

]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> defaultHoveredBorder [

	^ BlBorder paint: self theme item hoveredBorderColor

]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> defaultInitialBackground [

	^ self theme item defaultColor
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> defaultInitialBorder [

	^ BlBorder paint: self theme item deselectedColor.

]

{ #category : #'events handling' }
ToLabeledNodeDresser >> hover: anElement event: anEvent [

	self border: self hoveredBorder in: anElement.
	" do not change the background if selected "
	selected ifFalse: [
		self background: self hoveredBackground in: anElement ]
]

{ #category : #initialization }
ToLabeledNodeDresser >> initialize [ 

	super initialize.
	monitor := Monitor new.
	selected := false
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	focusGetterHandler := BlEventHandler on: BlClickEvent do: [ :anEvent | anElement holder infiniteElement requestFocus ].
	anElement addEventHandler: focusGetterHandler

]

{ #category : #'events handling' }
ToLabeledNodeDresser >> launchClick: aBlock for: anInfinite [

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
ToLabeledNodeDresser >> leaved: anElement [

	self border: initialBorder in: anElement.
	" do not change the background if selected "
	selected ifFalse: [ self background: initialBackground in: anElement ]
]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leftClicked: anElement [ 
	
	self restoreUnpressedState.
	selected ifTrue: [ ^ self ].
	" do not change the background and the border if selected "
	self border: self hoveredBorder in: anElement.
	self background: self hoveredBackground in: anElement


]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leftClicked: anElement event: anEvent [

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
ToLabeledNodeDresser >> leftPressed: anElement event: anEvent [

	selected ifTrue: [ ^ self ].
	super leftPressed: anElement event: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement hMatchParent.
	anElement geometry: BlRectangleGeometry new.
	anElement padding: (BlInsets
			 top: 0
			 left: 3
			 bottom: 0
			 right: 1).
	anElement margin: (BlInsets all: 0).
	anElement border: (BlBorder paint: Color transparent).
	anElement background: self theme item defaultColor
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #accessing }
ToLabeledNodeDresser >> pressedBackground [

	^ theme item pressedColor
]

{ #category : #accessing }
ToLabeledNodeDresser >> pressedBorder [

	^ BlBorder paint: theme item pressedBorderColor width: 1
]

{ #category : #'events handling' }
ToLabeledNodeDresser >> removedFromSelection: anElement [

	super removedFromSelection: anElement.
	selected := false.
	" recover initial background "
	self background: initialBackground in: anElement.
	textBackup ifNotNil: [
		anElement label text rope: textBackup.
		anElement label requestLayout.
		textBackup := nil ]
]

{ #category : #'events handling' }
ToLabeledNodeDresser >> savedPressedBackground: aBackground [

	" do not change the background if selected "
	super savedPressedBackground: aBackground.
]

{ #category : #accessing }
ToLabeledNodeDresser >> selectionBackground [

	^ self theme item selectedColor
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: focusGetterHandler

]
