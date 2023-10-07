Class {
	#name : #ToButton,
	#superclass : #ToGeneralButton,
	#traits : 'TToOrientable + TToElementWithLabeledIcon',
	#classTraits : 'TToOrientable classTrait + TToElementWithLabeledIcon classTrait',
	#instVars : [
		'#labeledIcon => ToSkinnableSlot'
	],
	#category : #'Toplo-Widget-Button-BasicButton'
}

{ #category : #initialization }
ToButton >> defaultLayout [ 

	^ BlLinearLayout vertical
]

{ #category : #'t - skinable - initialization' }
ToButton >> defaultStyleStamps [

	^ { #button }
]

{ #category : #initialization }
ToButton >> initialize [

	super initialize.
	self withStamp: #button.
	self layout: self defaultLayout.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
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
