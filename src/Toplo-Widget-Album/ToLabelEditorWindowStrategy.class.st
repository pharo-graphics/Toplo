Class {
	#name : #ToLabelEditorWindowStrategy,
	#superclass : #ToAnchoredWindowStrategy,
	#category : #'Toplo-Widget-Album-LabelEditor'
}

{ #category : #initialization }
ToLabelEditorWindowStrategy >> defaultPositionHook [

	" take into accound the gap used to compute the textField padding "
	^ [ :theWindow :theLabel :event |
	  (theLabel boundsForEditor inParent: self anchorRoot) topLeft
	  - ((theLabel valueOfTokenNamed: #'padding-content-HS')
		   @ (theLabel valueOfTokenNamed: #'padding-content-VS')) ]
]
