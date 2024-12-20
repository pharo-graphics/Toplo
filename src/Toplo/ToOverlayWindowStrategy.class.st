Class {
	#name : #ToOverlayWindowStrategy,
	#superclass : #ToAnchoredWindowStrategy,
	#category : #'Toplo-Core-Window'
}

{ #category : #'as yet unclassified' }
ToOverlayWindowStrategy >> defaultHeightHook [

	^ [ :theWindow :theElement :event |
	  theElement measuredHeight ]
]

{ #category : #'as yet unclassified' }
ToOverlayWindowStrategy >> defaultWidthHook [

	^ [ :theWindow :theElement :event |
	  theElement measuredWidth ]
]
