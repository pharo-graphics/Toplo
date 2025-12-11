Class {
	#name : #ToTokenPropertyNotFoundError,
	#superclass : #Error,
	#instVars : [
		'stampName'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #'instance creation' }
ToTokenPropertyNotFoundError class >> name: anObject [

	^ self new stampName: anObject
]

{ #category : #accessing }
ToTokenPropertyNotFoundError >> messageText [

	^ self stampName
		  ifNil: [ super messageText ]
		  ifNotNil: [ :n | n asString ]
]

{ #category : #accessing }
ToTokenPropertyNotFoundError >> stampName [

	^ stampName
]

{ #category : #accessing }
ToTokenPropertyNotFoundError >> stampName: anObject [

	stampName := anObject
]
