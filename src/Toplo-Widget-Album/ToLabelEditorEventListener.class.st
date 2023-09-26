Class {
	#name : #ToLabelEditorEventListener,
	#superclass : #ToTextFieldEventListener,
	#instVars : [
		'label',
		'editorPosition'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'event handling' }
ToLabelEditorEventListener >> elementAddedToSceneGraphEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target whenLayoutedDoOnce: [ editorPosition := target positionInSpace ]
]

{ #category : #'event handling' }
ToLabelEditorEventListener >> elementPositionInSpaceChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.

	editorPosition ifNil: [ ^ self ].
	editorPosition ~= target positionInSpace ifTrue: [
		self label removeEditor ]
]

{ #category : #'api - accessing' }
ToLabelEditorEventListener >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementAddedToSceneGraphEvent. BlElementPositionInSpaceChangedEvent  }
]

{ #category : #'event handling' }
ToLabelEditorEventListener >> focusEvent: anEvent [

	super focusEvent: anEvent.
	self label editorFrame toFront
]

{ #category : #accessing }
ToLabelEditorEventListener >> label [

	^ label
]

{ #category : #accessing }
ToLabelEditorEventListener >> label: aLabel [

	label := aLabel
]

{ #category : #'api - hooks' }
ToLabelEditorEventListener >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement fitContent.
	anElement next fitContent.
	anElement infinite fitContent.
	anElement next background: Color transparent.
	anElement next padding: self label padding.
	anElement next margin: self label margin.
]
