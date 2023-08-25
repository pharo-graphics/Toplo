Class {
	#name : #ToChildSkinBuilder,
	#superclass : #Object,
	#instVars : [
		'skinBuilder',
		'slotName'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #accessing }
ToChildSkinBuilder >> builder [

	^ skinBuilder
]

{ #category : #accessing }
ToChildSkinBuilder >> builder: aValuable [

	skinBuilder := aValuable
]

{ #category : #accessing }
ToChildSkinBuilder >> slotName [

	^ slotName
]

{ #category : #accessing }
ToChildSkinBuilder >> slotName: aSymbol [

	slotName := aSymbol
]

{ #category : #'skin updating' }
ToChildSkinBuilder >> updateIn: anElement [

	| childElement skin |
	childElement := anElement instVarNamed: self slotName.
	childElement ifNil: [ ^ self ].
	skin := self builder value: anElement.
	childElement withSkin: skin

]
