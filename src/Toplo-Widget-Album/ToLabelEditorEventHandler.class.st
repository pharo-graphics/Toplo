Class {
	#name : 'ToLabelEditorEventHandler',
	#superclass : 'ToAlbumEventHandler',
	#instVars : [
		'label',
		'editorPosition'
	],
	#category : 'Toplo-Widget-Album-Label',
	#package : 'Toplo-Widget-Album',
	#tag : 'Label'
}

{ #category : 'event handling' }
ToLabelEditorEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target whenLayoutedDoOnce: [ editorPosition := target positionInSpace ].
]

{ #category : 'event handling' }
ToLabelEditorEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	editorPosition ifNil: [ ^ self ].
	editorPosition ~= target positionInSpace ifTrue: [
		self label removeEditor ]
]

{ #category : 'api - accessing' }
ToLabelEditorEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementAddedToSceneGraphEvent. BlElementPositionInSpaceChangedEvent  }
]

{ #category : 'event handling' }
ToLabelEditorEventHandler >> focusEvent: anEvent [

	super focusEvent: anEvent.
	"self label editorFrame toFront"
]

{ #category : 'accessing' }
ToLabelEditorEventHandler >> label [

	^ label
]

{ #category : 'accessing' }
ToLabelEditorEventHandler >> label: aLabel [

	label := aLabel
]

{ #category : 'api - hooks' }
ToLabelEditorEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement fitContent.
	anElement next fitContent.
	anElement infinite fitContent.
	anElement next background: Color transparent.
	anElement next padding: self label padding.
	anElement next margin: self label margin.
]
