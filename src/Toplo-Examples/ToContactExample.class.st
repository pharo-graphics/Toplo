Class {
	#name : #ToContactExample,
	#superclass : #Object,
	#instVars : [
		'name',
		'phoneNumber',
		'address'
	],
	#category : 'Toplo-Examples'
}

{ #category : #accessing }
ToContactExample >> address [

	^ address
]

{ #category : #accessing }
ToContactExample >> address: anObject [

	address := anObject
]

{ #category : #accessing }
ToContactExample >> name [

	^ name
]

{ #category : #accessing }
ToContactExample >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToContactExample >> phoneNumber [

	^ phoneNumber
]

{ #category : #accessing }
ToContactExample >> phoneNumber: anObject [

	phoneNumber := anObject
]
