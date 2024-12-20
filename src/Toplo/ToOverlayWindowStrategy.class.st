Class {
	#name : #ToOverlayWindowStrategy,
	#superclass : #ToAnchoredWindowStrategy,
	#category : #'Toplo-Core-Window'
}

{ #category : #initialization }
ToOverlayWindowStrategy >> defaultHeightHook [

	^ [ :theWindow :theElement :event |
	  theElement measuredHeight ]
]

{ #category : #initialization }
ToOverlayWindowStrategy >> defaultWidthHook [

	^ [ :theWindow :theElement :event |
	  theElement measuredWidth ]
]
