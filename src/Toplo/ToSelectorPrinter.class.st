Class {
	#name : 'ToSelectorPrinter',
	#superclass : 'ToElementSelectorVisitor',
	#instVars : [
		'stream'
	],
	#category : 'Toplo-Core-Selectors',
	#package : 'Toplo',
	#tag : 'Core-Selectors'
}

{ #category : 'accessing' }
ToSelectorPrinter >> contents [
	
	^ stream contents
]

{ #category : 'initialization' }
ToSelectorPrinter >> initialize [ 

	super initialize.
	stream := String new writeStream
]

{ #category : 'accessing' }
ToSelectorPrinter >> nextPut: aString [

	stream nextPutAll: aString
]

{ #category : 'initialization' }
ToSelectorPrinter >> reset [

	stream reset


]

{ #category : 'visiting' }
ToSelectorPrinter >> visitActionSelector: aSelector [

	self nextPut: 'action:'.
	self nextPut: aSelector action printString
]

{ #category : 'visiting' }
ToSelectorPrinter >> visitAndSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' + '.
	aSelector right accept: self.
	self nextPut: ')'.
]

{ #category : 'visiting' }
ToSelectorPrinter >> visitChildSelector: aSelector [

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
ToSelectorPrinter >> visitIdSelector: aSelector [

	self nextPut: 'id:'.
	self nextPut: aSelector id printString
]

{ #category : 'visiting' }
ToSelectorPrinter >> visitMinusSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' - '.
	aSelector right accept: self.
	self nextPut: ')'.
]

{ #category : 'visiting' }
ToSelectorPrinter >> visitNotSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ') not'.
]

{ #category : 'visiting' }
ToSelectorPrinter >> visitOrSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' or: '.
	aSelector right accept: self.
	self nextPut: ')'.
]

{ #category : 'visiting' }
ToSelectorPrinter >> visitParentSelector: aSelector [

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
ToSelectorPrinter >> visitSiblingSelector: aSelector [

	self nextPut: '('.
	aSelector left accept: self.
	self nextPut: ' sibling:('.
	aSelector right accept: self.
	self nextPut: ')'.
	self nextPut: ')'

]

{ #category : 'visiting' }
ToSelectorPrinter >> visitStyleStampSelector: aSelector [

	aSelector allStamps size = 1
		ifTrue: [
			self nextPut: 'stamp:'.
			self nextPut: aSelector allStamps anyOne printString ]
		ifFalse: [
			self nextPut: 'stamps:('.
			aSelector allStamps
				do: [ :stp | self nextPut: stp printString ]
				separatedBy: [ self nextPut: ', ' ].
			self nextPut: ')' ]
]

{ #category : 'visiting' }
ToSelectorPrinter >> visitTypeSelector: aSelector [

	self nextPut: 'type:'.
	self nextPut: aSelector type name
]

{ #category : 'visiting' }
ToSelectorPrinter >> visitUniversalSelector: aSelector [

	self nextPut: '*'
]
