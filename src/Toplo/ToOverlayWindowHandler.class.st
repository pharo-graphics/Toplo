Class {
	#name : #ToOverlayWindowHandler,
	#superclass : #ToAnchoredWindowHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #initialization }
ToOverlayWindowHandler >> defaulSizeHook [

	^ [ :event | element size ]
]

{ #category : #accessing }
ToOverlayWindowHandler >> elementEventHandlerClass [

	^ ToOverlayedEventHandler 
]
