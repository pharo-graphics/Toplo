Class {
	#name : 'ToStyleSheetPrinter',
	#superclass : 'Object',
	#instVars : [
		'styleSheet'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'accessing' }
ToStyleSheetPrinter class >> styleRules: aStyleRuleList [

	^ self new styleSheet: (ToStyleSheet new addAllStyleRules: aStyleRuleList)
]

{ #category : 'accessing' }
ToStyleSheetPrinter class >> styleSheet: aToStyleSheet [

	^ self new styleSheet: aToStyleSheet
]

{ #category : 'converting' }
ToStyleSheetPrinter >> asCSSString [

	| stream |
	stream := ReadWriteStream on: String new.
	self printStyleSheetCSSOn: stream.
	^ stream contents
]

{ #category : 'printing' }
ToStyleSheetPrinter >> getSelectorCSS: aToElementSelector hangSelector: aSelector [
	"https://www.w3schools.com/cssref/css_selectors.php"
	
	| stream |
	stream := ReadWriteStream on: String new.
	aSelector ifNotNil:[ stream nextPutAll: aSelector ].
	
	"Stamp selector (class in CSS) => .stamp"
	aToElementSelector class = ToStampSelector ifTrue:[
		aSelector ifNotNil:[ stream space ].
		aToElementSelector stampNames do:[ :s |
			stream nextPutAll: '.'; nextPutAll: s asString.	
		]. 	
		^ stream contents
	].

	"Type selector (element in CSS) => type"
	aToElementSelector class = ToTypeSelector ifTrue:[
		aSelector ifNotNil:[ stream space ].
		stream nextPutAll: aToElementSelector type asString.
		^ stream contents
	].

	"Universal selector (all in CSS) => *"
	aToElementSelector class = ToUniversalSelector ifTrue:[
		aSelector ifNotNil:[ stream space ].
		stream nextPutAll: '*'.
		^ stream contents
	].

	"Not selector (not in CSS) => :not(selector)"
	aToElementSelector class = ToNotSelector ifTrue:[ | selector |
		stream nextPutAll: ':not('.
		selector := self getSelectorCSS: aToElementSelector left hangSelector: nil.
		stream nextPutAll: selector.
		stream nextPutAll: ')'.
		^ stream contents
	].	
	
	"Action selector (attribute in CSS) => [attribute]"
	aToElementSelector class = ToActionSelector ifTrue:[
		stream nextPutAll: aToElementSelector action asString.
		^ stream contents
	].	
	
	"Parent selector (parent in CSS) => parent > child"
	aToElementSelector class = ToParentSelector ifTrue:[ | parentSelector childSelector |
		parentSelector := self getSelectorCSS: aToElementSelector right hangSelector: nil.
		childSelector := self getSelectorCSS: aToElementSelector left hangSelector: nil.
		stream nextPutAll: parentSelector.
		stream nextPutAll: ' > '.
		stream nextPutAll: childSelector.
		^ stream contents
	].	
	
	"Sibling selector (parent in CSS) => parent > child"
	aToElementSelector class = ToSiblingSelector ifTrue:[ | brotherSelector selector |
		brotherSelector := self getSelectorCSS: aToElementSelector right hangSelector: nil.
		selector := self getSelectorCSS: aToElementSelector left hangSelector: nil.
		stream nextPutAll: brotherSelector.
		stream nextPutAll: ' + '.
		stream nextPutAll: selector.
		^ stream contents
	].	
	
	stream nextPutAll: '[Not supported Selector]'.
	^ stream contents
]

{ #category : 'printing' }
ToStyleSheetPrinter >> printStyleRuleCSS: aStyleRule on: aStream hangSelector: aSelector [
		
	"print selector"
	| selector |
	selector := self getSelectorCSS: aStyleRule selector hangSelector: aSelector.
	aStream nextPutAll: selector.
	
	"print begin of body"
	aStream space; nextPutAll: '{'; cr.

	"print body"
	aStyleRule writers do:[ :w | 
		"w printOnStyleSheet: aStream."
		aStream cr.
	].
 
	"print end of body"
	aStream cr; nextPutAll: '}'; cr.
	
	"print sub rules"
	aStyleRule styleRules do:[ :rule | 
		self printStyleRuleCSS: rule on: aStream hangSelector: selector.
	].
]

{ #category : 'printing' }
ToStyleSheetPrinter >> printStyleSheetCSSOn: aStream [

	self styleRules do:[ :rule |
		self printStyleRuleCSS: rule on: aStream hangSelector: nil. 		
	].
]

{ #category : 'rules' }
ToStyleSheetPrinter >> styleRules [

	^ self styleSheet styleRules
]

{ #category : 'accessing' }
ToStyleSheetPrinter >> styleSheet [

	^ styleSheet
]

{ #category : 'accessing' }
ToStyleSheetPrinter >> styleSheet: anObject [

	styleSheet := anObject
]
