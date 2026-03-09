Class {
	#name : #ToTextPane,
	#superclass : #ToAlbum,
	#category : #'Toplo-Widget-Album'
}

{ #category : #configuration }
ToTextPane >> applyConfiguration [

	super applyConfiguration.

	self infinite vFitContent.
	self next next vFitContent.
	self configureScrollbar
]

{ #category : #configuration }
ToTextPane >> scrollbarTarget [

	^ self next
]
