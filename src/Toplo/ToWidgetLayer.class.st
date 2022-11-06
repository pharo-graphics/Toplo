Class {
	#name : #ToWidgetLayer,
	#superclass : #BlOverlayElement,
	#instVars : [
		'delegator',
		'viewModel'
	],
	#category : #'Toplo-Core'
}

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> attachTo: anElement from: aViewModel [

	viewModel := aViewModel.
	self attachTo: anElement.
	delegator := BlEventDelegator delegate: BlEvent to: anElement. 
	self addEventHandler: delegator
]

{ #category : #'api - attaching / detaching' }
ToWidgetLayer >> detach [

	self removeEventHandler: delegator.
	delegator := nil.
	viewModel := nil.
	super detach
]
