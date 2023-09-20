Class {
	#name : 'ToPropertySubscriptionDep',
	#superclass : 'ToLookEventSubscriptionDep',
	#instVars : [
		'value',
		'property',
		'animation'
	],
	#category : 'Toplo-Theme-Skin-dep',
	#package : 'Toplo-Theme',
	#tag : 'Skin-dep'
}

{ #category : 'accessing' }
ToPropertySubscriptionDep >> animation [

	^ animation
]

{ #category : 'accessing' }
ToPropertySubscriptionDep >> animation: aPropertyAnimation [

	animation := aPropertyAnimation.
	animation ifNil: [ ^self ].
	animation property: self property
]

{ #category : 'testing' }
ToPropertySubscriptionDep >> canReplace: anotherSubscription [

	^ (self isKindOf: anotherSubscription class) and: [
		  self property = anotherSubscription property and: [
			  self eventClass = anotherSubscription eventClass ] ]
]

{ #category : 'accessing' }
ToPropertySubscriptionDep >> property [

	^ property
]

{ #category : 'accessing' }
ToPropertySubscriptionDep >> property: aLookProperty [

	property := aLookProperty.
	self animation ifNotNil: [ :a |
		animation property: aLookProperty ]
]

{ #category : 'operating' }
ToPropertySubscriptionDep >> receiveEvent: aLookEvent [

	| target rawValue valueWriter |
	(self canReceiveEvent: aLookEvent) ifFalse: [ ^ self ].
	target := aLookEvent currentTarget.
	rawValue := self valueIn: target.
	valueWriter := self valueWriter.
	valueWriter write: rawValue to: target
]

{ #category : 'evaluating' }
ToPropertySubscriptionDep >> value [

	^ value
]

{ #category : 'accessing' }
ToPropertySubscriptionDep >> value: anObject [

	value := anObject
]

{ #category : 'operating' }
ToPropertySubscriptionDep >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]

{ #category : 'operating' }
ToPropertySubscriptionDep >> valueWriter [

	^ self animation ifNil: [ self property ].
]
