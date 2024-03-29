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
	self fitContent
]

{ #category : #skin }
ToButton >> installRawStyle [

	super installRawStyle.
	self labeledIcon hMatchParent
]

{ #category : #'t - element with labeled icon - accessing' }
ToButton >> labeledIcon [ 

	^ labeledIcon 
]

{ #category : #skin }
ToButton >> newRawSkin [

	^ ToButtonSkin new
]
