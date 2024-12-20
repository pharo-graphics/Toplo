Class {
	#name : #ToTooltipWindowStrategy,
	#superclass : #ToAnchoredWindowStrategy,
	#category : #'Toplo-Core-Window'
}

{ #category : #initialization }
ToTooltipWindowStrategy >> defaultPositionHook [

	^ [ :theWindow :theElement :event |
	  (event position x)
		  @ ((theElement localPointToGlobal: 0 @ theElement height) y + 5 ) ]
]
