Class {
	#name : #ToWidgetConfigurationAppliedEvent,
	#superclass : #BlEvent,
	#category : #'Toplo-Core'
}

{ #category : #sending }
ToWidgetConfigurationAppliedEvent >> sendTo: anObject [

	anObject widgetConfigurationAppliedEvent: self
]
