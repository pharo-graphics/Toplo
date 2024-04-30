Class {
	#name : #ToThemeToSourceCodeVisitor,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#classInstVars : [
		'indentLevel'
	],
	#category : #'Toplo-IDE-theme-serialization'
}

{ #category : #accessing }
ToThemeToSourceCodeVisitor >> contents [

	^self stream contents expandMacros.
]

{ #category : #initialization }
ToThemeToSourceCodeVisitor >> initialize [

	stream := String new writeStream.
]

{ #category : #accessing }
ToThemeToSourceCodeVisitor >> nextPut: aString [

	stream nextPutAll: aString
]

{ #category : #initialization }
ToThemeToSourceCodeVisitor >> reset [

	self stream reset
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> stream [

	^ stream
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitActionSelector: aSelector [

	self nextPut: aSelector action printString.
	self nextPut: ' asActionSelector'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitAndSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') && ('.
	aSelector right accept: self.
	self nextPut: ')'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitChildSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') withChild: ('.

	aSelector depth
		ifNil: [
			aSelector right accept: self.
			self nextPut: ')' ]
		ifNotNil: [
			aSelector right accept: self.
			self nextPut: ') atDepth: '.
			self nextPut: aSelector depth printString ]
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitIdSelector: aSelector [

	self nextPut: aSelector  id printString .self nextPut: ' asIdSelector'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitLookEventAction: aToLookEventAction [ 

	self nextPut: 'self when: '.
	self nextPut: aToLookEventAction eventClass printString.
	self nextPut: ' do: '.
	self nextPut: aToLookEventAction action printString.
	self nextPut: '.<r>'.
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitNotSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') not'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitOrSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') || ('.
	aSelector right accept: self.
	self nextPut: ')'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitParentSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') withParent: ('.

	aSelector depth
		ifNil: [
			aSelector right accept: self.
			self nextPut: ')' ]
		ifNotNil: [
			aSelector right accept: self.
			self nextPut: ') atDepth: '.
			self nextPut: aSelector depth printString ]
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitPropertyBorderColorTransition: aToPropertyBorderColorTransitionAnimation [

	self nextPut: 'ToPropertyBorderColorTransitionAnimation new duration: '.
	self nextPut:
		aToPropertyBorderColorTransitionAnimation duration wholeMilliseconds
			printString.
	self nextPut: ' milliSeconds; yourself'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitPropertyBorderEffectTransitionAnimation: aToPropertyBorderEffectTransitionAnimation [

	self nextPut: 'ToPropertyBorderEffectTransitionAnimation new duration: '.
	self nextPut:
		aToPropertyBorderEffectTransitionAnimation duration
			wholeMilliseconds printString.
	self nextPut: ' milliSeconds; yourself'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitPropertyColorTransitionAnimation: aToPropertyColorTransitionAnimation [

	self nextPut: 'ToPropertyColorTransitionAnimation new duration: '.
	self nextPut: aToPropertyColorTransitionAnimation duration wholeMilliseconds
			printString.
	self nextPut: ' milliSeconds; yourself'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitPropertyWriter: aToPropertyWriter [

	self nextPut: 'self when: '.
	self nextPut: aToPropertyWriter eventClass printString.
	self nextPut: ' write: (self property:'.
	self nextPut: aToPropertyWriter property name asSymbol printString.
	self nextPut: ') with: ('.
	self nextPut: aToPropertyWriter value printString.
	self nextPut: ') animation: ('.
	aToPropertyWriter animation
		ifNil: [ self nextPut: 'nil' ]
		ifNotNil: [ aToPropertyWriter animation accept: self ].
	self nextPut: ').<r>'.
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitPropertyWriterForSupplement: aToPropertyWriter [

	self nextPut: 'self when: '.
	self nextPut: aToPropertyWriter eventClass printString.
	self nextPut: ' supplement: (self property:'.
	self nextPut: aToPropertyWriter property name asSymbol printString.
	self nextPut: ') with: ('.
	self nextPut: aToPropertyWriter value printString.
	self nextPut: ') animation: ('.
	aToPropertyWriter animation
		ifNil: [ self nextPut: 'nil' ]
		ifNotNil: [ aToPropertyWriter animation accept: self ].
	self nextPut: ').<r>'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitSiblingSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') withSibling: ('.
	aSelector right accept: self.
	self nextPut: ')'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitStyleRule: aToStyleRule [

	self nextPut: 'self select: ('.
	aToStyleRule selector accept: self.
	self nextPut: ') style: [<r>'.
	aToStyleRule lookEventListeners do: [ :each | each accept: self ].
	aToStyleRule styleRules do: [ :each | each accept: self ].
	self nextPut: '].<r>'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitStyleSheetTheme: aToStyleTheme [

	aToStyleTheme styleRules do: [ :each | each accept: self ]
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitStyleStampSelector: aSelector [

	aSelector allStamps size = 1
		ifTrue: [ self nextPut: aSelector allStamps first printString ]
		ifFalse: [ self nextPut: aSelector allStamps printString ].
	self nextPut: ' asStampSelector'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitToken: aToTokenProperty [

	self nextPut: 'ToTokenProperty name: '.
	self nextPut: aToTokenProperty name printString.
	self nextPut: ' value: '.
	self nextPut: aToTokenProperty value printString
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitTokensHolder: aTokenHolder [

	self nextPut: '{'.
	aTokenHolder tokens do: [ :each | each accept: self ] separatedBy: [ self nextPut: '.<r>' ].
	self nextPut: '}'.
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitTypeSelector: aSelector [

	aSelector exact ifTrue: [
		self nextPut: aSelector type printString .
		self nextPut: ' asTypeSelector' ] ifFalse: [ self nextPut: '( '.
		self nextPut: aSelector type printString.
		self nextPut: ' asTypeSelector ) exact: false; yourself'. ].

]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitUniversalSelector: aSelector [

	self nextPut: aSelector  class name .self nextPut: ' new'
]
