Class {
	#name : #ToCompositeBadge,
	#superclass : #ToBaseBadge,
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToCompositeBadge >> initialize [ 

	super initialize.
	self layout: BlLinearLayout horizontal.
	self fitContent
]
