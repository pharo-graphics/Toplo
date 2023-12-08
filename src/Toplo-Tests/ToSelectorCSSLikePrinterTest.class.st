Class {
	#name : 'ToSelectorCSSLikePrinterTest',
	#superclass : 'TestCase',
	#instVars : [
		'printer'
	],
	#category : 'Toplo-Tests-Core-Selectors',
	#package : 'Toplo-Tests',
	#tag : 'Core-Selectors'
}

{ #category : 'running' }
ToSelectorCSSLikePrinterTest >> setUp [ 


	super setUp.
	printer := ToSelectorCSSLikePrinter new
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> test1 [

	| selector |
	selector := (ToStampSelector new addStamp: #'button-label')
			         withParent: (ToStampSelector new addStamp: #button)
				         + (ToStampSelector new addStamp: #danger)
			         atDepth: 1.
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#''button-label'' parent:((stamp:#button + stamp:#danger) depth:1))'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> test2 [

	| selector |
	selector := ((ToStampSelector new addStamp: #'button-label')
		             withParent: (ToStampSelector new addStamp: #button)
			             + (ToStampSelector new addStamp: #danger)
		             atDepth: 1)
	            - ((ToStampSelector new addStamp: #'button-label')
			             withParent: (ToStampSelector new addStamp: #button)
				             + (ToStampSelector new addStamp: #danger)
			             atDepth: 1).
	selector accept: printer.
	self
		assert: printer contents
		equals:
		'((stamp:#''button-label'' parent:((stamp:#button + stamp:#danger) depth:1)) - (stamp:#''button-label'' parent:((stamp:#button + stamp:#danger) depth:1)))'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitActionSelector [

	| selector |
	selector := [ :e | e isKindOf: ToButton ] asActionSelector.
	selector accept: printer.
	self assert: printer contents equals: 'action:[ :e | e isKindOf: ToButton ]'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitAndSelector [

	| selector |
	selector := (#'labeled-icon' asStampSelector) + (ToImage asTypeSelector).
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#''labeled-icon'' + type:ToImage)'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitChildSelector [

	| selector |
	selector := (#button asStampSelector) withChild: (ToImage asTypeSelector).
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#button child:(type:ToImage))'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitChildSelectorWithDepth [

	| selector |
	selector := (#button asStampSelector) withChild: (ToImage asTypeSelector) atDepth: 2.
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#button child:(type:ToImage depth:2))'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitIdSelector [

	| selector |
	selector := #'button-label' asIdSelector.
	selector accept: printer.
	self assert: printer contents equals: '#button-label'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitMinusSelector [

	| selector |
	selector := (#'labeled-icon' asStampSelector) - (ToImage asTypeSelector).
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#''labeled-icon'' - type:ToImage)'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitNotSelector [

	| selector |
	selector := (#'labeled-icon' asStampSelector) not.
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#''labeled-icon'') not'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitOrSelector [

	| selector |
	selector := (#'labeled-icon' asStampSelector) or: (ToImage asTypeSelector).
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#''labeled-icon'' or: type:ToImage)'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitParentSelector [

	| selector |
	selector := (#button asStampSelector) withParent: (ToPane asTypeSelector).
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#button parent:(type:ToPane))'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitParentSelectorWithDepth [

	| selector |
	selector := (#button asStampSelector) withParent: (ToPane asTypeSelector) atDepth: 2.
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#button parent:(type:ToPane depth:2))'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitSiblingSelector [

	| selector |
	selector := (#icon asStampSelector) withSibling: (#label asStampSelector).
	selector accept: printer.
	self assert: printer contents equals: '(stamp:#icon sibling:(stamp:#label))'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitStyleStampSelector [

	| selector |
	selector := #'labeled-icon' asStampSelector.
	selector accept: printer.
	self assert: printer contents equals: '.labeled-icon'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitStyleStampSelectorWith2Stamps [

	| selector |
	selector := #(#'button' 'primary') asStampSelector.
	selector accept: printer.
	self assert: printer contents equals: '.button, .primary'.
	printer reset.
	selector := #(#'button-one' 'primary') asStampSelector.
	selector accept: printer.
	self assert: printer contents equals: '.button-one, .primary'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitTypeSelector [

	| selector |
	selector := ToButton asTypeSelector.
	selector accept: printer.
	self assert: printer contents equals: 'type:ToButton'
]

{ #category : 'tests' }
ToSelectorCSSLikePrinterTest >> testVisitUniversalSelector [

	| selector |
	selector := ToUniversalSelector new.
	selector accept: printer.
	self assert: printer contents equals: '*'
]
