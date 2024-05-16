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

{ #category : #accessing }
ToOverlayWindowManager >> elementEventHandlerClass [

	^ ToOverlayedEventHandler 
]

{ #category : #accessing }
ToOverlayWindowManager >> windowClosedEventClass [

	^ ToOverlayWindowClosedEvent
]

{ #category : #accessing }
ToOverlayWindowManager >> windowOpenedEventClass [

	^ ToOverlayWindowOpenedEvent
]
