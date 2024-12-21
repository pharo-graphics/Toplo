Class {
	#name : #ToLabelEditorPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToLabelEditorPlacement >> arrangeWindow: aWindow forElement: anElement fromEvent: anEvent in: aRootElement [

	| pos |
	" take into accound the gap used to compute the textField padding "
	pos := (anElement boundsForEditor inParent: aRootElement) topLeft
	       - ((anElement valueOfTokenNamed: #'padding-content-HS')
		        @ (anElement valueOfTokenNamed: #'padding-content-VS')).
	aWindow position: pos
]
