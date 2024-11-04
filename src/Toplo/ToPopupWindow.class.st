Class {
	#name : #ToPopupWindow,
	#superclass : #ToAnchoredWindow,
	#category : #'Toplo-Core-Window'
}

{ #category : #'api - displaying' }
ToPopupWindow >> close [ 

	windowManager element preventMousePickOutsideEvent.
	super close
]

{ #category : #'api - displaying' }
ToPopupWindow >> popupEvent: anEvent [

	windowManager element allowMousePickOutsideEvent.
	^ super popupEvent: anEvent
]
