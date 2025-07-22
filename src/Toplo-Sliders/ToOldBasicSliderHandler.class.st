Class {
	#name : #ToOldBasicSliderHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Sliders-Core'
}

{ #category : #'event management' }
ToOldBasicSliderHandler >> clickEvent: anEvent [

	anEvent currentTarget sliderBarClicked: anEvent
]

{ #category : #'event management' }
ToOldBasicSliderHandler >> dragEndEvent: anEvent [

	anEvent currentTarget sliderHandleReleased
]

{ #category : #'event management' }
ToOldBasicSliderHandler >> eventsToHandle [
	^ { BlMouseDownEvent . BlDragEndEvent . BlMouseUpEvent . BlMouseMoveEvent . BlClickEvent}
]

{ #category : #'event management' }
ToOldBasicSliderHandler >> mouseDownEvent: anEvent [

	anEvent currentTarget sliderHandlePushed: anEvent
]

{ #category : #'event management' }
ToOldBasicSliderHandler >> mouseMoveEvent: anEvent [

	anEvent currentTarget sliderHandleMoved: anEvent
]

{ #category : #'event management' }
ToOldBasicSliderHandler >> mouseUpEvent: anEvent [

	anEvent currentTarget sliderHandleReleased
]
