Class {
	#name : 'ToLabelEditorWindowManager',
	#superclass : 'ToAnchoredWindowManager',
	#category : 'Toplo-Widget-Album-Label',
	#package : 'Toplo-Widget-Album',
	#tag : 'Label'
}

{ #category : 'initialization' }
ToLabelEditorWindowManager >> defaultPositionHook [

	^ [ :theWindow :theLabel :event |
	  theWindow position:
		  (theLabel innerElement bounds inParent: self anchorRoot) bounds
			  topLeft - theLabel editor padding left
		  @ theLabel editor padding top ]
]

{ #category : 'initialization' }
ToLabelEditorWindowManager >> initialize [

	super initialize.
	self builder: [ :anchWin :request |
		| ed label |
		label := request currentTarget.
		ed := label newEditor.
		anchWin root addChild: ed.
		ed text: label text asString ]
]

{ #category : 'accessing' }
ToLabelEditorWindowManager >> windowClass [

	^ ToLabelEditorWindow 
]
