Class {
	#name : #ToPropertyUpdater,
	#superclass : #ToValueUpdater,
	#instVars : [
		'value',
		'property',
		'animation'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToPropertyUpdater >> animation [

	^ animation
]

{ #category : #accessing }
ToPropertyUpdater >> animation: aPropertyAnimation [

	animation := aPropertyAnimation.
	animation property: self property
]

{ #category : #operating }
ToPropertyUpdater >> announceLookEvent: aLookEvent [

	| target rawValue writer |
	target := aLookEvent currentTarget.
	rawValue := (self valueIn: target).
	writer := self animation ifNil: [ self property ].
	writer write: rawValue to: target 

]

{ #category : #converting }
ToPropertyUpdater >> asPropertyUpdaterFor: aPropertyDefinition [

	^ self
		  property: aPropertyDefinition;
		  yourself
]

{ #category : #accessing }
ToPropertyUpdater >> property [

	^ property
]

{ #category : #accessing }
ToPropertyUpdater >> property: aPropertyDefinition [

	property := aPropertyDefinition.
	self animation ifNotNil: [ :a |
		animation property: aPropertyDefinition ]
]

{ #category : #accessing }
ToPropertyUpdater >> value [

	^ value
]

{ #category : #accessing }
ToPropertyUpdater >> value: anObject [

	value := anObject
]

{ #category : #operating }
ToPropertyUpdater >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]
