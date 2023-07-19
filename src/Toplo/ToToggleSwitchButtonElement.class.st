Class {
	#name : #ToToggleSwitchButtonElement,
	#superclass : #ToElement,
	#instVars : [
		'offElement',
		'onElement'
	],
	#category : #'Toplo-Widget-Button-Toggle'
}

{ #category : #requirements }
ToToggleSwitchButtonElement >> empty [

	self removeChildren
]

{ #category : #initialization }
ToToggleSwitchButtonElement >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self geometry: BlCircleGeometry new.
	self fitContent
]

{ #category : #accessing }
ToToggleSwitchButtonElement >> offElement [

	^ offElement
]

{ #category : #accessing }
ToToggleSwitchButtonElement >> offElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ] ].
	offElement := anElement
]

{ #category : #accessing }
ToToggleSwitchButtonElement >> onElement [

	^ onElement
]

{ #category : #accessing }
ToToggleSwitchButtonElement >> onElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ] ].
	onElement := anElement
]

{ #category : #requirements }
ToToggleSwitchButtonElement >> switchOff [

	self empty.
	self offElement ifNil: [ ^ self ].
	self addChild: self offElement
]

{ #category : #requirements }
ToToggleSwitchButtonElement >> switchOn [

	self empty.
	self onElement ifNil: [ ^ self ].
	self addChild: self onElement
]
