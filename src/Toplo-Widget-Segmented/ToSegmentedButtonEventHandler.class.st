Class {
	#name : #ToSegmentedButtonEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Segmented-Button'
}

{ #category : #'event handling' }
ToSegmentedButtonEventHandler >> checkableChangedEvent: anEvent [
]

{ #category : #'api - accessing' }
ToSegmentedButtonEventHandler >> eventsToHandle [

	^ { ToCheckableChangedEvent. "BlClickEvent" }
]
