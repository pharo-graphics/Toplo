Class {
	#name : #ToElementEditorPlacement,
	#superclass : #ToElementPlacement,
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

{ #category : #'api - displaying' }
ToElementEditorPlacement >> positionElement: anElement onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root element inner pos |
	root := anElement anchorRoot.
	element := anElement anchorElement.
	inner := innerElement ifNil: [ element ].
	" take into accound the gap used to compute the textField padding "
	pos := (inner bounds inParent: root) topLeft
	       - ((element valueOfTokenNamed: #'padding-content-HS')
		        @ (element valueOfTokenNamed: #'padding-content-VS')).
	anElement position: pos
]
