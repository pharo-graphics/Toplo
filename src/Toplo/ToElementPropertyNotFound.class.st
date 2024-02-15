Class {
	#name : #ToElementPropertyNotFound,
	#superclass : #Error,
	#instVars : [
		'stampName'
	],
	#category : 'Toplo-Core-Properties'
}

{ #category : #'instance creation' }
ToElementPropertyNotFound class >> name: anObject [

	^ self new stampName: anObject
]

{ #category : #accessing }
ToElementPropertyNotFound >> messageText [

	^ self stampName
		  ifNil: [ super messageText ]
		  ifNotNil: [ :n | n asString ]
]

{ #category : #accessing }
ToElementPropertyNotFound >> stampName [

	^ stampName
]

{ #category : #accessing }
ToElementPropertyNotFound >> stampName: anObject [

	stampName := anObject
]
