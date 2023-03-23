Class {
	#name : #ToLabeledNodeDresser,
	#superclass : #ToNodeDresser,
	#instVars : [
		'selected',
		'textBackup',
		'backgroundBackup',
		'selectionDecorationAddedHandler',
		'selectionDecorationRemovedHandler',
		'selectionDecorationChangedHandler'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> element: anElement listSelectionDecorationAddedEvent: anEvent [

	anEvent currentTarget = anElement ifFalse: [ ^ self ].
	selected := true.
	
	backgroundBackup := anElement background.
	anElement background: Color transparent.

	textBackup := anElement label text rope copy.
	anElement label text foreground: anEvent decoration actualBackgroundColor contrastingBlackAndWhiteColor.
	anElement label requestLayout

]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> element: anElement listSelectionDecorationChangedEvent: anEvent [

	selected ifFalse: [ ^ self ].
	anElement label text foreground:
		anEvent decoration actualBackgroundColor
			contrastingBlackAndWhiteColor.
	anElement label requestLayout
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> element: anElement listSelectionDecorationRemovedEvent: anEvent [

	selected ifFalse: [ ^ self ].
	selected := false.

	backgroundBackup ifNotNil: [ 
		anElement background: backgroundBackup.
		backgroundBackup := nil].

	textBackup ifNotNil: [
		anElement label text rope: textBackup.
		anElement label requestLayout.
		textBackup := nil ]
]

{ #category : #'events handling' }
ToLabeledNodeDresser >> hover: anElement event: anEvent [

	"self border: self hoveredBorder in: anElement."
	" do not change the background if selected "
	selected ifFalse: [
		"self background: self hoveredBackground in: anElement" ]
]

{ #category : #initialization }
ToLabeledNodeDresser >> initialize [ 

	super initialize.
	selected := false
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	selectionDecorationAddedHandler := BlEventHandler on: ToListSelectionDecorationAddedEvent do: [ :event | self element: anElement listSelectionDecorationAddedEvent: event ].
	selectionDecorationRemovedHandler := BlEventHandler on: ToListSelectionDecorationRemovedEvent do: [ :event | self element: anElement listSelectionDecorationRemovedEvent: event ].
	selectionDecorationChangedHandler := BlEventHandler on: ToListSelectionDecorationChangedEvent do: [ :event | self element: anElement listSelectionDecorationChangedEvent: event ].
	
	anElement addEventHandler: selectionDecorationAddedHandler.
	anElement addEventHandler: selectionDecorationRemovedHandler.
	anElement addEventHandler: selectionDecorationChangedHandler.

]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leaved: anElement event: anEvent [

	"self border: self defaultBorder in: anElement."
	selected ifFalse: [
		"self background: self defaultBackground in: anElement" ]


]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leftClicked: anElement [ 
	
	selected ifTrue: [ ^ self ].
	" do not change the background and the border if selected "
	"self border: self hoveredBorder in: anElement."
	"self background: self hoveredBackground in: anElement"


]

{ #category : #'events handling' }
ToLabeledNodeDresser >> leftPressed: anElement event: anEvent [

	selected ifTrue: [ ^ self ].
	super leftPressed: anElement event: anEvent
]

{ #category : #accessing }
ToLabeledNodeDresser >> selectionBackground [

	^ self colorProvider selectedColor
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	
	anElement removeEventHandler: selectionDecorationAddedHandler.
	anElement removeEventHandler: selectionDecorationRemovedHandler.
	anElement removeEventHandler: selectionDecorationChangedHandler.

]
