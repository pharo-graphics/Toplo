Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'#labeledIcon => ToSkinnableSlot'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #initialization }
ToButton >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	self fitContent
]

{ #category : #skin }
ToButton >> initializeRawStyle [ 

	super initializeRawStyle.
	((self label notNil) and: [ self icon notNil ])
		ifTrue: [ self interspace: 10 ]

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
