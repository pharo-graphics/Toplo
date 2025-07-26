Class {
	#name : #ToConfigurationAppliedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToConfigurationAppliedEvent >> sendTo: anObject [

	anObject configurationAppliedEvent: self
]
