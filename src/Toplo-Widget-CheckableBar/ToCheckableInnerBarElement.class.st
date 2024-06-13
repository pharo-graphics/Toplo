Class {
	#name : #ToCheckableInnerBarElement,
	#superclass : #ToInnerBarElement,
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #initialization }
ToCheckableInnerBarElement >> initialize [

	super initialize.
	self
		addEventHandlerOn: ToMainLayoutOrientationChangedEvent
		do: [ :event | event sendTo: self ]
]

{ #category : #layout }
ToCheckableInnerBarElement >> mainLayoutOrientationChangedEvent: anEvent [
]
