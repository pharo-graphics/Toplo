Class {
	#name : #ToLinearLook,
	#superclass : #ToLayoutLook,
	#instVars : [
		'horizontal',
		'startToEnd',
		'spacing',
		'interspacing'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToLinearLook >> horizontal [

	^ horizontal
]

{ #category : #accessing }
ToLinearLook >> horizontal: aBoolean [

	horizontal := aBoolean
]

{ #category : #'event handling' }
ToLinearLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		(e layout isKindOf: BlLinearLayout) ifFalse: [
			e layout: BlLinearLayout new ].
		self horizontal ifNotNil: [
			e layout orientation: (self horizontal
					 ifTrue: [ BlLinearLayoutHorizontalOrientation new ]
					 ifFalse: [ BlLinearLayoutVerticalOrientation new ]) ].
		self startToEnd ifNotNil: [
			e layout direction: (self startToEnd
					 ifTrue: [ BlLayoutDirection leftToRight ]
					 ifFalse: [ BlLayoutDirection rightToLeft ]) ].
		self spacing ifNotNil: [ e layout cellSpacing: self spacing ].
		self interspacing ifNotNil: [
			e layout interspacing: self interspacing ] ]
]

{ #category : #accessing }
ToLinearLook >> interspacing [

	^ interspacing
]

{ #category : #accessing }
ToLinearLook >> interspacing: aNumber [

	interspacing := aNumber
]

{ #category : #accessing }
ToLinearLook >> spacing [

	^ spacing
]

{ #category : #accessing }
ToLinearLook >> spacing: aNumber [

	spacing := aNumber
]

{ #category : #accessing }
ToLinearLook >> startToEnd [

	^ startToEnd
]

{ #category : #accessing }
ToLinearLook >> startToEnd: aBoolean [

	startToEnd := aBoolean
]
