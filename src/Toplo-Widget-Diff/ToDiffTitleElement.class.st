Class {
	#name : #ToDiffTitleElement,
	#superclass : #ToElement,
	#instVars : [
		'leftLabel',
		'rightLabel',
		'toRightLabel',
		'toLeftLabel'
	],
	#category : #'Toplo-Widget-Diff'
}

{ #category : #initialization }
ToDiffTitleElement >> defaultLayout [
	" don't use vertical or horizontal to allow vertical centering of children "

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToDiffTitleElement >> initialize [

	super initialize.
	self class initializeSlots: self.
	self
		hMatchParent;
		vFitContent.
	self padding: (BlInsets horizontal: 6).
	toLeftLabel := ToLabel new.
	toLeftLabel matchParent.
	toRightLabel := ToLabel new.
	toRightLabel matchParent.
	toRightLabel innerElement constraintsDo: [ :c |
		c frame horizontal alignRight ].
	self addChildren: {
			toLeftLabel.
			toRightLabel }
]

{ #category : #accessing }
ToDiffTitleElement >> isWithoutTitle [

	^ toLeftLabel text isEmpty and: [ toRightLabel text isEmpty ]
]

{ #category : #accessing }
ToDiffTitleElement >> leftLabel [

	^ leftLabel text
]

{ #category : #accessing }
ToDiffTitleElement >> leftLabel: anObject [

	toLeftLabel text: anObject
]

{ #category : #accessing }
ToDiffTitleElement >> rightLabel [

	^ rightLabel text
]

{ #category : #accessing }
ToDiffTitleElement >> rightLabel: anObject [

	toRightLabel text: anObject 
]
