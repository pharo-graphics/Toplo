Class {
	#name : #ToButtonBorderBasedAutomatonEventHandler,
	#superclass : #ToButtonAutomatonEventHandler,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'event handler' }
ToButtonBorderBasedAutomatonEventHandler >> elementBorderChangedEvent: anEvent [

	dresser initialBorder: button border
]

{ #category : #'api - accessing' }
ToButtonBorderBasedAutomatonEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementBorderChangedEvent }
]
