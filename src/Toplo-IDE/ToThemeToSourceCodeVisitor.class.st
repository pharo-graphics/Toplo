Class {
	#name : #ToThemeToSourceCodeVisitor,
	#superclass : #Object,
	#instVars : [
		'indentLevel',
		'stream',
		'selectorVisitor'
	],
	#classInstVars : [
		'indentLevel'
	],
	#category : #'Toplo-IDE-theme-editor-presenter'
}

{ #category : #accessing }
ToThemeToSourceCodeVisitor >> contents [

	^ self stream contents expandMacros
]

{ #category : #'as yet unclassified' }
ToThemeToSourceCodeVisitor >> generatedComment [

	^ 'This class has been generated using ToThemeToSourceCodeVisitor.<r><r><t>By: <1s><r><t><2s> <3s>'
		expandMacrosWith: Author uniqueInstance fullName
		with: Date today yyyymmdd
		with: Time now print24
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> indentLevel [

	^ indentLevel
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> indentLevel: aNumber [

	indentLevel := aNumber
]

{ #category : #initialization }
ToThemeToSourceCodeVisitor >> initialize [

	indentLevel := 1.
	stream := String new writeStream.
	selectorVisitor := ToSelectorPrinterAsSource new.
]

{ #category : #accessing }
ToThemeToSourceCodeVisitor >> selectorVisitor [

	^ selectorVisitor
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> stream [

	^ stream
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitPropertyBorderColorTransition: aToPropertyBorderColorTransitionAnimation [ 
	self stream << 'ToPropertyBorderColorTransitionAnimation new duration: '.
	self stream << aToPropertyBorderColorTransitionAnimation duration wholeMilliseconds printString.
	self stream << ' milliSeconds'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitPropertyBorderEffectTransitionAnimation: aToPropertyBorderEffectTransitionAnimation [ 
	self stream
	<< 'ToPropertyBorderEffectTransitionAnimation new duration: '.
	self stream
	<<
		aToPropertyBorderEffectTransitionAnimation duration wholeMilliseconds
			printString.
	self stream << ' milliSeconds'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitPropertyColorTransitionAnimation: aToPropertyColorTransitionAnimation [ 
	self stream
	<< 'ToPropertyColorTransitionAnimation new duration: '.
	self stream
	<<
		aToPropertyColorTransitionAnimation duration wholeMilliseconds
			printString.
	self stream << ' milliSeconds'
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitPropertyWriter: aToPropertyWriter [

	self stream << ('<t>' repeat: self indentLevel).
	self stream << 'self<r>'.
	self indentLevel: self indentLevel + 1.
	self stream << ('<t>' repeat: self indentLevel).
	self stream << 'when: '.
	self stream << aToPropertyWriter eventClass printString.
	self stream << '<r>'.
	self stream << ('<t>' repeat: self indentLevel).
	self stream << 'write: (self property:'.
	self stream << aToPropertyWriter property name asSymbol printString.
	self stream << ')<r>'.
	self stream << ('<t>' repeat: self indentLevel).
	self stream << 'with: ('.
	self stream << aToPropertyWriter value printString.
	self stream << ')<r>'.
	self stream << ('<t>' repeat: self indentLevel).
	self stream << 'animation: ('.
	aToPropertyWriter animation
		ifNil: [ self stream << 'nil' ]
		ifNotNil: [ aToPropertyWriter animation accept: self ].
	self stream << ').<r>'.
	self indentLevel: self indentLevel - 1
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitStyleRule: aToStyleRule [

	self stream << ('<t>' repeat: self indentLevel).
	self stream << 'self select: ('.
	aToStyleRule selector accept: self selectorVisitor.
	self stream << self selectorVisitor contents.
	self selectorVisitor reset.
	self stream << ') style: [<r>'.
	self indentLevel: self indentLevel + 1.
	aToStyleRule lookEventListeners do: [ :each | each accept: self ].
	aToStyleRule styleRules do: [ :each | each accept: self ].
	self stream << ('<t>' repeat: self indentLevel).
	self stream << '].<r>'.
	self indentLevel: self indentLevel - 1
]

{ #category : #visiting }
ToThemeToSourceCodeVisitor >> visitStyleSheetTheme: aToStyleTheme [
	"heelo"

	self stream << 'initializeStyleRules<r><t>'.
	self stream << '"'.
	self stream << self generatedComment.
	self stream << '"<r><r>'.
	aToStyleTheme styleRules do: [ :each | each accept: self ]
]
