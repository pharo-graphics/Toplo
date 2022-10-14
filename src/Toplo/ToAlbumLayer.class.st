Class {
	#name : #ToAlbumLayer,
	#superclass : #BlOverlayElement,
	#instVars : [
		'delegator'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #'api - attaching / detaching' }
ToAlbumLayer >> attachTo: anElement [

	super attachTo: anElement.
	delegator := BlEventDelegator delegate: BlEvent to: anElement. 
	self addEventHandler: delegator
]

{ #category : #'api - attaching / detaching' }
ToAlbumLayer >> detach [

	self removeEventHandler: delegator.
	delegator := nil.
	super detach
]
