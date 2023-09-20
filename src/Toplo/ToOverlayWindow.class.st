Class {
	#name : 'ToOverlayWindow',
	#superclass : 'ToWidgetWindowElement',
	#category : 'Toplo-Core-Window',
	#package : 'Toplo',
	#tag : 'Core-Window'
}

{ #category : 'api - displaying' }
ToOverlayWindow >> checkBeforePopupIn: aWidget [

	" aWindow bounds are up-to-date, I can be visible "
	self size: self widget size.
	super checkBeforePopupIn: aWidget
]

{ #category : 'initialization' }
ToOverlayWindow >> defaulPositioningHook [

	^ [ :w :event | w widget bounds inSpace bounds topLeft ]
]

{ #category : 't - initialization dresser' }
ToOverlayWindow >> defaultDresser [ 

	^ ToOverlayWindowDresser new
]
