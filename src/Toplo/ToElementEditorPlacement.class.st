Class {
	#name : #ToElementEditorPlacement,
	#superclass : #ToWindowPlacement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Core-Window-Support'
}

{ #category : #accessing }
ToElementEditorPlacement >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToElementEditorPlacement >> innerElement: anElement [

	innerElement := anElement
]

{ #category : #api }
ToElementEditorPlacement >> positionWindow: aWindow onEvent: anEvent [

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
