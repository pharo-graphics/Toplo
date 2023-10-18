Class {
	#name : #ToStyleStamp,
	#superclass : #ToElementProperty,
	#instVars : [
		'value'
	],
	#category : 'Toplo-Core-Properties'
}

{ #category : #accessing }
ToStyleStamp class >> asStyleStamp [ 

	^ self
]

{ #category : #accessing }
ToStyleStamp class >> name: aSymbol [

	^ self new name: aSymbol asSymbol
]

{ #category : #accessing }
ToStyleStamp class >> name: aSymbol value: anObject [

	^ (self name: aSymbol)
		  value: anObject;
		  yourself
]

{ #category : #operating }
ToStyleStamp >> read: anObject [

	^ self value value: anObject
]

{ #category : #evaluating }
ToStyleStamp >> value [

	^ value
]

{ #category : #accessing }
ToStyleStamp >> value: anObject [

	value := anObject
]
