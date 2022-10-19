Class {
	#name : #ToAlbumLayer,
	#superclass : #BlOverlayElement,
	#instVars : [
		'delegator',
		'model'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #'api - attaching / detaching' }
ToAlbumLayer >> attachTo: anElement fromModel: anAlbumModel [

	model := anAlbumModel.
	self attachTo: anElement.
	delegator := BlEventDelegator delegate: BlEvent to: anElement. 
	self addEventHandler: delegator
]

{ #category : #'api - attaching / detaching' }
ToAlbumLayer >> detach [

	self removeEventHandler: delegator.
	delegator := nil.
	model := nil.
	super detach
]
