"
A ToAlbumTest is a test class for testing the behavior of ToAlbum
"
Class {
	#name : #ToAlbumSkinTest,
	#superclass : #ToParameterizedHostTest,
	#category : #'Toplo-Widget-Album-Tests-TextPane'
}

{ #category : #tests }
ToAlbumSkinTest >> testFocusedSkinEvent [

	| a focusCount |
	a := ToAlbum new.
	a extent: 100 asPoint.
	self deny: a hasFocus.
	focusCount := 0.
	a
		addEventHandlerOn: ToFocusedSkinEvent
		do: [ :event | focusCount := focusCount + 1 ].

	space deferAndSettle: [ space root addChild: a ].
	self assert: focusCount equals: 0.

	space deferAndSettle: [ a requestFocus ].
	self assert: focusCount equals: 1
]

{ #category : #tests }
ToAlbumSkinTest >> testUnfocusedSkinEvent [

	| a1 a2 unfocusCount |
	a1 := ToListElement new extent: 100 asPoint.
	a2 := ToAlbum new extent: 100 asPoint.
	space deferAndSettle: [ 
		space root addChild: a1.
		space root addChild: a2 ].
	self deny: a1 isFocused.
	self deny: a2 isFocused.
	unfocusCount := 0.
	a2
		addEventHandlerOn: ToUnfocusedSkinEvent
		do: [ :event | unfocusCount := unfocusCount + 1 ].
	space deferAndSettle: [ a2 requestFocus ].
	"Must be in a separate block to allow skin state updates of the first focus change to be processed"
	space deferAndSettle: [ a1 requestFocus ].
	self assert: a1 isFocused.
	self deny: a2 isFocused.
	self assert: unfocusCount equals: 1
]
