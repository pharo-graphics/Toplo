Class {
	#name : 'ToOverlayWindowManager',
	#superclass : 'ToAnchoredWindowManager',
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'initialization' }
ToOverlayWindowManager >> defaultSizeHook [

	^ [ :event :theElement | theElement size ]
]

{ #category : 'accessing' }
ToOverlayWindowManager >> elementEventHandlerClass [

	^ ToOverlayedEventHandler 
]
