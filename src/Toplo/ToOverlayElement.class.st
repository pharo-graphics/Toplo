Class {
	#name : #ToOverlayElement,
	#superclass : #BlOverlayElement,
	#traits : 'TBlLayoutResizable',
	#classTraits : 'TBlLayoutResizable classTrait',
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
		  ifNotNil: [ sizeHook value: referenceElement value: anExtent ]
]

{ #category : #'hook - geometry' }
ToOverlayElement >> positionFrom: aPosition [

	^ positionHook
		  ifNil: [ super positionFrom: aPosition ]
		  ifNotNil: [ positionHook value: referenceElement value: aPosition ]
]

{ #category : #accessing }
ToOverlayElement >> positionHook [

	^ positionHook
]

{ #category : #accessing }
ToOverlayElement >> positionHook: aValuable [
	" 
	Computes the overlay position according to the attached element position.
	aValuable takes the attached element as first arg, the candidate overlay position as second arg 
	and return the new overlay element position. 
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
	aValuable takes the attached element as first arg, the candidate overlay size as second arg 
	and return the new overlay element size.
	"

	sizeHook := aValuable
]
