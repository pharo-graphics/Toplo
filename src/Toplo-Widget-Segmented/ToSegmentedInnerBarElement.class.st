Class {
	#name : #ToSegmentedInnerBarElement,
	#superclass : #ToInnerBarElement,
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #initialization }
ToSegmentedInnerBarElement >> initialize [

	super initialize.
	self addEventHandlerOn: ToMainLayoutOrientationChangedEvent do: [ :event | event sendTo: self ]
]

{ #category : #layout }
ToSegmentedInnerBarElement >> mainLayoutOrientationChangedEvent: anEvent [
]
