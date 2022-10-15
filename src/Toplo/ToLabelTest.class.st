Class {
	#name : #ToLabelTest,
	#superclass : #ToTestCase,
	#category : #'Toplo-Tests-Widgets'
}

{ #category : #tests }
ToLabelTest >> testHAlignment [

	| label |
	label := ToLabel new.
	self assert: (label horizontalAlignment isKindOf: BlHorizontalStartAlignment).

	label alignCenter.
	self assert: (label horizontalAlignment isKindOf: BlHorizontalCenterAlignment). 

	label alignCenterRight.
	self assert: (label horizontalAlignment isKindOf: BlHorizontalEndAlignment). 
	
	label alignCenterLeft.
	self assert: (label horizontalAlignment isKindOf: BlHorizontalStartAlignment). 
]

{ #category : #tests }
ToLabelTest >> testText [

	| label |
	label := ToLabel new.
	self assert: label text asString equals: label defaultText asString.
	
	label text: ''.
	self assert: label text asString equals: ''.
	
	label text: 'This is a text'.
	self assert: label text asString equals: 'This is a text'.
	
	label text: nil.
	self assert: label text asString equals: label defaultText asString.
]

{ #category : #tests }
ToLabelTest >> testVAlignment [

	| label |
	label := ToLabel new.
	self assert: (label verticalAlignment isKindOf: BlTopAlignment ).

	label alignCenter.
	self assert: (label verticalAlignment isKindOf: BlVerticalCenterAlignment). 

	label alignTopRight.
	self assert: (label verticalAlignment isKindOf: BlTopAlignment). 
	
	label alignBottomLeft.
	self assert: (label verticalAlignment isKindOf: BlBottomAlignment). 
]
