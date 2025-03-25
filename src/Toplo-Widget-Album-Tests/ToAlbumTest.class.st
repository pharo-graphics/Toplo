"
A ToAlbumTest is a test class for testing the behavior of ToAlbum
"
Class {
	#name : #ToAlbumTest,
	#superclass : #TestCase,
	#category : #'Toplo-Widget-Album-Tests-TextPane'
}

{ #category : #tests }
ToAlbumTest >> testWithoutEditsFeedback [

	self flag: #toImplement.
	self assert: false
]
