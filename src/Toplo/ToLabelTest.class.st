Class {
	#name : #ToLabelTest,
	#superclass : #ToTestCase,
	#category : #'Toplo-Tests-Widgets'
}

{ #category : #tests }
ToLabelTest >> testHAlignment [

	| label |
	label := ToLabel new.
	self assert: (label horizontalAlignment isKindOf: BlNullHorizontalAlignment).

	label alignCenter.
	self assert: (label horizontalAlignment isKindOf: BlHorizontalCenterAlignment). 

	label alignCenterRight.
	self assert: (label horizontalAlignment isKindOf: BlHorizontalEndAlignment). 
	
	label alignCenterLeft.
	self assert: (label horizontalAlignment isKindOf: BlHorizontalStartAlignment). 
]

{ #category : #tests }
ToLabelTest >> testMonoLineText [

	| label |
	label := ToLabel new.
	self assert: label text asString equals: label defaultText asString.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label text: ''.
	self assert: label text asString equals: ''.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label textElement text: '' asRopedText .
	self assert: label text asString equals: ''.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label text: 'This is a text'.
	self assert: label text asString equals: 'This is a text'.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label textElement text: 'This is a text' asRopedText .
	self assert: label text asString equals: 'This is a text'.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label text: nil.
	self assert: label text asString equals: label defaultText asString.	
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	

]

{ #category : #tests }
ToLabelTest >> testMultiLineText [

	| label |
	label := ToLabel new beMultiLine.
	self assert: label text asString equals: label defaultText asString.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label text: ''.
	self assert: label text asString equals: ''.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label textElement text: '' asRopedText .
	self assert: label text asString equals: ''.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label text: 'This is a text'.
	self assert: label text asString equals: 'This is a text'.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label textElement text: 'This is a text' asRopedText .
	self assert: label text asString equals: 'This is a text'.
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	
	label text: nil.
	self assert: label text asString equals: label defaultText asString.	
	self assert: label viewModel text == label text.
	self assert: label textElement text == label text.
	

]

{ #category : #tests }
ToLabelTest >> testVAlignment [

	| label |
	label := ToLabel new.
	self assert: (label verticalAlignment isKindOf: BlNullVerticalAlignment ).

	label alignCenter.
	self assert: (label verticalAlignment isKindOf: BlVerticalCenterAlignment). 

	label alignTopRight.
	self assert: (label verticalAlignment isKindOf: BlTopAlignment). 
	
	label alignBottomLeft.
	self assert: (label verticalAlignment isKindOf: BlBottomAlignment). 
]
