Class {
	#name : #ToToggleSwitchBarElement,
	#superclass : #ToElement,
	#instVars : [
		'sideWidth',
		'offContainer',
		'onContainer',
		'offElement',
		'onElement',
		'checked',
		'innerButton'
	],
	#category : 'Toplo-Widget-Button-Toggle'
}

{ #category : #accessing }
ToToggleSwitchBarElement >> checked [

	^ checked
]

{ #category : #accessing }
ToToggleSwitchBarElement >> checked: aBoolean [

	checked := aBoolean.
	self innerButton checked: aBoolean
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
	self innerButton: ToToggleSwitchInnerButtonElement new.
	self addChildren: { onContainer. innerButton. offContainer }

]

{ #category : #accessing }
ToToggleSwitchBarElement >> innerButton [

	^ innerButton
]

{ #category : #accessing }
ToToggleSwitchBarElement >> innerButton: anElement [

	anElement ifNotNil: [
		anElement constraintsDo: [ :c | c linear vertical alignCenter ] ].
	innerButton := anElement.
	self updateChildren
]

{ #category : #testing }
ToToggleSwitchBarElement >> isChecked [ 

	^ self checked
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

	self innerButton switchOff.
	onContainer visibility: BlVisibility hidden.
	offContainer visibility: BlVisibility visible
]

{ #category : #requirements }
ToToggleSwitchBarElement >> switchOn [ 

	self innerButton switchOn.
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
