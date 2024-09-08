"
I'm a stupid domain object.
"
Class {
	#name : #ToContactExampleObject,
	#superclass : #Object,
	#instVars : [
		'name',
		'phoneNumber',
		'address'
	],
	#category : #'Toplo-Examples-Parts'
}

{ #category : #accessing }
ToContactExampleObject >> address [

	^ address
]

{ #category : #accessing }
ToContactExampleObject >> address: anObject [

	address := anObject
]

{ #category : #accessing }
ToContactExampleObject >> name [

	^ name
]

{ #category : #accessing }
ToContactExampleObject >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ToContactExampleObject >> phoneNumber [

	^ phoneNumber
]

{ #category : #accessing }
ToContactExampleObject >> phoneNumber: anObject [

	phoneNumber := anObject
]
