Class {
	#name : 'ToOverlayWindowHandler',
	#superclass : 'ToAnchoredWindowHandler',
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'initialization' }
ToOverlayWindowHandler >> defaulSizeHook [

	^ [ :event :theElement | theElement size ]
]

{ #category : 'accessing' }
ToOverlayWindowHandler >> elementEventHandlerClass [

	^ ToOverlayedEventHandler 
]
