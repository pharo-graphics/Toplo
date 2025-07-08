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

	a := ToAlbum new extent: 100 asPoint.
	space root addChild: a.
	self deny: a hasFocus.
	focusCount := 0.
	a
		addEventHandlerOn: ToFocusedSkinEvent
		do: [ :event | focusCount := focusCount + 1 ].
	a requestFocus.
	self waitTestingSpaces.
	space applyAllSkinPhases.
	self assert: focusCount equals: 1
]

{ #category : #tests }
ToAlbumSkinTest >> testUnfocusedSkinEvent [

	| a1 a2 unfocusCount |

	a1 := ToAlbum new extent: 100 asPoint.
	a2 := ToAlbum new extent: 100 asPoint.
	space root addChild: a1.
	space root addChild: a2.
	self deny: a1 hasFocus.
	self deny: a2 hasFocus.
	unfocusCount := 0.
	a2
		addEventHandlerOn: ToUnfocusedSkinEvent
		do: [ :event | unfocusCount := unfocusCount + 1 ].
	a2 requestFocus.
	self waitTestingSpaces.
	space applyAllSkinPhases.
	a1 requestFocus.
	self waitTestingSpaces.
	space applyAllSkinPhases.
	self assert: unfocusCount equals: 1
	
]
