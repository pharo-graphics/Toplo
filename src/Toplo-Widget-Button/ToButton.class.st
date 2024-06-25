Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'labeledIcon'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	labeledIcon constraintsDo: [ :c |
		c linear vertical alignCenter.
		c linear horizontal alignCenter.
		c frame vertical alignCenter.
		c frame horizontal alignCenter ].
	self fitContent
]

{ #category : #'t - element with labeled icon - accessing' }
ToButton >> labeledIcon [ 

	^ labeledIcon
]

{ #category : #skin }
ToButton >> newRawSkin [

	^ ToButtonSkin new
]
