Class {
	#name : #ToPropertyAdapter,
	#superclass : #ToLookAdapter,
	#instVars : [
		'value',
		'property',
		'animation'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToPropertyAdapter >> animation [

	^ animation
]

{ #category : #accessing }
ToPropertyAdapter >> animation: aPropertyAnimation [

	animation := aPropertyAnimation.
	animation property: self property
]

{ #category : #operating }
ToPropertyAdapter >> announceLookEvent: aLookEvent [

	| target rawValue |
	target := aLookEvent currentTarget.
	aLookEvent currentUpdater currentAnimation: self animation.
	rawValue := (self valueIn: target).
	self animation ifNil: [ ^ self property write: rawValue to: target].
	self animation write: rawValue to: target 

]

{ #category : #converting }
ToPropertyAdapter >> asPropertyAdapterFor: aPropertyDefinition [

	^ self
		  property: aPropertyDefinition;
		  yourself
]

{ #category : #accessing }
ToPropertyAdapter >> property [

	^ property
]

{ #category : #accessing }
ToPropertyAdapter >> property: aPropertyDefinition [

	property := aPropertyDefinition.
	self animation ifNotNil: [ :a |
		animation property: aPropertyDefinition ]
]

{ #category : #accessing }
ToPropertyAdapter >> value [

	^ value
]

{ #category : #accessing }
ToPropertyAdapter >> value: anObject [

	value := anObject
]

{ #category : #operating }
ToPropertyAdapter >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]
