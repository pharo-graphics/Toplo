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
	self labeledIcon hMatchParent.
	self fitContent
]

{ #category : #'t - element with labeled icon - accessing' }
ToButton >> labeledIcon [ 

	^ labeledIcon 
]

{ #category : #'t - orientable - accessing' }
ToButton >> layoutStrategy [

	^ self innerElement layout

	
]

{ #category : #skin }
ToButton >> rawSkin [

	^ ToButtonSkin new
]
