Class {
	#name : #ToOverlayWindowManager,
	#superclass : #ToAnchoredWindowManager,
	#category : #'Toplo-Core-Window'
}

{ #category : #initialization }
ToOverlayWindowManager >> defaultHeightHook [

	^ [ :theWindow :theElement :event |
	  theElement measuredHeight ]
]

{ #category : #initialization }
ToOverlayWindowManager >> defaultWidthHook [

	^ [ :theWindow :theElement :event |
	  theElement measuredWidth ]
]

{ #category : #'event handling' }
ToOverlayWindowManager >> elementExtentChangedEvent: anEvent [

	super elementExtentChangedEvent: anEvent.
	self applySizeHookFromEvent: anEvent
]
