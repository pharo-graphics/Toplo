Class {
	#name : #ToPropertySkinChangedEvent,
	#superclass : #ToPropertyChangedEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToPropertySkinChangedEvent >> sendTo: anObject [

	anObject propertySkinChangedEvent: self
]
