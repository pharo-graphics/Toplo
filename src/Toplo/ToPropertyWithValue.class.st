Class {
	#name : 'ToPropertyWithValue',
	#superclass : 'ToAbstractProperty',
	#instVars : [
		'value'
	],
	#category : 'Toplo-Core-Properties',
	#package : 'Toplo',
	#tag : 'Core-Properties'
}

{ #category : 'accessing' }
ToPropertyWithValue class >> name: aSymbol [

	^ self new name: aSymbol asSymbol
]

{ #category : 'accessing' }
ToPropertyWithValue class >> name: aSymbol value: anObject [

	^ (self name: aSymbol)
		  value: anObject;
		  yourself
]

{ #category : 'accessing' }
ToPropertyWithValue >> value [

	^ value
]

{ #category : 'accessing' }
ToPropertyWithValue >> value: anObject [

	value := anObject
]
