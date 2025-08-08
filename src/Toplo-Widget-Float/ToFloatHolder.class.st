Class {
	#name : #ToFloatHolder,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatHolder >> defaultElevation [

	^ BlRelativeElevation elevation: 1
]

{ #category : #initialization }
ToFloatHolder >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : #initialization }
ToFloatHolder >> initialize [

	super initialize.
	self fitContent.
	self layout: self defaultLayout.
	self elevation: self defaultElevation
]

{ #category : #skin }
ToFloatHolder >> installRawStyle [

	super installRawStyle.

	self background: (self valueOfTokenNamed: #'background-color').
	self effect:
		(BlGaussianShadowEffect color: Color gray width: 8 offset: 1 @ 1)
]
