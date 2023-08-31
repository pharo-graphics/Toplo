Class {
	#name : #ToToggleSwitchInnerButtonElement,
	#superclass : #ToElement,
	#instVars : [
		'offElement',
		'onElement',
		'checked'
	],
	#category : #'Toplo-Widget-Button-Toggle'
}

{ #category : #accessing }
ToToggleSwitchInnerButtonElement >> checked [

	^ checked
]

{ #category : #accessing }
ToToggleSwitchInnerButtonElement >> checked: aBoolean [

	checked := aBoolean
]

{ #category : #initialization }
ToToggleSwitchInnerButtonElement >> defaultWidth [

	^ 14
]

{ #category : #requirements }
ToToggleSwitchInnerButtonElement >> empty [

	self removeChildren
]

{ #category : #initialization }
ToToggleSwitchInnerButtonElement >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self geometry: BlCircleGeometry new.
	self width: self defaultWidth
]

{ #category : #testing }
ToToggleSwitchInnerButtonElement >> isChecked [ 

	^ self checked
]

{ #category : #accessing }
ToToggleSwitchInnerButtonElement >> offElement [

	^ offElement
]

{ #category : #accessing }
ToToggleSwitchInnerButtonElement >> offElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ] ].
	offElement := anElement
]

{ #category : #accessing }
ToToggleSwitchInnerButtonElement >> onElement [

	^ onElement
]

{ #category : #accessing }
ToToggleSwitchInnerButtonElement >> onElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ] ].
	onElement := anElement
]

{ #category : #requirements }
ToToggleSwitchInnerButtonElement >> switchOff [

	self empty.
	self offElement ifNil: [ ^ self ].
	self addChild: self offElement
]

{ #category : #requirements }
ToToggleSwitchInnerButtonElement >> switchOn [

	self empty.
	self onElement ifNil: [ ^ self ].
	self addChild: self onElement
]
