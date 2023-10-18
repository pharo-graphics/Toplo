Class {
	#name : #ToCheckableCheckedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'previous',
		'current'
	],
	#category : 'Toplo-Widget-Button-Checkable'
}

{ #category : #'instance creation' }
ToCheckableCheckedEvent class >> current: aBoolean previous: aPreviousBoolean [

	^ self new
		  current: aBoolean;
		  previous: aPreviousBoolean;
		  yourself
]

{ #category : #accessing }
ToCheckableCheckedEvent >> current [

	^ current
]

{ #category : #accessing }
ToCheckableCheckedEvent >> current: aBoolean [

	current := aBoolean
]

{ #category : #accessing }
ToCheckableCheckedEvent >> previous [

	^ previous
]

{ #category : #accessing }
ToCheckableCheckedEvent >> previous: aBoolean [

	previous := aBoolean
]

{ #category : #sending }
ToCheckableCheckedEvent >> sendTo: anObject [

	anObject checkableCheckEvent: self
]
