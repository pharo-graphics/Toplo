Class {
	#name : #ToLabelEditorWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #initialization }
ToLabelEditorWindowManager >> defaultPositionHook [

	^ [ :theWindow :theLabel :event |
	  theWindow position:
		  (theLabel innerElement bounds inParent: self anchorRoot) bounds
			  topLeft - theLabel editor padding left
		  @ theLabel editor padding top ]
]

{ #category : #initialization }
ToLabelEditorWindowManager >> initialize [

	super initialize.
	self builder: [ :anchWin :request |
		| ed label |
		label := request currentTarget.
		ed := label newEditor.
		anchWin root addChild: ed.
		ed text: label text copy ]
]

{ #category : #'window opening - closing handlers' }
ToLabelEditorWindowManager >> labelEditorClosedEvent: anEvent [

	self closedEvent: anEvent
]

{ #category : #'window opening - closing handlers' }
ToLabelEditorWindowManager >> labelEditorOpenedEvent: anEvent [

	self openedEvent: anEvent
]

{ #category : #accessing }
ToLabelEditorWindowManager >> windowClass [

	^ ToLabelEditorWindow 
]

{ #category : #accessing }
ToLabelEditorWindowManager >> windowClosedEventClass [

	^ ToLabelEditorClosedEvent
]

{ #category : #accessing }
ToLabelEditorWindowManager >> windowOpenedEventClass [

	^ ToLabelEditorOpenedEvent
]
