Class {
	#name : #ToAbstractPropertySubscription,
	#superclass : #ToLookEventSubscription,
	#instVars : [
		'property',
		'animation'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToAbstractPropertySubscription >> animation [

	^ animation
]

{ #category : #accessing }
ToAbstractPropertySubscription >> animation: aPropertyAnimation [

	animation := aPropertyAnimation.
	animation ifNil: [ ^self ].
	animation property: self property
]

{ #category : #converting }
ToAbstractPropertySubscription >> asPropertySubscriptionFor: aPropertyDef [

	^ self
		  property: aPropertyDef;
		  yourself
]

{ #category : #testing }
ToAbstractPropertySubscription >> isPropertyBased [

	^ true
]

{ #category : #accessing }
ToAbstractPropertySubscription >> property [

	^ property
]

{ #category : #accessing }
ToAbstractPropertySubscription >> property: aLookProperty [

	property := aLookProperty.
	self animation ifNotNil: [ :a |
		animation property: aLookProperty ]
]

{ #category : #operating }
ToAbstractPropertySubscription >> receiveLookEvent: aLookEvent [

	(self canReceiveEvent: aLookEvent) ifFalse: [  ^ self ].
	self property receiveLookEvent: aLookEvent from: self
]

{ #category : #operating }
ToAbstractPropertySubscription >> valueWriter [

	^ self animation ifNil: [ self property ].
]
