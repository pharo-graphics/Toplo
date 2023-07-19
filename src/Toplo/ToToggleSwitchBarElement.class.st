Class {
	#name : #ToToggleSwitchBarElement,
	#superclass : #ToElement,
	#instVars : [
		'offElement',
		'onElement',
		'button'
	],
	#category : #'Toplo-Widget-Button-Toggle'
}

{ #category : #initialization }
ToToggleSwitchBarElement >> actualChildren [

	^ { self onElement. self button. self offElement } reject: [ :e | e isNil ]
]

{ #category : #accessing }
ToToggleSwitchBarElement >> button [

	^ button
]

{ #category : #accessing }
ToToggleSwitchBarElement >> button: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c | c linear vertical alignCenter ] ].
	button := anElement.
	self updateChildren 
]

{ #category : #initialization }
ToToggleSwitchBarElement >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self button: ToToggleSwitchButtonElement new.
	self fitContent
]

{ #category : #accessing }
ToToggleSwitchBarElement >> offElement [

	^ offElement
]

{ #category : #accessing }
ToToggleSwitchBarElement >> offElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c | c linear vertical alignCenter ] ].
	offElement := anElement.
	self updateChildren
]

{ #category : #accessing }
ToToggleSwitchBarElement >> onElement [

	^ onElement
]

{ #category : #accessing }
ToToggleSwitchBarElement >> onElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c | c linear vertical alignCenter ] ].
	onElement := anElement.
	self updateChildren
]

{ #category : #requirements }
ToToggleSwitchBarElement >> switchOff [

	self button switchOff.
	self onElement ifNotNil: [ :e | e visibility: BlVisibility hidden  ].
	self offElement ifNotNil: [ :e | e visibility: BlVisibility visible ]
]

{ #category : #requirements }
ToToggleSwitchBarElement >> switchOn [ 

	self button switchOn.
	self offElement ifNotNil: [ :e | e visibility: BlVisibility hidden  ].
	self onElement ifNotNil: [ :e | e visibility: BlVisibility visible ]
]

{ #category : #accessing }
ToToggleSwitchBarElement >> updateChildren [

	self removeChildren.
	self addChildren: self actualChildren 
]
