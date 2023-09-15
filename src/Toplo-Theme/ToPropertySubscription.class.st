Class {
	#name : #ToPropertySubscription,
	#superclass : #ToLookEventSubscription,
	#instVars : [
		'value',
		'property',
		'animation'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToPropertySubscription >> animation [

	^ animation
]

{ #category : #accessing }
ToPropertySubscription >> animation: aPropertyAnimation [

	animation := aPropertyAnimation.
	animation ifNil: [ ^self ].
	animation property: self property
]

{ #category : #testing }
ToPropertySubscription >> isPropertyBased [

	^ true
]

{ #category : #accessing }
ToPropertySubscription >> property [

	^ property
]

{ #category : #accessing }
ToPropertySubscription >> property: aLookProperty [

	property := aLookProperty.
	self animation ifNotNil: [ :a |
		animation property: aLookProperty ]
]

{ #category : #operating }
ToPropertySubscription >> receiveLookEvent: aLookEvent [

	| target rawValue valueWriter |
	(self canReceiveEvent: aLookEvent) ifFalse: [ ^ self ].
	target := aLookEvent currentTarget.
	rawValue := self valueIn: target.
	valueWriter := self valueWriter.
	valueWriter write: rawValue to: target
]

{ #category : #accessing }
ToPropertySubscription >> value [

	^ value
]

{ #category : #accessing }
ToPropertySubscription >> value: anObject [

	value := anObject
]

{ #category : #operating }
ToPropertySubscription >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]

{ #category : #operating }
ToPropertySubscription >> valueWriter [

	^ self animation ifNil: [ self property ].
]
