Class {
	#name : #ToPopupWindowStrategy,
	#superclass : #ToAnchoredWindowStrategy,
	#category : #'Toplo-Core-Window'
}

{ #category : #initialization }
ToPopupWindowStrategy >> defaultPositionHook [

	^ [ :window :theElement :event |
	  (theElement bounds inParent: self anchorRoot) bounds bottomLeft ]
]
