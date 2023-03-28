Class {
	#name : #ToLabelInInfiniteNodeDresser,
	#superclass : #ToDresser,
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
ToLabelInInfiniteNodeDresser >> decoration: aDecoration addedIn: anElement [

	selected := true.
	selectionDecoration := aDecoration.

	backgroundBackup := anElement background.
	anElement background: Color transparent.

	textRopeBackup := anElement label text rope copy.

	anElement label text foreground:
		selectionDecoration actualBackgroundColor
			contrastingBlackAndWhiteColor.
	anElement label requestLayout
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInInfiniteNodeDresser >> decoration: aDecoration changedIn: anElement [

	selected ifFalse: [ ^ self ].
	anElement text foreground: aDecoration actualBackgroundColor contrastingBlackAndWhiteColor.
	anElement requestLayout
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInInfiniteNodeDresser >> decoration: aDecoration removedIn: anElement [

	selected ifFalse: [ ^ self ].
	selected := false.
	selectionDecoration := nil.
	textRopeBackup ifNotNil: [
		anElement text rope: textRopeBackup.
		anElement requestLayout.
		textRopeBackup := nil ]
]

{ #category : #initialization }
ToLabelInInfiniteNodeDresser >> initialize [ 

	super initialize.
	selected := false
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInInfiniteNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	anElement whenLabelChangedDo: [ :curr :prev |
		self installNewLabel: curr previous: prev ].

	selectionDecorationAddedHandler := BlEventHandler
		                                   on:
		                                   ToListSelectionDecorationAddedEvent
		                                   do: [ :event |
		                                   self
			                                   decoration: event decoration
			                                   addedIn: anElement ].
	selectionDecorationRemovedHandler := BlEventHandler
		                                     on:
		                                     ToListSelectionDecorationRemovedEvent
		                                     do: [ :event |
		                                     self
			                                     decoration: event decoration
			                                     removedIn: anElement ].
	selectionDecorationChangedHandler := BlEventHandler
		                                     on:
		                                     ToListSelectionDecorationChangedEvent
		                                     do: [ :event |
		                                     self
			                                     decoration: event decoration
			                                     changedIn: anElement ].

	anElement addEventHandler: selectionDecorationAddedHandler.
	anElement addEventHandler: selectionDecorationRemovedHandler.
	anElement addEventHandler: selectionDecorationChangedHandler
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInInfiniteNodeDresser >> installNewLabel: curr previous: prev [

	prev ifNotNil: [
		prev removeEventHandler: editorAddedHandler.
		prev removeEventHandler: editorRemovedHandler ].

	editorAddedHandler := BlEventHandler
		                      on: ToLabelEditorAddedEvent
		                      do: [ :event | self labelEditorAddedIn: curr ].
	editorRemovedHandler := BlEventHandler
		                        on: ToLabelEditorRemovedEvent
		                        do: [ :event | self labelEditorRemovedIn: curr ].
	curr addEventHandler: editorAddedHandler.
	curr addEventHandler: editorRemovedHandler
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInInfiniteNodeDresser >> labelEditorAddedIn: aLabel [


	textRopeBackup ifNil: [ ^ self ].
	aLabel text rope: textRopeBackup.
	aLabel requestLayout.


]

{ #category : #'api - install/uninstall  hook' }
ToLabelInInfiniteNodeDresser >> labelEditorRemovedIn: aLabel [

	selectionDecoration ifNil: [ ^ self ].
	aLabel text foreground: selectionDecoration actualBackgroundColor contrastingBlackAndWhiteColor.
	aLabel requestLayout
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInInfiniteNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self installEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToLabelInInfiniteNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToLabelInInfiniteNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	
	anElement removeEventHandler: selectionDecorationAddedHandler.
	anElement removeEventHandler: selectionDecorationRemovedHandler.
	anElement removeEventHandler: selectionDecorationChangedHandler.
	anElement label ifNotNil: [:l | l removeEventHandler: editorAddedHandler].
	anElement label ifNotNil: [:l | l removeEventHandler: editorRemovedHandler ].	

]
