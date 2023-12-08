"
A ToSelectorPrinterTest is a test class for testing the behavior of ToSelectorPrinter
"
Class {
	#name : 'ToSelectorPrinterTest',
	#superclass : 'TestCase',
	#instVars : [
		'printer'
	],
	#category : 'Toplo-Tests-Core-Selectors',
	#package : 'Toplo-Tests',
	#tag : 'Core-Selectors'
}

{ #category : 'running' }
ToSelectorPrinterTest >> setUp [ 


	super setUp.
	printer := ToSelectorPrinter new
]

{ #category : 'tests' }
ToSelectorPrinterTest >> test1 [

	| selector |
	selector := (ToStampSelector new addStamp: #'button-label')
		            withParent: (ToStampSelector new addStamp: #button)
			            && (ToStampSelector new addStamp: #danger)
		            atDepth: 1.
	selector accept: printer.
	self
		assert: printer contents
		equals:
		'(stamp:#''button-label'' parent:((stamp:#button && stamp:#danger) depth:1))'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> test2 [

	| selector |
	selector := ((ToStampSelector new addStamp: #'button-label')
		             withParent: (ToStampSelector new addStamp: #button)
			             && (ToStampSelector new addStamp: #danger)
		             atDepth: 1)
	            && ((ToStampSelector new addStamp: #'button-label')
			             withParent: (ToStampSelector new addStamp: #button)
				             && (ToStampSelector new addStamp: #danger)
			             atDepth: 1) not.
	selector accept: printer.
	self
		assert: printer contents
		equals:
		'((stamp:#''button-label'' parent:((stamp:#button && stamp:#danger) depth:1)) && not((stamp:#''button-label'' parent:((stamp:#button && stamp:#danger) depth:1))))'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testAndNot [

	| selector |
	selector := #'labeled-icon' asStampSelector
	            && ToImage asTypeSelector not.
	selector accept: printer.
	self
		assert: printer contents
		equals: '(stamp:#''labeled-icon'' && not(type:ToImage))'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitActionSelector [

	| selector |
	selector := [ :e | e isKindOf: ToButton ] asActionSelector.
	selector accept: printer.
	self assert: printer contents equals: 'action:[ :e | e isKindOf: ToButton ]'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitAndSelector [

	| selector |
	selector := #'labeled-icon' asStampSelector && ToImage asTypeSelector.
	selector accept: printer.
	self
		assert: printer contents
		equals: '(stamp:#''labeled-icon'' && type:ToImage)'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitChildSelector [

	| selector |
	selector := (#button asStampSelector) withChild: (ToImage asTypeSelector).
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#button child:(type:ToImage))'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitChildSelectorWithDepth [

	| selector |
	selector := (#button asStampSelector) withChild: (ToImage asTypeSelector) atDepth: 2.
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#button child:(type:ToImage depth:2))'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitIdSelector [

	| selector |
	selector := #'button-label' asIdSelector.
	selector accept: printer.
	self assert: printer contents equals: 'id:#''button-label'''
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitNotSelector [

	| selector |
	selector := (#'labeled-icon' asStampSelector) not.
	selector accept: printer.
	self assert: printer contents equals: 'not(stamp:#''labeled-icon'')'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitOrSelector [

	| selector |
	selector := #'labeled-icon' asStampSelector || ToImage asTypeSelector.
	selector accept: printer.
	self
		assert: printer contents
		equals: '(stamp:#''labeled-icon'' || type:ToImage)'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitParentSelector [

	| selector |
	selector := (#button asStampSelector) withParent: (ToPane asTypeSelector).
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#button parent:(type:ToPane))'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitParentSelectorWithDepth [

	| selector |
	selector := (#button asStampSelector) withParent: (ToPane asTypeSelector) atDepth: 2.
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#button parent:(type:ToPane depth:2))'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitSiblingSelector [

	| selector |
	selector := (#icon asStampSelector) withSibling: (#label asStampSelector).
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#icon sibling:(stamp:#label))'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitStyleStampSelector [

	| selector |
	selector := #'labeled-icon' asStampSelector.
	selector accept: printer.
	self assert: printer contents equals: 'stamp:#''labeled-icon'''
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitStyleStampSelectorWith2Stamps [

	| selector |
	selector := #(#'button' 'primary') asStampSelector.
	selector accept: printer.
	self assert: printer contents equals: 'stamps:(#button, #primary)'.
	printer reset.
	selector := #(#'button-one' 'primary') asStampSelector.
	selector accept: printer.
	self assert: printer contents equals: 'stamps:(#''button-one'', #primary)'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitTypeSelector [

	| selector |
	selector := ToButton asTypeSelector.
	selector accept: printer.
	self assert: printer contents equals: 'type:ToButton'
]

{ #category : 'tests' }
ToSelectorPrinterTest >> testVisitUniversalSelector [

	| selector |
	selector := ToUniversalSelector new.
	selector accept: printer.
	self assert: printer contents equals: '*'
]
