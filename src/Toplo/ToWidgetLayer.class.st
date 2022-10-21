Class {
	#name : #ToWidgetLayer,
	#superclass : #BlOverlayElement,
	#instVars : [
		'delegator',
		'client'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> attachTo: anElement from: aClient [

	client := aClient.
	self attachTo: anElement.
	delegator := BlEventDelegator delegate: BlEvent to: anElement. 
	self addEventHandler: delegator
]

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> detach [

	self removeEventHandler: delegator.
	delegator := nil.
	client := nil.
	super detach
]
