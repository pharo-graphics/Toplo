Class {
	#name : #ToPropertyValueChangedEvent,
	#superclass : #ToPropertyChangedEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToPropertyValueChangedEvent >> sendTo: anObject [

	anObject propertyValueChangedEvent: self
]
