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
	aDecoration dispatchEvent: (ToListSelectionLabelInDecorationAdaptionEvent new label: anElement; yourself)
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> decoration: aDecoration changedIn: anElement [

	selected ifFalse: [ ^ self ].	
	aDecoration dispatchEvent: (ToListSelectionLabelInDecorationAdaptionEvent new label: anElement; yourself)
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> decoration: aDecoration removedIn: anElement [

	selected ifFalse: [ ^ self ].
	selected := false.
	selectionDecoration := nil.
	backgroundBackup ifNotNil: [ anElement background: backgroundBackup ].
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
ToLabelInNodeDresser >> labelEditorAddedIn: aLabel [


	textRopeBackup ifNil: [ ^ self ].
	" get back the text rope when editing "
	aLabel text rope: textRopeBackup.
	aLabel requestLayout.


]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> labelEditorRemovedIn: aLabel [

	"selectionDecoration ifNil: [ ^ self ]."
	" editor removed and the node is selected; get back the contrasting background "
	| infinite |
	infinite := node parent.
	infinite requestFocus.
	selected ifFalse: [ ^ self ].
	self flag: 'Do not work if the edition is accepted because a new node is created in that case (because the data is updated) '.
	"aLabel background: selectionDecoration actualBackgroundColor contrastingBlackAndWhiteColor."

	self flag: 'workaround to make the node label foreground drawn correctly according to the selection background '.
	infinite whenLayoutedDoOnce: [ infinite parent dispatchEvent: ToListPrimarySelectionUpdateEvent new ]
	"node holder infiniteElement selectIndex: node holder position -1.
	node holder infiniteElement selectIndex: node holder position."

]

{ #category : #accessing }
ToLabelInNodeDresser >> node: aNode [

	node := aNode
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
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
