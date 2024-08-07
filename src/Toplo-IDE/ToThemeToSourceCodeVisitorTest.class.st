Class {
	#name : #ToThemeToSourceCodeVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'printer'
	],
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #running }
ToThemeToSourceCodeVisitorTest >> setUp [

	super setUp.
	printer := ToThemeToSourceCodeVisitor new
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> test1 [

	| selector |
	selector := #stamp asStampSelector.
	selector accept: printer.
	self
		assert: printer contents
		equals:
		'#stamp asStampSelector'.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> test2 [

	| selector |
	selector := ToButton asTypeSelector.
	selector accept: printer.
	self
		assert: printer contents
		equals:
		'ToButton asTypeSelector'.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> test3 [

	| selector |
	selector := #( #stamp1 #stamp2 #stamp3 ) asStampSelector not.
	selector accept: printer.
	self
		assert: printer contents
		equals:
	'(#(#stamp1 #stamp2 #stamp3) asStampSelector) not'.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> test4 [

	| selector |
	selector := #'button-label' asStampSelector
		            withParent:
		            #button asStampSelector && #danger asStampSelector
		            atDepth: 3.
	selector accept: printer.
	self
		assert: printer contents
		equals:
		'(#''button-label'' asStampSelector) withParent: ((#button asStampSelector) && (#danger asStampSelector)) atDepth: 3'.
	self testCompileSelector: selector.
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> test5 [

	| selector |
	selector := ((ToStampSelector new addStamp: #stamp1)
		             withParent: (ToStampSelector new
				              addStamp: #a;
				              addStamp: #b;
				              yourself) && (ToStampSelector new addStamp: #stamp2)
		             atDepth: 4)
	            && ((ToStampSelector new addStamp: #'no-this-one')
			             withParent: (ToStampSelector new
					              addStamp: #a;
					              addStamp: #b;
					              yourself)
				             && (ToStampSelector new addStamp: #stamp2)
			             atDepth: 2) not.
	selector accept: printer.
	self
		assert: printer contents
		equals:
		'((#stamp1 asStampSelector) withParent: ((#(#a #b) asStampSelector) && (#stamp2 asStampSelector)) atDepth: 4) && (((#''no-this-one'' asStampSelector) withParent: ((#(#a #b) asStampSelector) && (#stamp2 asStampSelector)) atDepth: 2) not)'.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> test6 [

	| selector |
	selector := (((ToUniversalSelector new withParent:
		               #parent asStampSelector not)
	              && (#test asIdSelector withSibling:
			               #( #stamp1 #stamp2 #stamp3 ) asStampSelector)
	              || ToButton asTypeSelector withChild:
		              (#toto asStampSelector
			               withChild: #titi asStampSelector
			               atDepth: 5)
		              && (ToButton asTypeSelector exact: false))
		             withParent: #hello asStampSelector
		             atDepth: 2) not.
	selector accept: printer.
	self
		assert: printer contents
		equals:
		'((((((ToUniversalSelector new) withParent: ((#parent asStampSelector) not)) && ((#test asIdSelector) withSibling: (#(#stamp1 #stamp2 #stamp3) asStampSelector))) || (ToButton asTypeSelector)) withChild: (((#toto asStampSelector) withChild: (#titi asStampSelector) atDepth: 5) && (( ToButton asTypeSelector ) exact: false; yourself))) withParent: (#hello asStampSelector) atDepth: 2) not'.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testAndNot [

	| selector |
	selector := #'labeled-icon' asStampSelector
	            && ToImage asTypeSelector not.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testCompileSelector: aSelector [

	| newSelector |
	newSelector := self class compiler
		               source: printer contents;
		               evaluate.

	self assert: aSelector equals: newSelector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitActionSelector [

	| selector newSelector |
	selector := [ :e | e isKindOf: ToButton ] asActionSelector.
	selector accept: printer.
	self
		assert: printer contents
		equals: '[ :e | e isKindOf: ToButton ] asActionSelector'.

	"Custom compiller test for action because context is different."
	newSelector := self class compiler
		               source: printer contents;
		               evaluate.
		self assert: selector action printString equals: newSelector action printString 
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitAndSelector [

	| selector |
	selector := #'labeled-icon' asStampSelector && ToImage asTypeSelector.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitChildSelector [

	| selector |
	selector := #button asStampSelector withChild: ToImage asTypeSelector.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitChildSelectorWithDepth [

	| selector |
	selector := #button asStampSelector
		            withChild: ToImage asTypeSelector
		            atDepth: 2.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitIdSelector [

	| selector |
	selector := #'button-label' asIdSelector.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitNotSelector [

	| selector |
	selector := #'labeled-icon' asStampSelector not.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitOrSelector [

	| selector |
	selector := #'labeled-icon' asStampSelector || ToImage asTypeSelector.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitParentSelector [

	| selector |
	selector := #button asStampSelector withParent: ToPane asTypeSelector.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitParentSelectorWithDepth [

	| selector |
	selector := #button asStampSelector
		            withParent: ToPane asTypeSelector
		            atDepth: 2.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitSiblingSelector [

	| selector |
	selector := #icon asStampSelector withSibling: #label asStampSelector.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitStyleStampSelector [

	| selector |
	selector := #'labeled-icon' asStampSelector.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitStyleStampSelectorWith2Stamps [

	| selector |
	selector := #( #button 'primary' ) asStampSelector.
	selector accept: printer.
	self testCompileSelector: selector.
	printer reset.
	selector := #( #'button-one' 'primary' ) asStampSelector.
	selector accept: printer.
	self testCompileSelector: selector
	
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitTypeSelector [

	| selector |
	selector := ToButton asTypeSelector.
	selector accept: printer.
	self testCompileSelector: selector
]

{ #category : #tests }
ToThemeToSourceCodeVisitorTest >> testVisitUniversalSelector [

	| selector |
	selector := ToUniversalSelector new.
	selector accept: printer.
	self testCompileSelector: selector
]
