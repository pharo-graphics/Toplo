Class {
	#name : #ToTooltipPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToTooltipPlacement >> arrangeWindowFromManager: aManager onEvent: anEvent [

	| window root element pos |
	window := aManager currentWindow.
	root := aManager anchorRoot.
	element := aManager element.

	pos :=  anEvent position x
		@ ((element localPointToGlobal: 0 @ element height) y + 5).
	window position: pos
]
