Class {
	#name : #ToLabelEditorWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #initialization }
ToLabelEditorWindowManager >> defaultPositionHook [

	^ [ :theWindow :theLabel :event |
		  (theLabel innerElement bounds inParent: self anchorRoot) bounds
			  topLeft - theLabel editor padding left
		  @ theLabel editor padding top ]
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
