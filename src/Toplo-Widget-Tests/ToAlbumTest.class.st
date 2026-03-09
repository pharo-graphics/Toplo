"
A ToAlbumTest is a test class for testing the behavior of ToAlbum
"
Class {
	#name : #ToAlbumTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Tests-Album'
}

{ #category : #tests }
ToAlbumTest >> testWithEditsFeedback [

	| a |
	a := ToAlbum new.
	a withEditsFeedback: false.
	self assert: a editsFeedbackLayer isNil.
	a withEditsFeedback: true.
	self assert: a editsFeedbackLayer notNil.

]
