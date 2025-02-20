Class {
	#name : #ToTooltipPlacement,
	#superclass : #ToElementCustomPlacement,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'api - displaying' }
ToTooltipPlacement >> positionElement: aWindow onEvent: anEvent context: aBlElementBoundsUpdateContext [

	| root element pos |
	root := aWindow anchorRoot.
	element := aWindow anchorElement.

	pos := anEvent position x
	       @ ((element localPointToGlobal: 0 @ element height) y + 5).
	aWindow position: pos
]
