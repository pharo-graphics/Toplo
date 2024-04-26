Class {
	#name : #ToOverlayElement,
	#superclass : #BlOverlayElement,
	#instVars : [
		'positionHook',
		'sizeHook'
	],
	#category : #'Toplo-Core'
}

{ #category : #'hook - geometry' }
ToOverlayElement >> extentFrom: anExtent [

	^ sizeHook
		  ifNil: [ super extentFrom: anExtent ]
		  ifNotNil: [ sizeHook value: anExtent ]
]

{ #category : #'hook - geometry' }
ToOverlayElement >> positionFrom: aPosition [

	^ positionHook
		  ifNil: [ super positionFrom: aPosition ]
		  ifNotNil: [ positionHook value: aPosition ]
]

{ #category : #accessing }
ToOverlayElement >> positionHook [

	^ positionHook
]

{ #category : #accessing }
ToOverlayElement >> positionHook: aValuable [
	" 
	Computes the overlay position according to the attached element position.
	aValuable takes the attached element position as first arg and return the overlay element position. 
	 "
	
	positionHook := aValuable
]

{ #category : #accessing }
ToOverlayElement >> sizeHook [
	
	^ sizeHook
]

{ #category : #accessing }
ToOverlayElement >> sizeHook: aValuable [
	" 
	Computes the overlay size according to the attached element size.
	aValuable takes the attached element size as first arg and return the overlay element size. 
	"

	sizeHook := aValuable
]
