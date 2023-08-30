Class {
	#name : #ToPropertyChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'holder',
		'slotName',
		'previous',
		'current'
	],
	#category : #'Toplo-Core-Slots'
}

{ #category : #'instance creation' }
ToPropertyChangedEvent class >> current: anObject previous: aPreviousObject [

	^ self new
		  current: anObject;
		  previous: aPreviousObject;
		  yourself
]

{ #category : #accessing }
ToPropertyChangedEvent >> current [

	^ current
]

{ #category : #accessing }
ToPropertyChangedEvent >> current: anObject [

	current := anObject
]

{ #category : #accessing }
ToPropertyChangedEvent >> holder [

	^ holder
]

{ #category : #accessing }
ToPropertyChangedEvent >> holder: anObject [

	holder := anObject
]

{ #category : #accessing }
ToPropertyChangedEvent >> previous [

	^ previous
]

{ #category : #accessing }
ToPropertyChangedEvent >> previous: anObject [

	previous := anObject
]

{ #category : #sending }
ToPropertyChangedEvent >> sendTo: anObject [

	anObject propertyChangedEvent: self
]

{ #category : #accessing }
ToPropertyChangedEvent >> slotName [

	^ slotName
]

{ #category : #accessing }
ToPropertyChangedEvent >> slotName: aSymbol [

	slotName := aSymbol
]
