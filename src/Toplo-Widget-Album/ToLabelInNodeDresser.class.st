Class {
	#name : #ToLabelInNodeDresser,
	#superclass : #ToDresser,
	#instVars : [
		'node',
		'backgroundBackup',
		'editorAddedHandler',
		'editorRemovedHandler',
		'textRopeBackup',
		'selectionChangedHandler',
		'selectionRemovedHandler'
	],
	#category : #'Toplo-Widget-Album-Label'
}

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
	
	selectionRemovedHandler := BlEventHandler
		                           on: ToListPrimarySelectionRemovedEvent
		                           do: [ :event | self selectionRemovedIn: anElement ].

	selectionChangedHandler := BlEventHandler
		                           on: ToListPrimarySelectionBackgroundChangedEvent
		                           do: [ :event | self selectionBackground: event background changedBehind: anElement ].

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
	self flag: 'Do not work if the edition is accepted because a new node is created in that case (because the data is updated) '.
	"aLabel background: selectionDecoration actualBackgroundColor contrastingBlackAndWhiteColor."

	self flag: 'workaround to make the node label foreground drawn correctly according to the selection background '.
	infinite whenLayoutedDoOnce: [ infinite parent dispatchEvent: ToListPrimarySelectionUpdatedEvent new ]
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
ToLabelInNodeDresser >> selectionBackground: aBackground changedBehind: anElement [
	"the original background and the original rope are stored only once"
	" (in case of blurring, the foreground should be changed without storing the original rope) "

	backgroundBackup ifNil: [ backgroundBackup := anElement background ].
	anElement background: Color transparent.
	textRopeBackup ifNil: [ textRopeBackup := anElement text rope copy ].
	anElement foreground: aBackground contrastingBlackAndWhiteColor
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> selectionRemovedIn: anElement [

	backgroundBackup ifNotNil: [
		anElement background: backgroundBackup.
		backgroundBackup := nil ].
	textRopeBackup ifNotNil: [
		anElement text rope: textRopeBackup.
		anElement requestLayout.
		textRopeBackup := nil ]
]

{ #category : #'api - install/uninstall  hook' }
ToLabelInNodeDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	
	node removeEventHandler: selectionRemovedHandler.
	node removeEventHandler: selectionChangedHandler.
	anElement removeEventHandler: editorAddedHandler.
	anElement removeEventHandler: editorRemovedHandler

]
