Class {
	#name : #ToElementWithLabeledIconForTest,
	#superclass : #ToElement,
	#traits : 'TToElementWithLabeledIcon',
	#classTraits : 'TToElementWithLabeledIcon classTrait',
	#instVars : [
		'labeledIcon'
	],
	#category : #'Toplo-Tests-Core'
}

{ #category : #initialization }
ToElementWithLabeledIconForTest >> initialize [ 

	super initialize.
	labeledIcon := ToLabeledIcon new.
	self addChild: labeledIcon.
	self beStartToEnd.
	self fitContent.
]

{ #category : #accessing }
ToElementWithLabeledIconForTest >> labeledIcon [

	^ labeledIcon 
]

{ #category : #'t - element with labeled icon - accessing' }
ToElementWithLabeledIconForTest >> startFiller [ 

	^ self labeledIcon startFiller
]

{ #category : #'t - element with labeled icon - accessing' }
ToElementWithLabeledIconForTest >> startFlexible: aBoolean [

	self labeledIcon startFlexible: aBoolean
]
