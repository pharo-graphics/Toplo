Class {
	#name : #ToOverlayWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#category : #'Toplo-Core-Window'
}

{ #category : #initialization }
ToOverlayWindowManager >> defaultSizeHook [

	^ [ :theWindow :theElement :event |
	  theWindow size: theElement measuredWidth @ theElement measuredHeight ]
]

{ #category : #'event handling' }
ToOverlayWindowManager >> elementExtentChangedEvent: anEvent [

	super elementExtentChangedEvent: anEvent.
	self applySizeHookFromEvent: anEvent
]
