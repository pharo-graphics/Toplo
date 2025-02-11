Class {
	#name : #ToElementEditorPlacement,
	#superclass : #ToWindowPlacement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #api }
ToElementEditorPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element inner pos |
	root := aWindow anchorRoot.
	element := aWindow element.
	inner := innerElement ifNil: [ element ].
	" take into accound the gap used to compute the textField padding "
	pos := (inner bounds inParent: root) topLeft
	       - ((element valueOfTokenNamed: #'padding-content-HS')
		        @ (element valueOfTokenNamed: #'padding-content-VS')).
	aWindow position: pos
]

{ #category : #accessing }
ToElementEditorPlacement >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToElementEditorPlacement >> innerElement: anElement [

	innerElement := anElement
]
