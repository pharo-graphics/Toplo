Class {
	#name : 'ToButton',
	#superclass : 'ToGeneralButton',
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'labeledIcon'
	],
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 'initialization' }
ToButton >> initialize [

	super initialize.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	self labeledIcon hMatchParent.
	self fitContent
]

{ #category : 'skin' }
ToButton >> installRawStyle [

	super installRawStyle.
	(self hasIcon and: [ self hasLabel ]) ifFalse: [ ^ self ].
	self interspace: 10
]

{ #category : 't - element with labeled icon - accessing' }
ToButton >> labeledIcon [ 

	^ labeledIcon 
]
