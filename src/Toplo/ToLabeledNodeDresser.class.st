Class {
	#name : #ToLabeledNodeDresser,
	#superclass : #ToNodeDresser,
	#instVars : [
		'selected',
		'backgroundBackup',
		'selectionDecorationAddedHandler',
		'selectionDecorationRemovedHandler',
		'selectionDecorationChangedHandler',
		'editorAddedHandler',
		'editorRemovedHandler',
		'selectionDecoration',
		'textRopeBackup'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> element: anElement listSelectionDecorationAddedEvent: anEvent [

	anEvent currentTarget = anElement ifFalse: [ ^ self ].
	selected := true.
	selectionDecoration := anEvent decoration.

	backgroundBackup := anElement background.
	anElement background: Color transparent.

	textRopeBackup := anElement label text rope copy.

	anElement label text foreground:
		selectionDecoration actualBackgroundColor
			contrastingBlackAndWhiteColor.
	anElement label requestLayout
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> element: anElement listSelectionDecorationChangedEvent: anEvent [

	selected ifFalse: [ ^ self ].
	(anEvent decoration nodes includes: anEvent currentTarget) ifFalse: [
		^ self ].

	anEvent currentTarget label text foreground:
		anEvent decoration actualBackgroundColor
			contrastingBlackAndWhiteColor.
	anEvent currentTarget label requestLayout
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> element: anElement listSelectionDecorationRemovedEvent: anEvent [

	selected ifFalse: [ ^ self ].
	(anEvent decoration nodes includes: anElement) ifFalse: [ ^ self ].
	selected := false.
	selectionDecoration := nil.
	backgroundBackup ifNotNil: [ 
		anElement background: backgroundBackup.
		backgroundBackup := nil].

	textRopeBackup ifNotNil: [
		anElement label text rope: textRopeBackup.
		anElement label requestLayout.
		textRopeBackup := nil ]
]

{ #category : #initialization }
ToLabeledNodeDresser >> initialize [ 

	super initialize.
	selected := false
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	anElement whenLabelChangedDo: [ :curr :prev | self installNewLabel: curr previous: prev ].

	selectionDecorationAddedHandler := BlEventHandler
		                                   on: ToListSelectionDecorationAddedEvent
		                                   do: [ :event |
			                                   self
				                                   element: anElement
				                                   listSelectionDecorationAddedEvent: event ].
	selectionDecorationRemovedHandler := BlEventHandler
		                                     on: ToListSelectionDecorationRemovedEvent
		                                     do: [ :event |
			                                     self
				                                     element: anElement
				                                     listSelectionDecorationRemovedEvent: event ].
	selectionDecorationChangedHandler := BlEventHandler
		                                     on: ToListSelectionDecorationChangedEvent
		                                     do: [ :event | 
			                                     self
				                                     element: anElement
				                                     listSelectionDecorationChangedEvent: event ].

	anElement addEventHandler: selectionDecorationAddedHandler.
	anElement addEventHandler: selectionDecorationRemovedHandler.
	anElement addEventHandler: selectionDecorationChangedHandler
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> installNewLabel: curr previous: prev [

	prev ifNotNil: [
		prev removeEventHandler: editorAddedHandler.
		prev removeEventHandler: editorRemovedHandler ].

	editorAddedHandler := BlEventHandler
		                      on: ToLabelEditorAddedEvent
		                      do: [ :event | self labelEditorAddedIn: curr ].
	editorRemovedHandler := BlEventHandler
		                        on: ToLabelEditorRemovedEvent
		                        do: [ :event | self labelEditorRemovedFrom: curr ].
	curr addEventHandler: editorAddedHandler.
	curr addEventHandler: editorRemovedHandler
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> labelEditorAddedIn: aLabel [


	textRopeBackup ifNil: [ ^ self ].
	aLabel text rope: textRopeBackup.
	aLabel requestLayout.


]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> labelEditorRemovedFrom: aLabel [

	selectionDecoration ifNil: [ ^ self ].
	aLabel text foreground: selectionDecoration actualBackgroundColor contrastingBlackAndWhiteColor.
	aLabel requestLayout
]

{ #category : #'api - install/uninstall  hook' }
ToLabeledNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	
	anElement removeEventHandler: selectionDecorationAddedHandler.
	anElement removeEventHandler: selectionDecorationRemovedHandler.
	anElement removeEventHandler: selectionDecorationChangedHandler.
	anElement label ifNotNil: [:l | l removeEventHandler: editorAddedHandler].
	anElement label ifNotNil: [:l | l removeEventHandler: editorRemovedHandler ].	

]
