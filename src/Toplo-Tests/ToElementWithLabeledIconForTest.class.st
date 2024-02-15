Class {
	#name : #ToElementWithLabeledIconForTest,
	#superclass : #ToElement,
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'labeledIcon'
	],
	#category : 'Toplo-Tests-Core'
}

{ #category : #initialization }
ToElementWithLabeledIconForTest >> initialize [ 

	super initialize.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	self beIconFirst.
	self fitContent.
]

{ #category : #accessing }
ToElementWithLabeledIconForTest >> labeledIcon [

	^ labeledIcon 
]
