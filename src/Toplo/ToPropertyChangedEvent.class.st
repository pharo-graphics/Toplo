Class {
	#name : #ToPropertyChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'propertyName',
		'previous',
		'current'
	],
	#category : #'Toplo-Core'
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
ToPropertyChangedEvent >> previous [

	^ previous
]

{ #category : #accessing }
ToPropertyChangedEvent >> previous: anObject [

	previous := anObject
]

{ #category : #accessing }
ToPropertyChangedEvent >> propertyName [

	^ propertyName
]

{ #category : #accessing }
ToPropertyChangedEvent >> propertyName: aString [

	propertyName := aString
]
