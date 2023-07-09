Class {
	#name : #ToElementPropertyChanged,
	#superclass : #BlEvent,
	#instVars : [
		'previous',
		'current'
	],
	#category : #'Toplo-Core'
}

{ #category : #'instance creation' }
ToElementPropertyChanged class >> current: anObject previous: aPreviousObject [

	^ self new
		  current: anObject;
		  previous: aPreviousObject;
		  yourself
]

{ #category : #accessing }
ToElementPropertyChanged >> current [

	^ current
]

{ #category : #accessing }
ToElementPropertyChanged >> current: anObject [

	current := anObject
]

{ #category : #accessing }
ToElementPropertyChanged >> previous [

	^ previous
]

{ #category : #accessing }
ToElementPropertyChanged >> previous: anObject [

	previous := anObject
]
