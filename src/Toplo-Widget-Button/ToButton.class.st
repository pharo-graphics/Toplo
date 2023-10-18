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

{ #category : 'skin' }
ToButton >> initialRawStyle [
	super initialRawStyle.
	(self hasIcon and: [ self hasLabel ]) ifFalse: [
		self interspace: 0.
		^ self ].
	self interspace: 10
	
]

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
	
]

{ #category : 't - element with labeled icon - accessing' }
ToButton >> labeledIcon [ 

	^ labeledIcon 
]
