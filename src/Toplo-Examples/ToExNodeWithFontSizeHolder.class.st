Class {
	#name : #ToExNodeWithFontSizeHolder,
	#superclass : #ToNodeHolder,
	#instVars : [
		'fontSize'
	],
	#category : #'Toplo-Examples-SandBox'
}

{ #category : #accessing }
ToExNodeWithFontSizeHolder >> fontSize [

	^ fontSize
]

{ #category : #accessing }
ToExNodeWithFontSizeHolder >> fontSize: aNumber [

	fontSize := aNumber
]
