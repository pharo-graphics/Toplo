Class {
	#name : #ToElementPropertyChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'previous',
		'current'
	],
	#category : #'Toplo-Core'
}

{ #category : #'instance creation' }
ToElementPropertyChangedEvent class >> current: anObject previous: aPreviousObject [

	^ self new
		  current: anObject;
		  previous: aPreviousObject;
		  yourself
]

{ #category : #accessing }
ToElementPropertyChangedEvent >> current [

	^ current
]

{ #category : #accessing }
ToElementPropertyChangedEvent >> current: anObject [

	current := anObject
]

{ #category : #accessing }
ToElementPropertyChangedEvent >> previous [

	^ previous
]

{ #category : #accessing }
ToElementPropertyChangedEvent >> previous: anObject [

	previous := anObject
]
