"
A ToAlbumTest is a test class for testing the behavior of ToAlbum
"
Class {
	#name : #ToAlbumTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Album-Tests-TextPane'
}

{ #category : #tests }
ToAlbumTest >> testFocusGoesToTheEditor [

	| album |
	album := ToAlbum new.
	self assert: album focusDelegate identicalTo: album infinite focusDelegate
]

{ #category : #tests }
ToAlbumTest >> testWithEditsFeedback [

	| a |
	a := ToAlbum new.
	a withEditsFeedback: false.
	self assert: a editsFeedbackLayer isNil.
	a withEditsFeedback: true.
	self assert: a editsFeedbackLayer isNotNil.

]
