Class {
	#name : #ToSelectorPrinterAsSource,
	#superclass : #ToElementSelectorVisitor,
	#instVars : [
		'stream',
		'indentLevel'
	],
	#category : #'Toplo-Core-Selectors'
}

{ #category : #accessing }
ToSelectorPrinterAsSource >> contents [
	
	^ stream contents
]

{ #category : #initialization }
ToSelectorPrinterAsSource >> initialize [ 

	super initialize.
	stream := String new writeStream.
	indentLevel := 0
]

{ #category : #private }
ToSelectorPrinterAsSource >> nextPut: aString [

	stream nextPutAll: aString
]

{ #category : #initialization }
ToSelectorPrinterAsSource >> reset [

	stream reset


]

{ #category : #accessing }
ToSelectorPrinterAsSource >> stream: aStream [

	stream := aStream
]

{ #category : #visiting }
ToSelectorPrinterAsSource >> visitActionSelector: aSelector [

	self nextPut: aSelector action printString.
	self nextPut: ' asActionSelector'
]

{ #category : #visiting }
ToSelectorPrinterAsSource >> visitAndSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') && ('.
	aSelector right accept: self.
	self nextPut: ')'
]

{ #category : #visiting }
ToSelectorPrinterAsSource >> visitChildSelector: aSelector [

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
ToSelectorPrinterAsSource >> visitIdSelector: aSelector [

	self nextPut: aSelector  id printString .self nextPut: ' asIdSelector'
]

{ #category : #visiting }
ToSelectorPrinterAsSource >> visitNotSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') not'
]

{ #category : #visiting }
ToSelectorPrinterAsSource >> visitOrSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') || ('.
	aSelector right accept: self.
	self nextPut: ')'
]

{ #category : #visiting }
ToSelectorPrinterAsSource >> visitParentSelector: aSelector [

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
ToSelectorPrinterAsSource >> visitSiblingSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') withSibling: ('.
	aSelector right accept: self.
	self nextPut: ')'
]

{ #category : #visiting }
ToSelectorPrinterAsSource >> visitStyleStampSelector: aSelector [

	aSelector allStamps size = 1
		ifTrue: [
			self nextPut: aSelector allStamps first printString ]
		ifFalse: [
			self nextPut: aSelector allStamps printString.
			 ].
		self nextPut: ' asStampSelector'
]

{ #category : #visiting }
ToSelectorPrinterAsSource >> visitTypeSelector: aSelector [

	aSelector exact ifTrue: [
		self nextPut: aSelector type printString .
		self nextPut: ' asTypeSelector' ] ifFalse: [ self nextPut: '( '.
		self nextPut: aSelector type printString.
		self nextPut: ' asTypeSelector ) exact: false; yourself'. ].

]

{ #category : #visiting }
ToSelectorPrinterAsSource >> visitUniversalSelector: aSelector [

	self nextPut: aSelector  class name .self nextPut: ' new'
]
