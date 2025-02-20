Class {
	#name : #ToElementEditorPlacement,
	#superclass : #ToElementCustomPlacement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Core-Support'
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

	| root theAnchor inner pos |
	root := anElement anchorRoot.
	theAnchor := anElement anchorElement.
	inner := innerElement ifNil: [ theAnchor ].
	" take into accound the gap used to compute the textField padding "
	pos := (inner bounds inParent: root) topLeft
	       - ((theAnchor valueOfTokenNamed: #'padding-content-HS')
		        @ (theAnchor valueOfTokenNamed: #'padding-content-VS')).
	anElement position: pos
]
