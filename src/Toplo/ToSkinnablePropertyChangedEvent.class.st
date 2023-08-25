Class {
	#name : #ToSkinnablePropertyChangedEvent,
	#superclass : #ToPropertyChangedEvent,
	#instVars : [
		'holder',
		'slotName'
	],
	#category : #'Toplo-Core-Slots'
}

{ #category : #accessing }
ToSkinnablePropertyChangedEvent >> holder [

	^ holder
]

{ #category : #accessing }
ToSkinnablePropertyChangedEvent >> holder: anObject [

	holder := anObject
]

{ #category : #sending }
ToSkinnablePropertyChangedEvent >> sendTo: anObject [

	anObject skinnablePropertyChangedEvent: self
]

{ #category : #accessing }
ToSkinnablePropertyChangedEvent >> slotName [

	^ slotName
]

{ #category : #accessing }
ToSkinnablePropertyChangedEvent >> slotName: aSymbol [

	slotName := aSymbol
]
