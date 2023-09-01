"
Text property controls how the ""input text"" fields (`ToTextInputFieldPresenter` hierarchy for now)
"
Class {
	#name : #ToTextStyle,
	#superclass : #ToPropertyStyle,
	#instVars : [
		'drawKeyboardFocus'
	],
	#category : #'Toplo-StyleSheet'
}

{ #category : #'ston-core' }
ToTextStyle class >> stonName [
	
	^ 'Text'
]

{ #category : #operations }
ToTextStyle >> applyTo: aWidget [


	self drawKeyboardFocusVariable
		ifNotNil: [ :aVariable | aWidget drawKeyboardFocus: aVariable value ]
]

{ #category : #accessing }
ToTextStyle >> drawKeyboardFocus [

	^ self drawKeyboardFocusVariable value
]

{ #category : #accessing }
ToTextStyle >> drawKeyboardFocus: aBoolean [

	drawKeyboardFocus := aBoolean asStyleVariable
]

{ #category : #'accessing - variables' }
ToTextStyle >> drawKeyboardFocusVariable [

	^ self toVariable: drawKeyboardFocus
]
