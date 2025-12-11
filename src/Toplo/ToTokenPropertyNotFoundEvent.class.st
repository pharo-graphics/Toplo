Class {
	#name : #ToTokenPropertyNotFoundEvent,
	#superclass : #BlEvent,
	#instVars : [
		'name'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToTokenPropertyNotFoundEvent >> name [

	^ name
]

{ #category : #accessing }
ToTokenPropertyNotFoundEvent >> name: aSymbol [

	name := aSymbol
]
