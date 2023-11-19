Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'labeledIcon'
	],
	#category : 'Toplo-Widget-Button-Core'
}

{ #category : #skin }
ToButton >> initialRawStyle [

	super initialRawStyle.

	((self parent isKindOf: ToMenuItem) and: [ self parent isTopMenu not ])
		ifTrue: [ ^ self ].
	(self hasIcon and: [ self hasLabel ]) ifFalse: [
		self interspace: 0.
		^ self ].
	self interspace: 10
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	self fitContent
]

{ #category : #skin }
ToButton >> installRawStyle [

	super installRawStyle.
	self labeledIcon hMatchParent.
	self iconDo: [ :ic | ic formColor: Color black ].

]

{ #category : #'t - element with labeled icon - accessing' }
ToButton >> labeledIcon [ 

	^ labeledIcon 
]

{ #category : #skin }
ToButton >> newRawSkin [

	^ ToButtonSkin new
]
