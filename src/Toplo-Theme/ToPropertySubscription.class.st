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

{ #category : #converting }
ToPropertySubscription >> asPropertySubscriptionFor: aPropertyDef [

	^ self
		  property: aPropertyDef;
		  yourself
]

{ #category : #testing }
ToPropertySubscription >> isPropertyBased [

	^ false
]

{ #category : #accessing }
ToPropertySubscription >> property [

	^ property
]

{ #category : #accessing }
ToPropertySubscription >> property: aPropertyDefinition [

	property := aPropertyDefinition.
	self animation ifNotNil: [ :a |
		animation property: aPropertyDefinition ]
]

{ #category : #operating }
ToPropertySubscription >> receiveLookEvent: aLookEvent [

	| target rawValue writer |
	(self canReceiveEvent: aLookEvent) ifFalse: [  ^ self ].
	target := aLookEvent currentTarget.
	rawValue := (self valueIn: target).
	writer := self animation ifNil: [ self property ].
	writer write: rawValue to: target 

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
