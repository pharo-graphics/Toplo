Class {
	#name : #ToLabelInNodeDresser,
	#superclass : #ToDresser,
	#instVars : [
		'node',
		'selected',
		'backgroundBackup',
		'editorAddedHandler',
		'editorRemovedHandler',
		'selectionDecoration',
		'textRopeBackup',
		'selectionAddedHandler',
		'selectionChangedHandler',
		'selectionRemovedHandler'
	],
	#category : #'Toplo-Core-Node'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> decoration: aDecoration addedIn: anElement [

	selected := true.
	selectionDecoration := aDecoration.

	backgroundBackup := anElement background.
	anElement background: Color transparent.

	textRopeBackup := anElement text rope copy.

	anElement text foreground: selectionDecoration actualBackgroundColor contrastingBlackAndWhiteColor.
	anElement requestLayout
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> decoration: aDecoration changedIn: anElement [

	selected ifFalse: [ ^ self ].
	anElement text foreground: aDecoration actualBackgroundColor contrastingBlackAndWhiteColor.
	anElement requestLayout
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> decoration: aDecoration removedIn: anElement [

	selected ifFalse: [ ^ self ].
	selected := false.
	selectionDecoration := nil.
	textRopeBackup ifNotNil: [
		anElement text rope: textRopeBackup.
		anElement requestLayout.
		textRopeBackup := nil ]
]

{ #category : #initialization }
ToLabelInNodeDresser >> initialize [ 

	super initialize.
	selected := false
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	editorAddedHandler := BlEventHandler
		                      on: ToLabelEditorAddedEvent
		                      do: [ :event | self labelEditorAddedIn: anElement ].
	editorRemovedHandler := BlEventHandler
		                        on: ToLabelEditorRemovedEvent
		                        do: [ :event | self labelEditorRemovedIn: anElement ].
	anElement addEventHandler: editorAddedHandler.
	anElement addEventHandler: editorRemovedHandler.
	
	selectionAddedHandler := BlEventHandler
		                         on: ToListSelectionDecorationAddedEvent
		                         do: [ :event |
		                         self
			                         decoration: event decoration
			                         addedIn: anElement ].
	selectionRemovedHandler := BlEventHandler
		                           on: ToListSelectionDecorationRemovedEvent
		                           do: [ :event |
		                           self
			                           decoration: event decoration
			                           removedIn: anElement ].
	selectionChangedHandler := BlEventHandler
		                           on: ToListSelectionDecorationChangedEvent
		                           do: [ :event |
		                           self
			                           decoration: event decoration
			                           changedIn: anElement ].

	node addEventHandler: selectionAddedHandler.
	node addEventHandler: selectionRemovedHandler.
	node addEventHandler: selectionChangedHandler
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> installNewLabel: curr previous: prev [

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
ToLabelInNodeDresser >> labelEditorAddedIn: aLabel [


	textRopeBackup ifNil: [ ^ self ].
	" get back the text rope when editing "
	aLabel text rope: textRopeBackup.
	aLabel requestLayout.


]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> labelEditorRemovedIn: aLabel [

	selectionDecoration ifNil: [ ^ self ].
	" editor removed and the node is selected; get back the contrasting background "
	aLabel text foreground: selectionDecoration actualBackgroundColor contrastingBlackAndWhiteColor.
	aLabel requestLayout
]

{ #category : #accessing }
ToLabelInNodeDresser >> node: aNode [

	node := aNode
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self installEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallEventListenersIn: anElement.
	node := nil

]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	
	node removeEventHandler: selectionAddedHandler.
	node removeEventHandler: selectionRemovedHandler.
	node removeEventHandler: selectionChangedHandler.
	anElement removeEventHandler: editorAddedHandler.
	anElement removeEventHandler: editorRemovedHandler

]
