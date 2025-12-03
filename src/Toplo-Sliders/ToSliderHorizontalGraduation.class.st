Class {
	#name : #ToSliderHorizontalGraduation,
	#superclass : #ToElement,
	#instVars : [
		'minValue',
		'maxValue',
		'slider',
		'stepValue'
	],
	#category : #'Toplo-Sliders-Core'
}

{ #category : #initialization }
ToSliderHorizontalGraduation >> connectToSlider: aSlider [

	slider := aSlider.
	minValue := aSlider minValue.
	maxValue := aSlider maxValue.
	stepValue := maxValue - minValue / 4.
	self initializeStepGraduations.
	aSlider addChild: self
]

{ #category : #initialization }
ToSliderHorizontalGraduation >> initializeStepGraduations [
	| valueDiff |
	valueDiff := maxValue - minValue.

	minValue to: maxValue by: stepValue do: [ :value |
			| element |
			element := ToElement new
			background: Color black;
				           constraintsDo: [ :c |
						           c vertical matchParent.
						           c horizontal exact: 2.
						           c frame horizontal alignCenterAt:
								           value - minValue / valueDiff ].
			self addChild: element ]
]

{ #category : #skin }
ToSliderHorizontalGraduation >> newRawSkin [  

	^ ToSliderHorizontalGraduationSkin new
]

{ #category : #initialization }
ToSliderHorizontalGraduation >> reinitializeStepGraduations [

	self removeChildren.
	self initializeStepGraduations 
]

{ #category : #accessing }
ToSliderHorizontalGraduation >> slider [ 

	^ slider
]

{ #category : #accessing }
ToSliderHorizontalGraduation >> stepValue: aNumber [

	stepValue := aNumber.
	self reinitializeStepGraduations.
	"self ensuredSkinManager requestInstallSkinIn: self"
]
