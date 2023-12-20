Class {
	#name : 'ToOverlayWindowManager',
	#superclass : 'ToAnchoredWindowManager',
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'initialization' }
ToOverlayWindowManager >> defaultHeightHook [

	^ [ :event :theElement | theElement measuredHeight ]
]

{ #category : 'initialization' }
ToOverlayWindowManager >> defaultWidthHook [

	^ [ :event :theElement | theElement measuredWidth ]
]

{ #category : 'accessing' }
ToOverlayWindowManager >> elementEventHandlerClass [

	^ ToOverlayedEventHandler 
]
