Class {
	#name : #ToSelectEventHandler,
	#superclass : #ToElementWithPopupEventHandler,
	#category : #'Toplo-Widget-Select'
}

{ #category : #'element handlers' }
ToSelectEventHandler >> elementExtentChangedEvent: anEvent [

	windowManager currentWindow ifNil: [ ^ self ].
	windowManager applyPositionHookFromEvent: anEvent.
	windowManager applySizeHookFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToSelectEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementExtentChangedEvent }
]
