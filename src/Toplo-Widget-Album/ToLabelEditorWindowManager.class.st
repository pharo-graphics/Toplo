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

{ #category : #accessing }
ToLabelEditorWindowManager >> elementEventHandlerClass [

	^ ToLabelEditorEventHandler 
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
