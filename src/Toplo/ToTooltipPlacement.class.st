Class {
	#name : #ToTooltipPlacement,
	#superclass : #ToWindowPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToTooltipPlacement >> arrangeWindow: aWindow forElement: anElement fromEvent: anEvent in: aRootElement [

	aWindow position: anEvent position x
		@ ((anElement localPointToGlobal: 0 @ anElement height) y + 5)
]
