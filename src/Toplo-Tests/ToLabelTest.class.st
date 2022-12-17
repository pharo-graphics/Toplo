"
A ToLabelTest is a test class for testing the behavior of ToLabel
"
Class {
	#name : #ToLabelTest,
	#superclass : #ToTestCase,
	#category : #'Toplo-Tests-Widget'
}

{ #category : #tests }
ToLabelTest >> testHAlignment [

	| label |
	label := ToLabel new.
	self assert: (label layout horizontalAlignment isKindOf: BlNullHorizontalAlignment).

	label layout alignCenter.
	self assert: (label layout horizontalAlignment isKindOf: BlHorizontalCenterAlignment). 

	label layout alignCenterRight.
	self assert: (label layout horizontalAlignment isKindOf: BlHorizontalEndAlignment). 
	
	label layout alignCenterLeft.
	self assert: (label layout horizontalAlignment isKindOf: BlHorizontalStartAlignment). 
]

{ #category : #tests }
ToLabelTest >> testLabel [
	"Test default values of a new label"

	| label |
	label := ToLabel new.
	
	self assert: label isEditable equals: false.
	
	self assert: label isMonoLine.
	self assert: label isMultiLine equals: false.
	
	self assert: label text isEmpty. 
]

{ #category : #tests }
ToLabelTest >> testLabelDefaultDresser [
	
	| label |
	label := ToLabel new.
	
	self assert: label defaultDresser class equals: ToLabelDresser.
]

{ #category : #tests }
ToLabelTest >> testLabelDresser [
	
	| label |
	label := ToLabel new.
	
	self assert: label dresser class equals: ToLabelDresser.
]

{ #category : #tests }
ToLabelTest >> testMonoLineText [

	| label |
	label := ToLabel new.
	self assert: label innerElement text identicalTo: label text.
	
	label text: ''.
	self assert: label text asString equals: ''.
	self assert: label innerElement text identicalTo: label text.
	
	label innerElement text: '' asRopedText .
	self assert: label text asString equals: ''.
	self assert: label innerElement text identicalTo: label text.
	
	label text: 'This is a text'.
	self assert: label text asString equals: 'This is a text'.
	self assert: label innerElement text identicalTo: label text.
	
	label innerElement text: 'This is a text' asRopedText .
	self assert: label text asString equals: 'This is a text'.
	self assert: label innerElement text identicalTo: label text.
	
	label text: nil.
	self assert: label innerElement text identicalTo: label text.
	

]

{ #category : #tests }
ToLabelTest >> testMultiLineText [

	| label |
	label := ToLabel new beMultiLine.
	self assert: label innerElement text identicalTo: label text.
	
	label text: ''.
	self assert: label text asString equals: ''.
	self assert: label innerElement text identicalTo: label text.
	
	label innerElement text: '' asRopedText .
	self assert: label text asString equals: ''.
	self assert: label innerElement text identicalTo: label text.
	
	label text: 'This is a text'.
	self assert: label text asString equals: 'This is a text'.
	self assert: label innerElement text identicalTo: label text.
	
	label innerElement text: 'This is a text' asRopedText .
	self assert: label text asString equals: 'This is a text'.
	self assert: label innerElement text identicalTo: label text.
	
	label text: nil.
	self assert: label innerElement text identicalTo: label text.
	

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
	self assert: (label layout verticalAlignment isKindOf: BlNullVerticalAlignment ).

	label layout alignCenter.
	self assert: (label layout verticalAlignment isKindOf: BlVerticalCenterAlignment). 

	label layout alignTopRight.
	self assert: (label layout verticalAlignment isKindOf: BlTopAlignment). 
	
	label layout alignBottomLeft.
	self assert: (label layout verticalAlignment isKindOf: BlBottomAlignment). 
]
