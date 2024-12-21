Class {
	#name : #ToElementEditorPlacement,
	#superclass : #ToWindowPlacement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToElementEditorPlacement >> arrangeWindowFromManager: aManager onEvent: anEvent [

	| window root element pos inner |
	window := aManager currentWindow.
	root := aManager anchorRoot.
	element := aManager element.
	inner := innerElement ifNil: [ element ].
	" take into accound the gap used to compute the textField padding "
	pos := (inner bounds inParent: root) topLeft
	       - ((element valueOfTokenNamed: #'padding-content-HS')
		        @ (element valueOfTokenNamed: #'padding-content-VS')).
	window position: pos
]

{ #category : #accessing }
ToElementEditorPlacement >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToElementEditorPlacement >> innerElement: anElement [

	innerElement := anElement
]
