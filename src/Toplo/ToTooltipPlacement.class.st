Class {
	#name : #ToTooltipPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #api }
ToTooltipPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element pos |
	root := aWindow anchorRoot.
	element := aWindow element.

	pos :=  anEvent position x
		@ ((element localPointToGlobal: 0 @ element height) y + 5).
	aWindow position: pos
]
