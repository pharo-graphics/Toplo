Class {
	#name : #ToFloatElement,
	#superclass : #ToAnchoredElement,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatElement >> defaultOffset [

	^ 8 negated asPoint.

]

{ #category : #initialization }
ToFloatElement >> defaultPlacement [ 

	^ ToAnchoredAtBottomRight new
]

{ #category : #initialization }
ToFloatElement >> initialize [ 

	super initialize.
	innerElement := ToElement new.
	innerElement fitContent.
	innerElement constraintsDo: [ :c |
			c frame vertical alignCenter.
			c frame horizontal alignCenter ].
	self addChild: innerElement.

]

{ #category : #skin }
ToFloatElement >> installRawStyle [

	super installRawStyle.
	self background: (self valueOfTokenNamed: #'background-color').
	self effect:
		(BlGaussianShadowEffect color: Color gray width: 8 offset: 1 @ 1)
]
