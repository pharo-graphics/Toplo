Class {
	#name : #ToStyleAptitude,
	#superclass : #ToAptitude,
	#traits : 'TBlElementStyles + TBlElementQuery',
	#classTraits : 'TBlElementStyles classTrait + TBlElementQuery classTrait',
	#instVars : [
		'styles',
		'target'
	],
	#category : #'Toplo-Editor-Core'
}

{ #category : #'private - adding' }
ToStyleAptitude >> basicAddStyle: aStyle [
	styles basicAddStyle: aStyle
]

{ #category : #'private - adding' }
ToStyleAptitude >> for: aTargetObject [
	^ styles for: aTargetObject
]

{ #category : #initialization }
ToStyleAptitude >> initialize [
	super initialize.

	styles := BlStyles new.

	"empty selector, means we apply it on the widget itself"
	target := BlElementLazyQuery new.

	self addChange:
		(BrLookChange new
			up: [ :thisLook | self halt.
				target isEmpty
					ifFalse: [ styles := styles asForwarded: target ].
				thisLook widget styles addStyles: styles styles ];
			down: [ :thisLook | thisLook widget styles removeStyles: styles styles ];
			yourself)
]

{ #category : #initialization }
ToStyleAptitude >> propagateStylesToWidget [
	"Call me if this look is updated after its creation"

	self widgetDo: [ :aWidget |
		aWidget styles addStyles: styles styles.
		aWidget requestStyle ]
]

{ #category : #accessing }
ToStyleAptitude >> queryStep: aBlElementStep [
	target queryStep: aBlElementStep
]

{ #category : #accessing }
ToStyleAptitude >> state [
	^ BlElementState
]

{ #category : #'private - adding' }
ToStyleAptitude >> styleForState: aState ifFound: aFoundBlock ifNone: aNoneBlock [
	^ styles
		styleForState: aState
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #accessing }
ToStyleAptitude >> target: aSelectorPath [	
	self deprecated: 'Use Element Query Api instead'.
]

{ #category : #'private - adding' }
ToStyleAptitude >> when: aStateBlock style: aStyleBlock [
	| aTargetState |
	
	aTargetState := aStateBlock glamourValueWithArgs: { self state }.
	aStyleBlock value: (self styleFor: aTargetState)
]
