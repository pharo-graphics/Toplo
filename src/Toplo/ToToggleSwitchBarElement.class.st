Class {
	#name : #ToToggleSwitchBarElement,
	#superclass : #ToElement,
	#instVars : [
		'sideWidth',
		'offContainer',
		'onContainer',
		'offElement',
		'onElement',
		'button'
	],
	#category : #'Toplo-Widget-Button-Toggle'
}

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
ToToggleSwitchBarElement >> defaultSideWidth [

	^ 8
]

{ #category : #initialization }
ToToggleSwitchBarElement >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self fitContent.
	sideWidth := self defaultSideWidth.
	offContainer := ToElement new vFitContent; width: self sideWidth; layout: BlFrameLayout new; yourself.
	offContainer constraintsDo: [ :c | c linear vertical alignCenter ].
	onContainer := ToElement new vFitContent; width: self sideWidth; layout: BlFrameLayout new; yourself.
	onContainer constraintsDo: [ :c | c linear vertical alignCenter ].
	self button: ToToggleSwitchButtonElement new.
	self addChildren: { onContainer. button. offContainer }

]

{ #category : #accessing }
ToToggleSwitchBarElement >> offContainer [

	^ offContainer
]

{ #category : #accessing }
ToToggleSwitchBarElement >> offElement [

	^ offElement
]

{ #category : #accessing }
ToToggleSwitchBarElement >> offElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ].
	offElement := anElement.
	self updateChildren
]

{ #category : #accessing }
ToToggleSwitchBarElement >> onContainer [

	^ onContainer
]

{ #category : #accessing }
ToToggleSwitchBarElement >> onElement [

	^ onElement
]

{ #category : #accessing }
ToToggleSwitchBarElement >> onElement: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ] ].
	onElement := anElement.
	self updateChildren
]

{ #category : #accessing }
ToToggleSwitchBarElement >> sideWidth [

	^ sideWidth
]

{ #category : #accessing }
ToToggleSwitchBarElement >> sideWidth: anInteger [

	sideWidth := anInteger
]

{ #category : #requirements }
ToToggleSwitchBarElement >> switchOff [

	self button switchOff.
	onContainer visibility: BlVisibility hidden.
	offContainer visibility: BlVisibility visible
]

{ #category : #requirements }
ToToggleSwitchBarElement >> switchOn [ 

	self button switchOn.
	offContainer visibility: BlVisibility hidden.
	onContainer visibility: BlVisibility visible
]

{ #category : #accessing }
ToToggleSwitchBarElement >> updateChildren [

	| offw onw |
	onContainer removeChildren.
	offContainer removeChildren.
	onw := 0.
	offw := 0.
	onElement ifNotNil: [ :e |
		onContainer addChild: e.
		onw := e requestedWidth ].
	offElement ifNotNil: [ :e |
		offContainer addChild: e.
		offw := e requestedWidth ].
	sideWidth := (onw max: offw) max: self defaultSideWidth.
	onContainer width: sideWidth.
	offContainer width: sideWidth
]
