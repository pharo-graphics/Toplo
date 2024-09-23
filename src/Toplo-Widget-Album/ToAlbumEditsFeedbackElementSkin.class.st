Class {
	#name : #ToAlbumEditsFeedbackElementSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAlbumEditsFeedbackElementSkin >> disabledSkinEvent: anEvent [

	| baseColor |
	super disabledSkinEvent: anEvent.
	baseColor := Color gray.
	anEvent elementDo: [ :e |
		e background:
			((BlLinearGradientPaint direction: 1 @ 1)
				 start: 25 @ 0;
				 stops: {
						 (0 -> baseColor).
						 (0.35 -> (baseColor alpha: 0.4)).
						 (0.45 -> (baseColor alpha: 0.1)).
						 (0.50 -> (baseColor alpha: 0.0)).
						 (1 -> Color transparent) }) ]
]

{ #category : #'event handling' }
ToAlbumEditsFeedbackElementSkin >> enabledSkinEvent: anEvent [

	| baseColor |
	super enabledSkinEvent: anEvent.
	baseColor := Color orange.
	anEvent elementDo: [ :e |
		e background:
			((BlLinearGradientPaint direction: 1 @ 1)
				 start: 25 @ 0;
				 stops: {
						 (0 -> baseColor).
						 (0.35 -> (baseColor alpha: 0.4)).
						 (0.45 -> (baseColor alpha: 0.1)).
						 (0.50 -> (baseColor alpha: 0.0)).
						 (1 -> Color transparent) }) ]
]

{ #category : #'event handling' }
ToAlbumEditsFeedbackElementSkin >> focusedSkinEvent: anEvent [

	| baseColor |
	super focusedSkinEvent: anEvent.
	baseColor := Color orange alpha: 0.5.
	anEvent elementDo: [ :e |
		e background:
			((BlLinearGradientPaint direction: 1 @ 1)
				 start: 25 @ 0;
				 stops: {
						 (0 -> baseColor).
						 (0.35 -> (baseColor alpha: 0.4)).
						 (0.45 -> (baseColor alpha: 0.1)).
						 (0.50 -> (baseColor alpha: 0.0)).
						 (1 -> Color transparent) }) ]
]

{ #category : #'event handling' }
ToAlbumEditsFeedbackElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e geometry: (BlRoundedRectangleGeometry cornerRadius:
				 (e valueOfTokenNamed: 'border-radius')) ]
]

{ #category : #'event handling' }
ToAlbumEditsFeedbackElementSkin >> unfocusedSkinEvent: anEvent [

	| baseColor |
	super unfocusedSkinEvent: anEvent.
	baseColor := Color red.
	anEvent elementDo: [ :e |
		e background:
			((BlLinearGradientPaint direction: 1 @ 1)
				 start: 25 @ 0;
				 stops: {
						 (0 -> baseColor).
						 (0.35 -> (baseColor alpha: 0.4)).
						 (0.45 -> (baseColor alpha: 0.1)).
						 (0.50 -> (baseColor alpha: 0.0)).
						 (1 -> Color transparent) }) ]
]
