Class {
	#name : #ToWidgetLayer,
	#superclass : #BlOverlayElement,
	#instVars : [
		'delegator',
		'widget'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> attachTo: anElement from: aWidget [

	widget := aWidget.
	self attachTo: anElement.
	delegator := BlEventDelegator delegate: BlEvent to: anElement. 
	self addEventHandler: delegator
]

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> detach [

	self removeEventHandler: delegator.
	delegator := nil.
	widget := nil.
	super detach
]
