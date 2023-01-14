Class {
	#name : #ToWidgetLayer,
	#superclass : #BlOverlayElement,
	#instVars : [
		'widget'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> attachTo: anElement from: aWidget [

	widget := aWidget.
	self attachTo: anElement
]

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> detach [

	widget := nil.
	super detach
]
