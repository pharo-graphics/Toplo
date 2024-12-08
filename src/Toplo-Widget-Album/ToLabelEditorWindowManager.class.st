Class {
	#name : #ToLabelEditorWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #initialization }
ToLabelEditorWindowManager >> defaultPositionHook [

	" take into accound the gap used to compute the textField padding "
	^ [ :theWindow :theLabel :event |
	  (theLabel innerElement bounds inParent: self anchorRoot) topLeft
	  - ((theLabel valueOfTokenNamed: #'padding-content-HS')
		   @ (theLabel valueOfTokenNamed: #'padding-content-VS')) ]
]

{ #category : #initialization }
ToLabelEditorWindowManager >> initialize [

	super initialize.
	self windowBuilder: [ :window :request |
		| ed label |
		label := request currentTarget.
		ed := label newEditor.
		window root addChild: ed.
		ed text: label text copy ]
]

{ #category : #accessing }
ToLabelEditorWindowManager >> windowClass [

	^ ToLabelEditorWindow 
]
