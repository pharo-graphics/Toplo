Class {
	#name : 'ToSelectorCSSLikePrinter',
	#superclass : 'ToElementSelectorVisitor',
	#instVars : [
		'stream'
	],
	#category : 'Toplo-Core-Selectors',
	#package : 'Toplo',
	#tag : 'Core-Selectors'
}

{ #category : 'accessing' }
ToSelectorCSSLikePrinter >> contents [
	
	^ stream contents
]

{ #category : 'initialization' }
ToSelectorCSSLikePrinter >> initialize [ 

	super initialize.
	stream := String new writeStream
]

{ #category : 'private' }
ToSelectorCSSLikePrinter >> nextPut: aString [

	stream nextPutAll: aString
]

{ #category : 'initialization' }
ToSelectorCSSLikePrinter >> reset [

	stream reset


]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitActionSelector: aSelector [

	self nextPut: 'action:'.
	self nextPut: aSelector action printString
]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitAndSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' + '.
	aSelector right accept: self.
	self nextPut: ')'.
]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitChildSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' child:('.

	aSelector depth ifNil: [ aSelector right accept: self ] ifNotNil: [
		aSelector right accept: self.
		self nextPut: ' depth:'.
		self nextPut: aSelector depth printString ].
	self nextPut: ')'.
	self nextPut: ')'

]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitIdSelector: aSelector [

	self nextPut: '#'.
	self nextPut: aSelector id asString
]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitMinusSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' - '.
	aSelector right accept: self.
	self nextPut: ')'.
]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitNotSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') not'.
]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitOrSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' or: '.
	aSelector right accept: self.
	self nextPut: ')'.
]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitParentSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' parent:('.

	aSelector depth ifNil: [ aSelector right accept: self ] ifNotNil: [
		aSelector right accept: self.
		self nextPut: ' depth:'.
		self nextPut: aSelector depth printString ].
	self nextPut: ')'.
	self nextPut: ')'

]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitSiblingSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' sibling:('.
	aSelector right accept: self.
	self nextPut: ')'.
	self nextPut: ')'

]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitStyleStampSelector: aSelector [

	aSelector allStamps
		do: [ :stp |
			self nextPut: '.'.
			self nextPut: stp asString ]
		separatedBy: [ self nextPut: ', ' ]
]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitTypeSelector: aSelector [

	self nextPut: 'type:'.
	self nextPut: aSelector type name
]

{ #category : 'visiting' }
ToSelectorCSSLikePrinter >> visitUniversalSelector: aSelector [

	self nextPut: '*'
]
