Class {
	#name : #ToGaussianEffectAnimation,
	#superclass : #BlAnimation,
	#instVars : [
		'to',
		'from',
		'color',
		'width'
	],
	#category : #'Toplo-Examples'
}

{ #category : #pulse }
ToGaussianEffectAnimation >> applyValue: anOpacity [

	self target effect: (BlGaussianShadowEffect
			 color: (self color alpha: anOpacity)
			 width: self width
			 offset: 0 @ 0).
]

{ #category : #accessing }
ToGaussianEffectAnimation >> color [
	"Set desired opacity of an element at the end of animation"

	^ color ifNil: [ color := Color gray ]
]

{ #category : #accessing }
ToGaussianEffectAnimation >> color: aColor [
	"Set desired opacity of an element at the end of animation"

	color := aColor
]

{ #category : #pulse }
ToGaussianEffectAnimation >> initStart [

	super initStart.
	from := self target opacity
]

{ #category : #accessing }
ToGaussianEffectAnimation >> opacity: aNumber [
	"Set desired opacity of an element at the end of animation"

	to := aNumber
]

{ #category : #pulse }
ToGaussianEffectAnimation >> valueForStep: aNumber [

	^ ((to - from ) * aNumber) + from
]

{ #category : #accessing }
ToGaussianEffectAnimation >> width [
	"Set desired opacity "

	^ width 
]

{ #category : #accessing }
ToGaussianEffectAnimation >> width: aNumber [

	width := aNumber
]
