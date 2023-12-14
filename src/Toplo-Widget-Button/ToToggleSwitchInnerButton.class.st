Class {
	#name : 'ToToggleSwitchInnerButton',
	#superclass : 'ToElement',
	#instVars : [
		'offElement',
		'onElement',
		'checked'
	],
	#category : 'Toplo-Widget-Button-Switch',
	#package : 'Toplo-Widget-Button',
	#tag : 'Switch'
}

{ #category : 'accessing' }
ToToggleSwitchInnerButton >> checked [

	^ checked
]

{ #category : 'accessing' }
ToToggleSwitchInnerButton >> checked: aBoolean [

	checked := aBoolean
]

{ #category : 'initialization' }
ToToggleSwitchInnerButton >> defaultWidth [

	^ 14
]

{ #category : 'requirements' }
ToToggleSwitchInnerButton >> empty [

	self removeChildren
]

{ #category : 'initialization' }
ToToggleSwitchInnerButton >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self geometry: BlCircleGeometry new.
	self width: self defaultWidth.
	self background: Color blue.
]

{ #category : 'testing' }
ToToggleSwitchInnerButton >> isChecked [ 

	^ self checked
]

{ #category : 'accessing' }
ToToggleSwitchInnerButton >> offElement [

	^ offElement
]

{ #category : 'accessing' }
ToToggleSwitchInnerButton >> offElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ] ].
	offElement := anElement
]

{ #category : 'accessing' }
ToToggleSwitchInnerButton >> onElement [

	^ onElement
]

{ #category : 'accessing' }
ToToggleSwitchInnerButton >> onElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c |
			c frame horizontal alignCenter.
			c frame vertical alignCenter ] ].
	onElement := anElement
]

{ #category : 'requirements' }
ToToggleSwitchInnerButton >> switchOff [

	self empty.
	self offElement ifNil: [ ^ self ].
	self addChild: self offElement
]

{ #category : 'requirements' }
ToToggleSwitchInnerButton >> switchOn [

	self empty.
	self onElement ifNil: [ ^ self ].
	self addChild: self onElement
]
