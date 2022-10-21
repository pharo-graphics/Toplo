Class {
	#name : #ToWidgetLayer,
	#superclass : #BlOverlayElement,
	#instVars : [
		'delegator',
		'model'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> attachTo: anElement fromModel: anAlbumModel [

	model := anAlbumModel.
	self attachTo: anElement.
	delegator := BlEventDelegator delegate: BlEvent to: anElement. 
	self addEventHandler: delegator
]

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> detach [

	self removeEventHandler: delegator.
	delegator := nil.
	model := nil.
	super detach
]
