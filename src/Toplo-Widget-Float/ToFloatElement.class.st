Class {
	#name : #ToFloatElement,
	#superclass : #ToAnchoredElement,
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

{ #category : #skin }
ToFloatElement >> installRawStyle [

	super installRawStyle.
	self background: (self valueOfTokenNamed: #'background-color').
	self effect:
		(BlGaussianShadowEffect color: Color gray width: 8 offset: 1 @ 1)
]
