Class {
	#name : #ToCheckableCheckEvent,
	#superclass : #BlEvent,
	#instVars : [
		'previous',
		'current'
	],
	#category : 'Toplo-Widget-Button-Checkable'
}

{ #category : #'instance creation' }
ToCheckableCheckEvent class >> current: aBoolean previous: aPreviousBoolean [

	^ self new
		  current: aBoolean;
		  previous: aPreviousBoolean;
		  yourself
]

{ #category : #accessing }
ToCheckableCheckEvent >> current [

	^ current
]

{ #category : #accessing }
ToCheckableCheckEvent >> current: aBoolean [

	current := aBoolean
]

{ #category : #accessing }
ToCheckableCheckEvent >> previous [

	^ previous
]

{ #category : #accessing }
ToCheckableCheckEvent >> previous: aBoolean [

	previous := aBoolean
]

{ #category : #sending }
ToCheckableCheckEvent >> sendTo: anObject [

	anObject checkableCheckedEvent: self
]
