Class {
	#name : #ToChildSkin,
	#superclass : #Object,
	#instVars : [
		'skinBuilder',
		'slotName'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #accessing }
ToChildSkin >> skinBuilder [

	^ skinBuilder
]

{ #category : #accessing }
ToChildSkin >> skinBuilder: aValuable [

	skinBuilder := aValuable
]

{ #category : #accessing }
ToChildSkin >> slotName [

	^ slotName
]

{ #category : #accessing }
ToChildSkin >> slotName: aSymbol [

	slotName := aSymbol
]

{ #category : #'skin updating' }
ToChildSkin >> updateIn: anElement [

	| childElement skin |
	childElement := anElement instVarNamed: self slotName.
	childElement ifNil: [ ^ self ].
	skin := self skinBuilder value: anElement.
	childElement withSkin: skin

]
